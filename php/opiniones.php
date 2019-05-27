<?php

include 'conexion.php';

$conexion = mysqli_connect(DB_SERVER,DB_USER,DB_PASSWORD,DB_DATABASE) or die("Error al conectar con la BD");

$consultaSQL="SELECT * FROM opinion WHERE idRestaurante=".$_REQUEST["idRestaurante"]."";


$resultadoConsulta = mysqli_query($conexion, $consultaSQL) or die ("Error al realizar la consulta");

$respuestaJSON = array();
if (mysqli_num_rows($resultadoConsulta) > 0){
	while ($fila = mysqli_fetch_array($resultadoConsulta)){
		$opinion = array();
		$opinion["id"] = $fila["id"];
		$opinion["nombreUser"] = $fila["nombreUser"];
		$opinion["comentario"] = $fila["comentario"];
		$opinion["valoracion"] = $fila["valoracion"];
		$opinion["fecha"] = $fila["fecha"];

		array_push($respuestaJSON, $opinion);
	}
}
echo json_encode($respuestaJSON);
mysqli_close($conexion) or die("Error al cerrar la conexión");
?>
