<?php

include 'conexion.php';

$conexion = mysqli_connect(DB_SERVER,DB_USER,DB_PASSWORD,DB_DATABASE) or die("Error al conectar con la BD");

$consultaUsuario="SELECT * FROM usuarios WHERE email='".$_REQUEST["email"]. "' and password='".$_REQUEST["password"]."'";

$resultadoUsuario = mysqli_query($conexion, $consultaUsuario) or die ("Error al realizar la consulta en tabla Usuario");

$respuestaJSON = array();

if (mysqli_num_rows($resultadoUsuario) > 0){

	while ($fila = mysqli_fetch_array($resultadoUsuario)){
		$usuario = array();
		$usuario["id"] = $fila["id"];
		$usuario["nombre"] = $fila["nombre"];
		$usuario["password"] = $fila["password"];
		$usuario["email"] = $fila["email"];
		$usuario["historialPedidos"] = array();

		$consultaPedidos="SELECT * FROM pedidos WHERE idCliente='".$usuario["id"]."'";

		$historialPedidos = mysqli_query($conexion, $consultaPedidos) or die ("Error al obtener historial de pedidos");

		if (mysqli_num_rows($historialPedidos) > 0){
			while ($filaPedido = mysqli_fetch_array($historialPedidos)){
				$pedido = array();
				$pedido["numPedido"] = $filaPedido["numPedido"];
				$pedido["idRestaurante"] = $filaPedido["idRestaurante"];
				$pedido["estado"] = $filaPedido["estado"];
				$pedido["fecha"] = $filaPedido["fecha"];
				array_push($usuario["historialPedidos"], $pedido);
			}
		}
		array_push($respuestaJSON, $usuario);
	}
}

echo json_encode($respuestaJSON);
mysqli_close($conexion) or die("Error al cerrar la conexión");
?>

