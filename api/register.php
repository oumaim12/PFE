<?php

// Inclure la configuration de la base de données
require_once 'db_config.php';

// Activer les CORS pour permettre les requêtes depuis votre application Flutter
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

// Vérifier que la méthode est bien POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try{
    // Récupérer les données JSON envoyées
    $data = json_decode(file_get_contents("php://input"), true);
    
    // Pour déboguer - écrire les données reçues dans un fichier log
    file_put_contents('login_debug.log', print_r($data, true), FILE_APPEND);
    // Vérifier que email et password sont fournis
    if (!isset($data['name']) || !isset($data['email']) || !isset($data['password'])) {
        http_response_code(400); // Bad request
        echo json_encode(['status' => 'error', 'message' => 'email and password are required']);
        exit;
    }
    $name = $data['name'];
    $email = $data['email'];
    $password = $data['password'];





    $stmt = $conn->prepare("SELECT * FROM users WHERE email = :email");
    $stmt->execute(['email' => $email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($user) {
        // Si l'email existe déjà, retourner une erreur
        http_response_code(409); // Conflict
        echo json_encode(['status' => 'error', 'message' => 'Email already exists']);}
        else {
            // Si l'email n'existe pas, insérer le nouveau compte
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT); // Hasher le mot de passe
            $stmt = $conn->prepare("INSERT INTO users (email, password) VALUES (:email, :password)");
            $stmt->execute(['email' => $email, 'password' => $hashedPassword]);

            // Retourner une réponse de succès
            echo json_encode([
                'status' => 'success', 
                'message' => 'Account created successfully', 
                'user' => [
                    'email' => $email,
                    // Ne pas renvoyer le mot de passe
                ]
            ]);
        }
    } catch (PDOException $e) {
        http_response_code(500); // Internal server error
        echo json_encode(['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()]);
    }
} else {
    http_response_code(405); // Method not allowed
    echo json_encode(['status' => 'error', 'message' => 'Only POST requests are allowed']);
}
?>





