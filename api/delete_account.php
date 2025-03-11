<?php
header("Content-Type: application/json");
include 'dbconfig.php';

$data = json_decode(file_get_contents("php://input"), true);

if (empty($data['userId'])) {
  http_response_code(400);
  echo json_encode(["success" => false, "message" => "User ID required"]);
  exit;
}

$userId = $data['userId'];

try {
  // Verify user exists
  $checkStmt = $conn->prepare("SELECT id FROM users WHERE id = ?");
  $checkStmt->bind_param("i", $userId);
  $checkStmt->execute();
  
  if ($checkStmt->get_result()->num_rows === 0) {
    http_response_code(404);
    echo json_encode(["success" => false, "message" => "User not found"]);
    exit;
  }

  // Delete user
  $deleteStmt = $conn->prepare("DELETE FROM users WHERE id = ?");
  $deleteStmt->bind_param("i", $userId);
  
  if ($deleteStmt->execute()) {
    echo json_encode(["success" => true, "message" => "Account deleted successfully"]);
  } else {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Deletion failed"]);
  }
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(["success" => false, "message" => "Server error: " . $e->getMessage()]);
}

$conn->close();
?>