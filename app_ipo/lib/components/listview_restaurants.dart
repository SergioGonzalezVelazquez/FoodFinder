import 'package:flutter/material.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/components/item_restaurante_list.dart';

class RestaurantsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RestaurantsListState();
  }
}

class _RestaurantsListState extends State<RestaurantsList> {
  List<ModeloRestaurante> restaurantes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    restaurantes = <ModeloRestaurante>[
      ModeloRestaurante(
        nombre: 'Telepizza',
        imagen: "images/restaurants/logo_telepizza.png",
        categoria: 'Italiana, Pizza',
        valoracion: 4,
        numValoraciones: 1872,
        pedidoMinimo: 6.95,
        distancia: '1.7',
        envio: 0,
      ),
      ModeloRestaurante(
        nombre: 'TGB The Good Burger',
        imagen: "images/restaurants/logo_thegoodburger.jpg",
        categoria: 'Americana, Hamburguesas',
        valoracion: 3,
        numValoraciones: 751,
        pedidoMinimo: 8.00,
        distancia: '0.5',
        envio: 1.90,
      ),
      ModeloRestaurante(
        nombre: 'Pan Real',
        imagen: "images/restaurants/logo_panReal.png",
        categoria: 'Desayunos, Española',
        valoracion: 1,
        numValoraciones: 653,
        pedidoMinimo: 15.00,
        distancia: '2.9',
        envio: 1.20,
      ),
      ModeloRestaurante(
        nombre: 'Dominos Pizza',
        imagen: "images/restaurants/logo_dominos.png",
        categoria: 'Italiana, Pizza',
        valoracion: 4,
        numValoraciones: 901,
        pedidoMinimo: 10.00,
        distancia: '3.4',
        envio: 0,
      ),
      ModeloRestaurante(
        nombre: 'Bambola Restaurante',
        imagen: "images/restaurants/logo_bambola.png",
        categoria: 'Italiana, Pizza',
        valoracion: 4,
        numValoraciones: 511,
        pedidoMinimo: 5.00,
        distancia: '2.3',
        envio: 0,
      ),
      ModeloRestaurante(
        nombre: 'La Capricciosa Italiana',
        imagen: "images/restaurants/logo_capricciosa.jpg",
        categoria: 'Italiana, Pizza',
        valoracion: 2,
        numValoraciones: 901,
        pedidoMinimo: 5.00,
        distancia: '0.5',
        envio: 1.90,
      ),
      ModeloRestaurante(
        nombre: 'Galeguesa',
        imagen: "images/restaurants/logo_galeguesa.jpg",
        categoria: 'Hamburguesas, Gourmet',
        valoracion: 5,
        numValoraciones: 201,
        pedidoMinimo: 8.00,
        distancia: '1.4',
        envio: 2.90,
      ),
      ModeloRestaurante(
        nombre: 'Home Burguer Bar',
        imagen: "images/restaurants/logo_homeBurgerBar.png",
        categoria: 'Americana, Hamburguesas',
        valoracion: 3,
        numValoraciones: 1071,
        pedidoMinimo: 10.00,
        distancia: '3.4',
        envio: 0,
      ),
      ModeloRestaurante(
        nombre: 'Sushi Star',
        imagen: "images/restaurants/logo_dosushiStar.jpg",
        categoria: 'Japonesa, Sushi',
        valoracion: 4,
        numValoraciones: 1421,
        pedidoMinimo: 15.00,
        distancia: '3.4',
        envio: 0,
      ),
      ModeloRestaurante(
        nombre: 'Nikko',
        imagen: "images/restaurants/logo_nikko.jpg",
        categoria: 'Italiana, Pizza',
        valoracion: 3,
        numValoraciones: 932,
        pedidoMinimo: 13.00,
        distancia: '1.4',
        envio: 0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: restaurantes.length,
        itemBuilder: (context, int item) =>
            new ItemRestauranteList(restaurantes[item]));
  }
}
