<?php

include 'conexion.php';

$conexion = mysqli_connect(DB_SERVER,DB_USER,DB_PASSWORD,DB_DATABASE) or die("Error al conectar con la BD");

$consultaSQL="SELECT * FROM pedidos WHERE idCliente='".$_REQUEST["idCliente"]. "'";

$resultadoConsulta = mysqli_query($conexion, $consultaSQL) or die ("Error al realizar la consulta en Pedidos");

$respuestaJSON = array();

if (mysqli_num_rows($resultadoConsulta) > 0){
	while ($fila = mysqli_fetch_array($resultadoConsulta)){
		$pedido = array();
		$pedido["numPedido"] = $fila["numPedido"];
		$pedido["estado"] = $fila["estado"];
		$pedido["fecha"] = $fila["fecha"];
		$pedido["envio"] = $fila["envio"];
		$pedido["descuento"] = $fila["descuento"];
		$pedido["restaurante"] = array();
		$pedido["productos"] = array();


		$consultaRestaurante="SELECT * FROM restaurantes WHERE id='".$fila["idRestaurante"]."'";

		//CONSULTA A TABLA RESTAURANTE
		$getRestaurante = mysqli_query($conexion, $consultaRestaurante) or die ("Error al obtener restaurante");

		if (mysqli_num_rows($getRestaurante) > 0){
			$filaRestaurante = mysqli_fetch_array($getRestaurante);
			$pedido["restaurante"] = array('id'=>$fila["idRestaurante"],'nombre'=>$filaRestaurante["nombre"], 'imagenLogo'=>$filaRestaurante["imagenLogo"],'imagenFondo'=>$filaRestaurante["imagenFondo"], 'categoria'=>$filaRestaurante["categoria"],'valoracion'=>$filaRestaurante["valoracion"],'numValoraciones'=>$filaRestaurante["numValoraciones"],'distancia'=>$filaRestaurante["distancia"],'pedidoMinimo'=>$filaRestaurante["pedidoMinimo"],'envio'=>$filaRestaurante["envio"],'descuento'=>$filaRestaurante["descuento"]);
			
		}

		//CONSULTA PRODUCTOS DEL PEDIDO
		$consultaProductos="SELECT prod.id idProducto, prod.nombre, prod.imagen, prod.descripcion, prod.precio, pp.cantidad FROM productos prod JOIN pedido_producto pp ON prod.id = pp.idProducto JOIN pedidos ped ON ped.numPedido = pp.numPedido WHERE ped.numPedido='".$pedido["numPedido"]."'";

		$getProductos = mysqli_query($conexion, $consultaProductos) or die ("Error al obtener productos del pedido");

		if (mysqli_num_rows($getProductos) > 0){
			while ($filaProducto = mysqli_fetch_array($getProductos)){
				$producto = array();
				$producto["idProducto"] = $filaProducto["idProducto"];
				$producto["nombre"] = $filaProducto["nombre"];
				$producto["imagen"] = $filaProducto["imagen"];
				$producto["descripcion"] = $filaProducto["descripcion"];
				$producto["precio"] = $filaProducto["precio"];
				$producto["cantidad"] = $filaProducto["cantidad"];
				array_push($pedido["productos"], $producto);
			}
		}

		array_push($respuestaJSON, $pedido);
	}	
}
echo json_encode($respuestaJSON);
mysqli_close($conexion) or die("Error al cerrar la conexión");
?>

