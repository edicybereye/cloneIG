<?php


require_once "../config/connect.php";


$response = array();

$idUsers = $_GET['idUsers'];

$simpan = mysqli_query($con, "SELECT * FROM tmpPost WHERE idUsers='$idUsers'");
while ($a  = mysqli_fetch_array($simpan)) {
	# code...
	$file = $a['file'];
	$idUsers = $a['idUsers'];

	$value_array['file'] = $file;
	$value_array['idUsers'] = $idUsers;

	array_push($response, $value_array);
}


echo json_encode($response);
