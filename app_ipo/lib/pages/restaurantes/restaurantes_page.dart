import 'package:flutter/material.dart';

//my own imports
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/data/gestorBBDD.dart';
import 'package:app_ipo/pages/my_drawer.dart';
import 'package:app_ipo/components/item_restaurante_list.dart';
import 'package:app_ipo/pages/restaurantes/restaurant_search.dart';

class RestaurantesPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/restaurantes";
  final User _user;
  RestaurantesPage(this._user);

  @override
  State<StatefulWidget> createState() => new _RestaurantesPageState();
}

class _RestaurantesPageState extends State<RestaurantesPage> {
  // I need something like this To determine if SliverAppBar is expanded or not.
  ScrollController _scrollController;
  bool isAppBarExpanded = false;
  List<String> filter;
  //Listado de todos los restaurantes recuperados del servidor
  List<Restaurante> allRestaurants;
  //Listado de todos los restaurantes recuperados del servidor
  List<Restaurante> filterRestaurants;
  bool isLoading;

  void _fetchRestaurants() async {
    setState(() {
      isLoading = true;
    });

    allRestaurants = await ConectorBBDD.restaurantes();
    filterRestaurants = new List.from(allRestaurants);

    if (this.mounted) {
      /*Si no comprobamos esto, puede saltar excepción si cambiamos
       de página antes de que la descarga se haya completado*/
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    filter = new List<String>();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    _fetchRestaurants();
  }

  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  bool get _changecolor {
    if (_getAppBarCollapsePercent() == 1)
      return true;
    else {
      return false;
    }
  }

  double _getAppBarCollapsePercent() {
    if (!_scrollController.hasClients || _scrollController.positions.length > 1)
      return 0.0;

    return (_scrollController.offset /
            ((MediaQuery.of(context).size.height / 2.5) - kToolbarHeight))
        .clamp(0.0, 1.0);
  }

  void filtrarRestaurantes(String restFilter) {
    setState(() {
      if (filter.contains(restFilter.toLowerCase())) {
        filter.remove(restFilter.toLowerCase());
      } else {
        filter.add(restFilter.toLowerCase());
      }

      filterRestaurants.clear();
      if (filter.length == 0) {
        //Si el filtro está vacío...
        filterRestaurants.addAll(allRestaurants);
      } else {
        allRestaurants.forEach((restaurant) {
          filter.forEach((f) {
            if (restaurant.categoria.toLowerCase().contains(f) &&
                (!filterRestaurants.contains(restaurant))) {
              filterRestaurants.add(restaurant);
            }
          });
        });
      }
    });
  }

  void _showModal() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                title: new Text('Relevantes'),
                onTap: () {
                  setState(() {
                    filterRestaurants.sort((a, b) =>
                        b.numValoraciones.compareTo(a.numValoraciones));
                  });
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                title: new Text('Valoración'),
                onTap: () {
                  setState(() {
                    filterRestaurants
                        .sort((a, b) => b.valoracion.compareTo(a.valoracion));
                  });
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                title: new Text('Distancia'),
                onTap: () {
                  setState(() {
                    filterRestaurants
                        .sort((a, b) => a.distancia.compareTo(b.distancia));
                  });
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                title: new Text('Pedido Mínimo'),
                onTap: () {
                  setState(() {
                    filterRestaurants.sort(
                        (a, b) => a.pedidoMinimo.compareTo(b.pedidoMinimo));
                  });
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                title: new Text('Gatos de entrega'),
                onTap: () {
                  setState(() {
                    filterRestaurants
                        .sort((a, b) => a.envio.compareTo(b.envio));
                  });
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                title: new Text('Oferta'),
                onTap: () {
                  setState(() {
                    filterRestaurants
                        .sort((a, b) => b.descuento.compareTo(a.descuento));
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  _buildAppBar() {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: _changecolor
            ? Theme.of(context).primaryColor
            : Theme.of(context).bottomAppBarColor,
      ),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      expandedHeight: MediaQuery.of(context).size.height / 2.5,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
                context: context,
                delegate: RestaurantSearch(allRestaurants, widget._user));
          },
        ),
        IconButton(
          icon: Icon(Icons.sort),
          onPressed: () {
            _showModal();
          },
        ),
      ],
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          title: Text(
            _changecolor ? "Food Finder" : '',
          ),
          centerTitle: true,
          background: _panelBusqueda()),
    );
  }

  Widget _panelBusqueda() {
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height / 3.5,
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.white.withOpacity(0.9), BlendMode.modulate),
              image: AssetImage(
                "images/customer-experience2.jpg",
              ),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            color: Colors.black38,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Pide lo que te pida el cuerpo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Comida a domicilio online cerca de ti',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      margin: EdgeInsets.only(left: 40, right: 40),
                      padding: EdgeInsets.only(
                          top: 4, left: 10, right: 4, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: new Row(
                        children: <Widget>[
                          new Flexible(
                            child: new TextField(
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black),
                              decoration: InputDecoration.collapsed(
                                hintText: "ej. Calle Alcalá, 48, Madrid",
                              ),
                            ),
                          ),
                          new FlatButton(
                            child: Text(
                              'Buscar',
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: "Funcionalidad no implementada... :(");
                            },
                          ),
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// -------------------------------------------------------------- ///
  ///                     WIDGETS LISTADOS                           ///
  /// -------------------------------------------------------------- ///

  Widget listViewRestaurant() {
    return new Column(
      children: <Widget>[
        //Barra con el número de resturantes encontrados
        Card(
          color: new Color(0xffeeeeee),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 25,
            padding: const EdgeInsets.only(left: 15, top: 4),
            child:
                new Text(filterRestaurants.length.toString() + ' restaurantes'),
          ),
        ),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: filterRestaurants.length,
                itemBuilder: (context, int item) {
                  return ItemRestauranteList(
                      filterRestaurants[item], widget._user);
                }))
      ],
    );
  }

