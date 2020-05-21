<?php


require_once "../config/connect.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

	$response = array();
	$idUsers = $_POST['idUsers'];
	$caption = $_POST['caption'];



	$simpan = mysqli_query($con, "SELECT * FROM tmpPost WHERE idUsers='$idUsers'");
	$cek = mysqli_fetch_array($simpan);



	if (isset($cek)) {
		//displaying success 
		//displaying failure
		$cekPOST = mysqli_query($con, "SELECT * FROM post order by id desc limit 1");
		$ab = mysqli_fetch_array($cekPOST);

		$idPost = $ab['id'] + 1;

		$insert = "INSERT INTO post VALUE('$idPost',NOW(),'$idUsers','$caption','0')";
		if (mysqli_query($con, $insert)) {
			# code...
			$cekTmp = mysqli_query($con, "SELECT * FROM tmpPost WHERE idUsers='$idUsers'");
			while ($a = mysqli_fetch_array($cekTmp)) {
				# code...
				$file = $a['file'];


				$insertDetail = mysqli_query($con, "INSERT INTO PostDetail VALUE(NULL,'$idPost','$file','1')");
			}

			$deleteTmpPosting = mysqli_query($con, "DELETE FROM tmpPost WHERE idUsers='$idUsers'");

			$response["value"] = 1;
			$response["message"] = "Success";

			echo json_encode($response);
		} else {
			# code...
			$response["value"] = 2;
			$response["message"] = "Failed";

			echo json_encode($response);
		}
	} else {
		$response["value"] = 0;
		$response["message"] = "Please upload image or video";
		echo json_encode($response);
	}



	mysqli_close($con);
}
