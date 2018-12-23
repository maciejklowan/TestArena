<?php

require __DIR__.'/vendor/autoload.php';

/*
 * Run PHPloy
 */
try {
    $phploy = new Banago\PHPloy\PHPloy();
} catch (Exception $e) {
    echo "\r\nOh Snap: {$e->getMessage()}\r\n";
    // Return 1 to indicate error to caller
    exit(1);
}
