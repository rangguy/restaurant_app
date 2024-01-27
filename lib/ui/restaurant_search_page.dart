import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class SearchRestaurant extends StatefulWidget {
  static const routeName = '/search_restaurant';
  final String search;

  const SearchRestaurant({super.key, required this.search});

  @override
  State<SearchRestaurant> createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  late String search;

  @override
  void initState() {
    super.initState();
    search = widget.search;
    ApiService().searchRestaurant(search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text(
          'Search Results for "${widget.search}"',
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigation.back(),
          color: Colors.white,
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: ListenableProvider<RestaurantSearchProvider>(
        create: (_) =>
            RestaurantSearchProvider(apiService: ApiService(), query: search),
        builder: (context, child) {
          return Consumer<RestaurantSearchProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                // loading widget
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              } else if (state.state == ResultState.hasData) {
                return ListView.builder(
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    var restaurant = state.result.restaurants[index];
                    return CardRestaurant(restaurant: restaurant);
                  },
                );
              } else if (state.state == ResultState.noData) {
                // error widget
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_off,
                        size: 100,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                );
              } else if (state.state == ResultState.error) {
                // error widget
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
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
        },
      ),
    );
  }
}
