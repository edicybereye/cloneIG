<?php


require_once "../config/connect.php";


$response = array();

$idUsers = $_GET['idUsers'];

$simpan = mysqli_query($con, "SELECT a.*, b.username, b.name, b.photo FROM post a 
left join users b on a.idUsers = b.id
WHERE a.idUsers='$idUsers' order by createdDate desc");
while ($a  = mysqli_fetch_array($simpan)) {
	# code...
	$idPost = $a['id'];

	$value_array['id'] = $idPost;
	$value_array['createdDate'] = $a['createdDate'];
	$value_array['idUsers'] = $a['idUsers'];
	$value_array['description'] = $a['description'];
	$value_array['love'] = (int) $a['love'];
	$value_array['username'] = $a['username'];
	$value_array['name'] = $a['name'];
	$value_array['photo'] = $a['photo'];
	$value_array['data'] = array();

	$cekData = mysqli_query($con, "SELECT * FROM PostDetail WHERE idPost='$idPost'");
	while ($bc = mysqli_fetch_array($cekData)) {
		# code...
		$value_array['data'][] = array(
			'detail' => $bc['detail'],
			'tipe' => $bc['tipe'],
			'id' => $bc['id'],

		);
	}


	array_push($response, $value_array);
}


echo json_encode($response);
