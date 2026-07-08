<?php
require_once __DIR__ . '/../config.php';

header('Content-Type: text/plain; charset=utf-8');

try {
    $conn = db_connect();

    $conn->query(<<<SQL
CREATE TABLE IF NOT EXISTS public_info_tbl (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    card_number VARCHAR(30) NOT NULL UNIQUE,
    surname VARCHAR(150) NOT NULL,
    firstname VARCHAR(100) NOT NULL,
    sex VARCHAR(10) NOT NULL,
    dob DATE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    digital_address VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
SQL);

    $seedStudents = [
        ['GHA-726767000-3', 'Baidoo', 'Benjamin', 'Male', '2002-05-14', '0240000000', 'benjamin.baidoo@gctu.edu.gh', 'GA-123-4567'],
        ['GHA-100200300-4', 'Mensah', 'Ama', 'Female', '2001-09-22', '0551234567', 'ama.mensah@gctu.edu.gh', 'GA-456-7890'],
        ['GHA-998877665-1', 'Asare', 'Kwame', 'Male', '2000-12-03', '0209876543', 'kwame.asare@gctu.edu.gh', 'AK-233-9090'],
    ];

    $stmt = $conn->prepare(
        'INSERT INTO public_info_tbl (card_number, surname, firstname, sex, dob, phone, email, digital_address)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?)
         ON DUPLICATE KEY UPDATE
            surname = VALUES(surname),
            firstname = VALUES(firstname),
            sex = VALUES(sex),
            dob = VALUES(dob),
            phone = VALUES(phone),
            email = VALUES(email),
            digital_address = VALUES(digital_address)'
    );

    foreach ($seedStudents as $student) {
        $stmt->bind_param('ssssssss', ...$student);
        $stmt->execute();
    }

    $stmt->close();
    $conn->close();

    echo "Table public_info_tbl is ready.\n";
    echo count($seedStudents) . " sample student records inserted or updated.\n";
} catch (Throwable $e) {
    http_response_code(500);
    echo 'Table setup failed: ' . $e->getMessage() . "\n";
}
