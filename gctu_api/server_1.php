<?php
/**
 * Server 1: demonstration client that requests student information from Server 2.
 * Run this in the browser after running setup/setup.php, or call it from the PHP server.
 */

$studentId = $_GET['student_id'] ?? 'GHA-726767000-3';
$server2Url = 'http://localhost/gctu_api/server_2.php';

$payload = [
    'student_id' => $studentId,
    'request_source' => 'Server_1',
    'opt' => 'getInfo',
];

$ch = curl_init($server2Url);
curl_setopt_array($ch, [
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => json_encode($payload),
    CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_TIMEOUT => 15,
]);

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$error = curl_error($ch);
curl_close($ch);

header('Content-Type: application/json; charset=utf-8');

if ($response === false) {
    http_response_code(502);
    echo json_encode([
        'status' => 'error',
        'message' => 'Unable to contact Server 2.',
        'details' => $error,
    ], JSON_PRETTY_PRINT);
    exit;
}

http_response_code($httpCode ?: 200);
echo json_encode([
    'status' => 'success',
    'message' => 'Server 1 request completed.',
    'sent_payload' => $payload,
    'server_2_response' => json_decode($response, true) ?? $response,
], JSON_PRETTY_PRINT);