  Widget listViewCategorias() {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          categoriaItem("images/foodCategory/china.jpg", 'China'),
          categoriaItem("images/foodCategory/sushi.jpg", 'Sushi'),
          categoriaItem("images/foodCategory/pizza.jpg", 'Pizza'),
          categoriaItem("images/foodCategory/burger.jpg", 'Hamburguesas'),
          categoriaItem("images/foodCategory/italia.jpg", 'Italiana'),
          categoriaItem(
            "images/foodCategory/kebab.png",
            'Kebab',
          ),
          categoriaItem("images/foodCategory/desayuno.jpg", 'Desayunos'),
          categoriaItem("images/foodCategory/vegano.jpg", 'Vegana'),
        ],
      ),
    );
  }

  Widget categoriaItem(
    String imageLocation,
    String textFilter,
  ) {
    return Card(
        child: new InkWell(
      onTap: () {
        filtrarRestaurantes(textFilter);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageLocation),
                fit: BoxFit.fitHeight,
                alignment: FractionalOffset.topCenter,
                //alignment: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: filter.contains(textFilter.toLowerCase()),
                  child: Icon(Icons.done, size: 14, color: Colors.green),
                ),
                Text(
                  textFilter,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: (filter.contains(textFilter.toLowerCase()))
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  /// -------------------------------------------------------------- ///
  ///                           BUILD                                ///
  /// -------------------------------------------------------------- ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(widget._user, index: MyDrawer.indexRestaurantes),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildAppBar(),
          ];
        },
        body: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text('Tipos de cocinas populares'),
              ),
              //Scroll horizontal con categorías de restaurantes
              listViewCategorias(),
              //Listado de restaurantes según el filtro
              Expanded(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                        )
                      : listViewRestaurant())
              //RestaurantsList(),
            ],
          ),
        ),
      ),
    );
  }
}
