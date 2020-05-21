<?php


require_once "../config/connect.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

	$response = array();
	$idUsers = $_POST['idUsers'];

	$image = date('dmYHis') . str_replace(" ", "", basename($_FILES["file"]["name"]));
	$imagePath = "../image/" . $image;

	move_uploaded_file($_FILES['file']['tmp_name'], $imagePath);

	$simpan = "INSERT INTO tmpPost VALUE(NULL,'$idUsers','$image',NOW())";



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
