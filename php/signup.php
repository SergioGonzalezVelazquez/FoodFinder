<?php

include 'conexion.php';

$conexion = mysqli_connect(DB_SERVER,DB_USER,DB_PASSWORD,DB_DATABASE) or die("Error al conectar con la BD");

$consultaSQL="INSERT INTO usuarios (id, nombre, password, email, telefono, fotoPerfil) VALUES (NULL,'".$_REQUEST["nombre"]. "','".$_REQUEST["password"]."','".$_REQUEST["email"]."','".$_REQUEST["telefono"]."','".$_REQUEST["fotoPerfil"]."')";

$resultadoConsulta = mysqli_query($conexion, $consultaSQL);

$response = array();

if($resultadoConsulta){
    $response['code'] = '1';
    $response['message'] = 'success message.';
}else{
    $response['code'] = '2';
    $response['message'] = 'error message.';
}
echo json_encode($response);
?>

