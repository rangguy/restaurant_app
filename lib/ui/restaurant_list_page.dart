import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/home_page';
  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    ApiService().listRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          // loading widget
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.green[100],
                  floating: false,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(60.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Search Your Favorite Restaurant',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextField(
                            focusNode: _focusNode,
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'Cari nama Restaurant atau makanan',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  color: Colors
                                      .black, // Ubah warna sesuai keinginan
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                            ),
                            onSubmitted: (value) {
                              setState(
                                () {
                                  _navigateToSearchRestaurant(value);
                                },
                              );
                              _searchController.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: ListView.builder(
              itemCount: state.result.restaurants.length,
              itemBuilder: (BuildContext context, int index) {
                var restaurant = state.result.restaurants[index];
                return CardRestaurant(
                  restaurant: restaurant,
                );
              },
            ),
          );
        } else if (state.state == ResultState.noData) {
          // error widget
          return Center(
            child: Material(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        } else if (state.state == ResultState.error) {
          // error widget
          return Center(
            child: Material(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }
      },
    );
  }

  _navigateToSearchRestaurant(String search) {
    _focusNode.unfocus();
    Navigator.pushNamed(
      context,
      SearchRestaurant.routeName,
      arguments: search,
    );
  }
}
