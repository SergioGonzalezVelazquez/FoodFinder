import 'package:flutter/material.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/components/item_restaurante_list.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/opinionRest_model.dart';
import 'package:app_ipo/data/gestorBBDD.dart';

//Database

import 'dart:async';

class RestaurantsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RestaurantsListState();
  }
}

class _RestaurantsListState extends State<RestaurantsList> {
  List<ModeloRestaurante> listRestaurantes = List();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchRestaurants();
    /*
    List<ModeloProducto> productosTelepizza = <ModeloProducto>[
      ModeloProducto(
          nombre: 'Sweet con Caja Roja',
          imagen: "images/products/telepizza_cajaRoja.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 5.95),
      ModeloProducto(
          nombre: 'La Ibérica de Telepizza',
          imagen: "images/products/telepizza_iberica.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 8.95),
      ModeloProducto(
          nombre: 'Tándem Gourmet',
          imagen: "images/products/telepizza_tandem_gourmet.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 10.95),
      ModeloProducto(
          nombre: 'Vulcano Nachos',
          imagen: "images/products/telepizza_vulcanoNachos.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 6.95),
      ModeloProducto(
          nombre: 'Sweet con Caja Roja',
          imagen: "images/products/telepizza_cajaRoja.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 5.95),
      ModeloProducto(
          nombre: 'La Ibérica de Telepizza',
          imagen: "images/products/telepizza_iberica.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 8.95),
      ModeloProducto(
          nombre: 'Tándem Gourmet',
          imagen: "images/products/telepizza_tandem_gourmet.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 10.95),
      ModeloProducto(
          nombre: 'Vulcano Nachos',
          imagen: "images/products/telepizza_vulcanoNachos.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 6.95),
      ModeloProducto(
          nombre: 'Sweet con Caja Roja',
          imagen: "images/products/telepizza_cajaRoja.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 5.95),
      ModeloProducto(
          nombre: 'La Ibérica de Telepizza',
          imagen: "images/products/telepizza_iberica.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 8.95),
      ModeloProducto(
          nombre: 'Tándem Gourmet',
          imagen: "images/products/telepizza_tandem_gourmet.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 10.95),
      ModeloProducto(
          nombre: 'Vulcano Nachos',
          imagen: "images/products/telepizza_vulcanoNachos.jpg",
          descripcion: 'Nuestra masa de siempre cubierta de crujiente',
          precio: 6.95),
    ];

    List<ModeloOpinionRestaurante> opinionesTelepizza =
        <ModeloOpinionRestaurante>[
      ModeloOpinionRestaurante(
          nombreUser: 'José',
          valoracion: 2,
          comentario: 'Demasiado caro',
          fecha: '20/04/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'Óscar',
          valoracion: 3,
          comentario: 'Pedí barbacoa y me llegó otra cosa... pero muy rica!',
          fecha: '02/04/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'David',
          valoracion: 4,
          comentario: 'Excellemt service. And the food was delicious!',
          fecha: '25/03/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'Adriana',
          valoracion: 5,
          comentario: 'La pizza está super buena!',
          fecha: '12/03/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'Rebeca',
          valoracion: 1,
          comentario: 'Es una lástima porque la comida siempre está ' +
              'muy buena, pero esta vez el queso de la pasta estaba pasado ' +
              'y tenía sabor a rancio. Las patatas de la milanesa estaban incomestibles.',
          fecha: '12/03/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'José',
          valoracion: 2,
          comentario: 'Demasiado caro',
          fecha: '20/04/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'Óscar',
          valoracion: 3,
          comentario: 'Pedí barbacoa y me llegó otra cosa... pero muy rica!',
          fecha: '02/04/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'David',
          valoracion: 4,
          comentario: 'Excellemt service. And the food was delicious!',
          fecha: '25/03/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'Adriana',
          valoracion: 5,
          comentario: 'La pizza está super buena!',
          fecha: '12/03/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'Rebeca',
          valoracion: 1,
          comentario: 'Es una lástima porque la comida siempre está ' +
              'muy buena, pero esta vez el queso de la pasta estaba pasado ' +
              'y tenía sabor a rancio. Las patatas de la milanesa estaban incomestibles.',
          fecha: '12/03/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'José',
          valoracion: 2,
          comentario: 'Demasiado caro',
          fecha: '20/04/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'Óscar',
          valoracion: 3,
          comentario: 'Pedí barbacoa y me llegó otra cosa... pero muy rica!',
          fecha: '02/04/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'David',
          valoracion: 4,
          comentario: 'Excellemt service. And the food was delicious!',
          fecha: '25/03/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'Adriana',
          valoracion: 5,
          comentario: 'La pizza está super buena!',
          fecha: '12/03/2019'),
      ModeloOpinionRestaurante(
          nombreUser: 'Rebeca',
          valoracion: 1,
          comentario: 'Es una lástima porque la comida siempre está ' +
              'muy buena, pero esta vez el queso de la pasta estaba pasado ' +
              'y tenía sabor a rancio. Las patatas de la milanesa estaban incomestibles.',
          fecha: '12/03/2019'),
    ];
    restaurantes = <ModeloRestaurante>[
      ModeloRestaurante(
          nombre: 'Telepizza',
          imagenLogo: "images/restaurants/logo_telepizza.png",
          imagenFondo: "images/restaurants/fondo_telepizza.jpg",
          categoria: 'Italiana, Pizza',
          valoracion: 4,
          numValoraciones: 1872,
          pedidoMinimo: 6.95,
          distancia: '1.7',
          envio: 0,
          productos: productosTelepizza,
          opiniones: opinionesTelepizza),
      ModeloRestaurante(
        nombre: 'TGB The Good Burger',
        imagenLogo: "images/restaurants/logo_thegoodburger.jpg",
        imagenFondo: "images/restaurants/fondo_tgb.jpg",
        categoria: 'Americana, Hamburguesas',
        valoracion: 3,
        numValoraciones: 751,
        pedidoMinimo: 8.00,
        distancia: '0.5',
        envio: 1.90,
      ),
      ModeloRestaurante(
        nombre: 'Pan Real',
        imagenLogo: "images/restaurants/logo_panReal.png",
        imagenFondo: "images/restaurants/fondo_panReal.jpg",
        categoria: 'Desayunos, Española',
        valoracion: 1,
        numValoraciones: 653,
        pedidoMinimo: 15.00,
        distancia: '2.9',
        envio: 1.20,
      ),
      ModeloRestaurante(
        nombre: 'Dominos Pizza',
        imagenLogo: "images/restaurants/logo_dominos.png",
        imagenFondo: "images/restaurants/fondo_dominos.jpg",
        categoria: 'Italiana, Pizza',
        valoracion: 4,
        numValoraciones: 901,
        pedidoMinimo: 10.00,
        distancia: '3.4',
        envio: 0,
      ),
      ModeloRestaurante(
        nombre: 'Bambola Restaurante',
        imagenLogo: "images/restaurants/logo_bambola.png",
        imagenFondo: "images/restaurants/fondo_bambola.jpg",
        categoria: 'Italiana, Pizza',
        valoracion: 4,
        numValoraciones: 511,
        pedidoMinimo: 5.00,
        distancia: '2.3',
        envio: 0,
      ),
      ModeloRestaurante(
        nombre: 'La Capricciosa Italiana',
        imagenLogo: "images/restaurants/logo_capricciosa.jpg",
        imagenFondo: "images/restaurants/fondo_capricciosa.jpg",
        categoria: 'Italiana, Pizza',
        valoracion: 2,
        numValoraciones: 901,
        pedidoMinimo: 5.00,
        distancia: '0.5',
        envio: 1.90,
      ),
      ModeloRestaurante(
        nombre: 'Galeguesa',
        imagenLogo: "images/restaurants/logo_galeguesa.jpg",
        imagenFondo: "images/restaurants/fondo_galeguesa.jpg",
        categoria: 'Hamburguesas, Gourmet',
        valoracion: 5,
        numValoraciones: 201,
        pedidoMinimo: 8.00,
        distancia: '1.4',
        envio: 2.90,
      ),
      ModeloRestaurante(
        nombre: 'Home Burguer Bar',
        imagenLogo: "images/restaurants/logo_homeBurgerBar.png",
        imagenFondo: "images/restaurants/fondo_homeburger.jpg",
        categoria: 'Americana, Hamburguesas',
        valoracion: 3,
        numValoraciones: 1071,
        pedidoMinimo: 10.00,
        distancia: '3.4',
        envio: 0,
      ),
      ModeloRestaurante(
        nombre: 'Sushi Star',
        imagenLogo: "images/restaurants/logo_sushiStar.jpg",
        imagenFondo: "images/restaurants/fondo_sushi_star.jpg",
        categoria: 'Japonesa, Sushi',
        valoracion: 4,
        numValoraciones: 1421,
        pedidoMinimo: 15.00,
        distancia: '3.4',
        envio: 0,
      ),
      ModeloRestaurante(
        nombre: 'Nikko',
        imagenLogo: "images/restaurants/logo_nikko.jpg",
        imagenFondo: "images/restaurants/fondo_nikko.jpg",
        categoria: 'Italiana, Pizza',
        valoracion: 3,
        numValoraciones: 932,
        pedidoMinimo: 13.00,
        distancia: '1.4',
        envio: 0,
      ),
    ];
    */
  }

  void _fetchRestaurants() async {
    setState(() {
      isLoading = true;
    });

    listRestaurantes = await conectorBBDD.restaurantes();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return new Column(
        children: <Widget>[
          //Barra con el número de resturantes encontrados
          Card(
            color: new Color(0xffeeeeee),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 25,
              padding: const EdgeInsets.only(left: 15, top: 4),
              child: new Text(
                  listRestaurantes.length.toString() + ' restaurantes'),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: listRestaurantes.length,
                  itemBuilder: (context, int item) =>
                      new ItemRestauranteList(listRestaurantes[item])))
        ],
      );
    }
  }
}
