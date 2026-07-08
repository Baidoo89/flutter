<?php
/**
 * One-click setup script. Open this file in the browser first:
 * http://localhost/gctu_api/setup/setup.php
 */

header('Content-Type: text/plain; charset=utf-8');

require __DIR__ . '/config-db.php';
require __DIR__ . '/tables.php';

echo "\nSetup complete. Test Server 2 with student ID GHA-726767000-3.\n";
