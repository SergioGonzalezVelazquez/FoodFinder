<?php

include 'conexion.php';

$conexion = mysqli_connect(DB_SERVER,DB_USER,DB_PASSWORD,DB_DATABASE) or die("Error al conectar con la BD");

$consultaSQL="SELECT * FROM restaurantes";

$resultadoConsulta = mysqli_query($conexion, $consultaSQL) or die ("Error al realizar la consulta");

if (mysqli_num_rows($resultadoConsulta) > 0){
	$respuestaJSON["restaurantes"] = array();
	while ($fila = mysqli_fetch_array($resultadoConsulta)){
		$restaurante = array();
		$restaurante["id"] = $fila["id"];
		$restaurante["nombre"] = $fila["nombre"];
		$restaurante["imagenLogo"] = $fila["imagenLogo"];
		$restaurante["imagenFondo"] = $fila["imagenFondo"];
		$restaurante["categoria"] = $fila["categoria"];
		$restaurante["valoracion"] = $fila["valoracion"];
		$restaurante["numValoraciones"] = $fila["numValoraciones"];
		$restaurante["distancia"] = $fila["distancia"];
		$restaurante["pedidoMinimo"] = $fila["pedidoMinimo"];
		$restaurante["envio"] = $fila["envio"];
		$restaurante["descuento"] = $fila["descuento"];

		array_push($respuestaJSON["restaurantes"], $restaurante);
	}
	echo json_encode($respuestaJSON);
}
mysqli_close($conexion) or die("Error al cerrar la conexión");
?>

