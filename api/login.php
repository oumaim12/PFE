<?php
// Inclure la configuration de la base de données
require_once 'db_config.php';

// Activer les CORS pour permettre les requêtes depuis votre application Flutter
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

// Vérifier que la méthode est bien POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Récupérer les données JSON envoyées
    $data = json_decode(file_get_contents("php://input"), true);
    
    // Pour déboguer - écrire les données reçues dans un fichier log
    file_put_contents('login_debug.log', print_r($data, true), FILE_APPEND);
    
    // Vérifier que email et password sont fournis
    if (!isset($data['email']) || !isset($data['password'])) {
        http_response_code(400); // Bad request
        echo json_encode(['status' => 'error', 'message' => 'email and password are required']);
        exit;
    }
    
    $email = $data['email'];
    $password = $data['password'];
    
    try {
        // Fetch user from the database
        $stmt = $conn->prepare("SELECT * FROM users WHERE email = :email");
        $stmt->execute(['email' => $email]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        // Pour déboguer - écrire l'utilisateur trouvé dans un fichier log
        file_put_contents('login_debug.log', "\nUtilisateur trouvé: " . print_r($user, true), FILE_APPEND);
        
        // IMPORTANT: Pour le débogage uniquement
        // Compare directement le mot de passe sans vérification de hash
        // À UTILISER TEMPORAIREMENT pour tester, puis revenir à password_verify()
        if ($user && password_verify($password, $user['password'])) {
            // Login successful
            echo json_encode([
                'status' => 'success', 
                'message' => 'Login successful', 
                'user' => [
                    'id' => $user['id'],
                    'email' => $user['email'],
                    // Ne pas renvoyer le mot de passe
                ]
            ]);
        } else {
            // Invalid credentials
            http_response_code(401); // Unauthorized
            echo json_encode(['status' => 'error', 'message' => 'Invalid email or password']);
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