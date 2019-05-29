import 'package:flutter/material.dart';

class RestaurantTypeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          RestaurantTypeItem("images/foodCategory/china.jpg", 'China', 'ho'),
          RestaurantTypeItem("images/foodCategory/sushi.jpg", 'Shushi', 'ho'),
          RestaurantTypeItem("images/foodCategory/pizza.jpg", 'Pizza', 'ho'),
          RestaurantTypeItem(
              "images/foodCategory/burger.jpg", 'Hamburguesas', 'ho'),
          RestaurantTypeItem(
              "images/foodCategory/italia.jpg", 'Italiana', 'ho'),
          RestaurantTypeItem("images/foodCategory/kebab.png", 'Kebab', 'ho'),
          RestaurantTypeItem(
              "images/foodCategory/desayuno.jpg", 'Desayunos', 'ho'),
          RestaurantTypeItem("images/foodCategory/vegano.jpg", 'Vegana', 'ho'),
        ],
      ),
    );
  }
}

class RestaurantTypeItem extends StatefulWidget {
  final String image_location;
  final String image_caption;
  final String text_filter;

  RestaurantTypeItem(this.image_location, this.image_caption, this.text_filter);
  @override
  State<StatefulWidget> createState() {
    return new _RestaurantTypeState();
  }
}

class _RestaurantTypeState extends State<RestaurantTypeItem> {
  bool selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // title: Image.asset(image),

    return Card(
        child: new InkWell(
      onTap: () {
        print("Categoría: " + widget.image_caption);
        setState(() {
          selected = !selected;
        });
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image_location),
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
                  visible: selected,
                  child: Icon(Icons.done, size: 14, color: Colors.green),
                ),
                Text(
                  widget.image_caption,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}