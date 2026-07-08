<?php
/**
 * Shared database configuration for the GCTU student information API.
 * Update these constants if your MySQL username, password, host, or database changes.
 */

const DB_HOST = 'localhost';
const DB_USER = 'root';
const DB_PASSWORD = '';
const DB_NAME = 'gctu_api_db';

function db_connect(bool $selectDatabase = true): mysqli
{
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    $database = $selectDatabase ? DB_NAME : null;
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, $database);
    $conn->set_charset('utf8mb4');

    return $conn;
}
