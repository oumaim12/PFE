<?php
header("Content-Type: application/json");
include 'dbconfig.php';

// Get JSON input
$data = json_decode(file_get_contents("php://input"), true);

// Validate required fields
if (empty($data['userId']) || empty($data['name']) || empty($data['email'])) {
  http_response_code(400);
  echo json_encode(["success" => false, "message" => "Missing required fields"]);
  exit;
}

$userId = $data['userId'];
$name = $data['name'];
$email = $data['email'];
$phone = $data['phone'] ?? null;
$address = $data['address'] ?? null;

try {
  // Check if email is already taken by another user
  $checkEmailStmt = $conn->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
  $checkEmailStmt->bind_param("si", $email, $userId);
  $checkEmailStmt->execute();
  
  if ($checkEmailStmt->get_result()->num_rows > 0) {
    http_response_code(409);
    echo json_encode(["success" => false, "message" => "Email already in use"]);
    exit;
  }

  // Update user data
  $updateStmt = $conn->prepare("
    UPDATE users 
    SET name = ?, email = ?, phone = ?, address = ? 
    WHERE id = ?
  ");
  $updateStmt->bind_param("ssssi", $name, $email, $phone, $address, $userId);
  
  if ($updateStmt->execute()) {
    echo json_encode([
      "success" => true,
      "message" => "Profile updated successfully",
      "user" => [
        "id" => $userId,
        "name" => $name,
        "email" => $email,
        "phone" => $phone,
        "address" => $address
      ]
    ]);
  } else {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Update failed"]);
  }
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(["success" => false, "message" => "Server error: " . $e->getMessage()]);
}

$conn->close();
?>