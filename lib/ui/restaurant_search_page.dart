import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_search_restaurant.dart';

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
        title: const Text(
          'Search Results',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
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
                    return CardSearchRestaurant(restaurant: restaurant);
                  },
                );
              } else if (state.state == ResultState.noData) {
                // error widget
                return Center(
                  child: Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 100, // Adjust the size as needed
                          color: Colors.red,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
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
        },
      ),
    );
  }
}
