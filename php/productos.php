<?php

include 'conexion.php';

$conexion = mysqli_connect(DB_SERVER,DB_USER,DB_PASSWORD,DB_DATABASE) or die("Error al conectar con la BD");

$consultaSQL="SELECT * FROM productos WHERE idRestaurante='".$_REQUEST["idRestaurante"]. "'";

$resultadoConsulta = mysqli_query($conexion, $consultaSQL) or die ("Error al realizar la consulta");

$respuestaJSON = array();

if (mysqli_num_rows($resultadoConsulta) > 0){
	while ($fila = mysqli_fetch_array($resultadoConsulta)){
		$producto = array();
		$producto["id"] = $fila["id"];
		$producto["nombre"] = $fila["nombre"];
		$producto["imagen"] = $fila["imagen"];
		$producto["descripcion"] = $fila["descripcion"];
		$producto["precio"] = $fila["precio"];

		array_push($respuestaJSON, $producto);
	}	
}
echo json_encode($respuestaJSON);
mysqli_close($conexion) or die("Error al cerrar la conexión");
?>

