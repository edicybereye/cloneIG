<?php


require_once "../config/connect.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

	$response = array();
	$idUsers = $_POST['idUsers'];
	$file = $_POST['file'];


	$simpan = "DELETE FROM tmpPost WHERE idUsers='$idUsers' and file='$file'";



	if (mysqli_query($con, $simpan)) {
		//displaying success 

		$response["value"] = 1;
		$response["message"] = "Success";
		echo json_encode($response);
	} else {
		//displaying failure
		$response["value"] = 2;
		$response["message"] = "Failed";

		echo json_encode($response);
	}



	mysqli_close($con);
}
