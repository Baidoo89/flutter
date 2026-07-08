<?php
/**
 * Server 2: JSON API endpoint for retrieving public student information.
 * Expected JSON body:
 * {
 *   "student_id": "GHA-726767000-3",
 *   "request_source": "Server_1",
 *   "opt": "getInfo"
 * }
 */

require_once __DIR__ . '/config.php';

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST, OPTIONS');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

function respond(int $code, array $body): void
{
    http_response_code($code);
    echo json_encode($body, JSON_PRETTY_PRINT);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respond(405, [
        'status' => 'error',
        'message' => 'Only POST requests are allowed.',
    ]);
}

$rawBody = file_get_contents('php://input');
$input = json_decode($rawBody, true);

if (!is_array($input)) {
    respond(400, [
        'status' => 'error',
        'message' => 'Invalid JSON request body.',
    ]);
}

$studentId = trim((string)($input['student_id'] ?? ''));
$requestSource = trim((string)($input['request_source'] ?? $input['reqstSrc'] ?? ''));
$option = trim((string)($input['opt'] ?? ''));

$errors = [];
if ($studentId === '') {
    $errors['student_id'] = 'Student ID is required.';
}
if ($requestSource === '') {
    $errors['request_source'] = 'Request source is required.';
}
if ($option === '') {
    $errors['opt'] = 'Operation option is required.';
}
if ($errors !== []) {
    respond(422, [
        'status' => 'error',
        'message' => 'Validation failed.',
        'errors' => $errors,
    ]);
}

$allowedSources = ['Server_1', 'Sever_1']; // Accept old typo for backward compatibility.
if (!in_array($requestSource, $allowedSources, true)) {
    respond(403, [
        'status' => 'error',
        'message' => 'Invalid request source.',
    ]);
}

if ($option !== 'getInfo') {
    respond(400, [
        'status' => 'error',
        'message' => 'Invalid request option. Use getInfo.',
    ]);
}

try {
    $conn = db_connect();
    $stmt = $conn->prepare(
        'SELECT card_number, surname, firstname, sex, dob, phone, email, digital_address
         FROM public_info_tbl
         WHERE card_number = ?
         LIMIT 1'
    );
    $stmt->bind_param('s', $studentId);
    $stmt->execute();
    $student = $stmt->get_result()->fetch_assoc();
    $stmt->close();
    $conn->close();
} catch (Throwable $e) {
    respond(500, [
        'status' => 'error',
        'message' => 'Database error. Run setup/setup.php and confirm MySQL is running.',
    ]);
}

if (!$student) {
    respond(404, [
        'status' => 'error',
        'message' => 'Student not found.',
    ]);
}

respond(200, [
    'status' => 'success',
    'message' => 'Student record found.',
    'data' => $student,
]);
