<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    
    // Hash the password
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
    
    // Save the username and hashed password to a text file
    $file = fopen("users.txt", "a");
    fwrite($file, "Username: $username, Hashed Password: $hashedPassword\n");
    fclose($file);
    
    echo "Registration successful!";
}
?>

