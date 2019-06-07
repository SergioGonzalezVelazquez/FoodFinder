import 'package:flutter/material.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/components/item_restaurante_list.dart';
import 'package:app_ipo/model/user_model.dart';

class RestaurantSearch extends SearchDelegate<String> {
  final List<Restaurante> restaurantes;
  final User _user;

  RestaurantSearch(this.restaurantes, this._user);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return  ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: restaurantes.length,
            itemBuilder: (context, int item) {
              if (query == null || query == '') {
                return ItemRestauranteList(restaurantes[item], _user);
              } else {
                return restaurantes[item]
                        .nombre
                        .toLowerCase()
                        .contains(query.toLowerCase())
                    ? ItemRestauranteList(restaurantes[item], _user)
                    : Container();
              }
            });
  }
}
