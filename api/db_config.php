<?php
$host = "localhost"; // MySQL server address
$user = "root"; // MySQL username
$password = ""; // MySQL password
$database = "skbt"; // Database name

try {
    $conn = new PDO("mysql:host=$host;dbname=$database", $user, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // Enable exceptions for errors
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}
?>