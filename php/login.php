<?php

include 'conexion.php';

$conexion = mysqli_connect(DB_SERVER,DB_USER,DB_PASSWORD,DB_DATABASE) or die("Error al conectar con la BD");

$consultaSQL="SELECT * FROM usuarios WHERE email='".$_REQUEST["email"]. "' and password='".$_REQUEST["password"]."'";

$resultadoConsulta = mysqli_query($conexion, $consultaSQL) or die ("Error al realizar la consulta en Pedidos");

$respuestaJSON = array();

if (mysqli_num_rows($resultadoConsulta) > 0){
	while ($fila = mysqli_fetch_array($resultadoConsulta)){
		$usuario = array();
		$usuario["id"] = $fila["id"];
		$usuario["nombre"] = $fila["nombre"];
		$usuario["password"] = $fila["password"];
		$usuario["email"] = $fila["email"];
		$usuario["restaurantesFavs"] = array();
		$usuario["platosFavs"] = array();


		$consultaRestaurantes="SELECT * FROM restaurante_favorito rf JOIN restaurantes rest ON rf.idRestaurante = rest.id WHERE idUsuario='".$usuario["id"]."'";

		$consultaPlatos="SELECT * FROM producto_favorito pf JOIN productos prod  ON pf.idProducto = prod.id WHERE idUsuario='".$usuario["id"]."'";


		//CONSULTA A TABLA RESTAURANTE_FAVORITO
		$getRestaurantes = mysqli_query($conexion, $consultaRestaurantes) or die ("Error al obtener restaurantes favoritos");

		//CONSULTA A TABLA PRODUCTO_FAVORITO
		$getPlatos = mysqli_query($conexion, $consultaPlatos) or die ("Error al obtener platos favoritos");


		if (mysqli_num_rows($getRestaurantes) > 0){
			while ($filaRestaurante = mysqli_fetch_array($getRestaurantes)){
				$restaurante = array();
				$restaurante["id"] = $filaRestaurante["id"];
				$restaurante["nombre"] = $filaRestaurante["nombre"];
				$restaurante["imagenLogo"] = $filaRestaurante["imagenLogo"];
				$restaurante["imagenFondo"] = $filaRestaurante["imagenFondo"];
				$restaurante["categoria"] = $filaRestaurante["categoria"];
				$restaurante["valoracion"] = $filaRestaurante["valoracion"];
				$restaurante["numValoraciones"] = $filaRestaurante["numValoraciones"];
				$restaurante["distancia"] = $filaRestaurante["distancia"];
				$restaurante["pedidoMinimo"] = $filaRestaurante["pedidoMinimo"];
				$restaurante["envio"] = $filaRestaurante["envio"];
				$restaurante["descuento"] = $filaRestaurante["descuento"];
				array_push($usuario["restaurantesFavs"], $restaurante);

			}

		}

		if (mysqli_num_rows($getPlatos) > 0){
			while ($filaProducto = mysqli_fetch_array($getPlatos)){
				$producto = array();
				$producto["id"] = $filaProducto["idProducto"];
				$producto["nombre"] = $filaProducto["nombre"];
				$producto["imagen"] = $filaProducto["imagen"];
				$producto["descripcion"] = $filaProducto["descripcion"];
				$producto["precio"] = $filaProducto["precio"];
				array_push($usuario["platosFavs"], $producto);
	
			}

		}
		array_push($respuestaJSON, $usuario);
	}
}

echo json_encode($respuestaJSON);
mysqli_close($conexion) or die("Error al cerrar la conexión");

?>

