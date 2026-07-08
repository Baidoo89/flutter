<?php
require_once __DIR__ . '/../config.php';

header('Content-Type: text/plain; charset=utf-8');

try {
    $conn = db_connect(false);
    $conn->query('CREATE DATABASE IF NOT EXISTS `' . DB_NAME . '` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci');
    echo "Database " . DB_NAME . " is ready.\n";
    $conn->close();
} catch (Throwable $e) {
    http_response_code(500);
    echo 'Database setup failed: ' . $e->getMessage() . "\n";
}
