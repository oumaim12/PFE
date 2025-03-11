<?php
header("Content-Type: application/json");
include 'dbconfig.php';

$data = json_decode(file_get_contents("php://input"), true);

$userId = $data['userId'];
$currentPassword = $data['currentPassword'];
$newPassword = $data['newPassword'];

// Fetch the user's current hashed password from the database
$sql = "SELECT password FROM users WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $userId);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

if (password_verify($currentPassword, $user['password'])) {
  // Hash the new password
  $hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);

  // Update the password in the database
  $updateSql = "UPDATE users SET password = ? WHERE id = ?";
  $updateStmt = $conn->prepare($updateSql);
  $updateStmt->bind_param("si", $hashedPassword, $userId);
  $updateStmt->execute();

  echo json_encode(["success" => true, "message" => "Password updated successfully"]);
} else {
  echo json_encode(["success" => false, "message" => "Current password is incorrect"]);
}

$conn->close();
?>