<?php

    include "../config/connect.php";
    $response = array();
    $username = $_POST['username'];
    $password = md5($_POST['password']);
    
    
    $cek = mysqli_query($con, "SELECT * FROM users WHERE username='$username' and password='$password' or email='$username' and password='$password'");
    $result = mysqli_fetch_array($cek);
    if(isset($result)){
        $response['value'] = 1;
        $response['message'] = "Successs";
        echo json_encode($response);
    }else{
        $response['value'] = 0;
        $response['message'] = "Username and Password not match";
        echo json_encode($response);
       
    }
   
?>
