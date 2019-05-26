<?php

include 'conexion.php';

$connect = mysqli_connect(DB_SERVER,DB_USER,DB_PASSWORD,DB_DATABASE) or die("Error al conectar con la BD");

$consultar=$connect->query("SELECT * FROM usuarios WHERE email='".$_REQUEST["email"]. "' and password='".$_REQUEST["password"]."'");

$resultado=array();

while($extraerDatos=$consultar->fetch_assoc()){
    $resultado[]=$extraerDatos;
}

echo json_encode($resultado);

?>

