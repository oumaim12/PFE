<?php
require_once 'db_config.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        $data = json_decode(file_get_contents("php://input"), true);
        
        // Required fields validation
        if (!isset($data['name']) || !isset($data['email']) || !isset($data['password'])) {
            http_response_code(400);
            echo json_encode(['status' => 'error', 'message' => 'Name, email and password are required']);
            exit;
        }

        // Extract data
        $name = $data['name'];
        $email = $data['email'];
        $password = $data['password'];
        $phone = $data['phone'] ?? null;
        $address = $data['address'] ?? null;

        // Check existing email
        $stmt = $conn->prepare("SELECT id FROM users WHERE email = :email");
        $stmt->execute(['email' => $email]);
        
        if ($stmt->rowCount() > 0) {
            http_response_code(409);
            echo json_encode(['status' => 'error', 'message' => 'Email already exists']);
            exit;
        }

        // Hash password
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        // Insert new user
        $stmt = $conn->prepare("
            INSERT INTO users 
                (name, email, password, phone, address) 
            VALUES 
                (:name, :email, :password, :phone, :address)
        ");

        $stmt->execute([
            'name' => $name,
            'email' => $email,
            'password' => $hashedPassword,
            'phone' => $phone,
            'address' => $address
        ]);

        // Get created user
        $userId = $conn->lastInsertId();
        $stmt = $conn->prepare("SELECT * FROM users WHERE id = :id");
        $stmt->execute(['id' => $userId]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        // Remove sensitive data
        unset($user['password']);
        unset($user['remember_token']);

        http_response_code(201);
        echo json_encode([
            'status' => 'success',
            'message' => 'User created successfully',
            'user' => $user
        ]);

    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['status' => 'error', 'message' => 'Server error: ' . $e->getMessage()]);
    }
} else {
    http_response_code(405);
    echo json_encode(['status' => 'error', 'message' => 'Only POST requests are allowed']);
}
?>