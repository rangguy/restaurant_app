import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/home_page';
  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
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
                const SliverAppBar(
                  backgroundColor: Colors.green,
                  floating: true,
                  pinned: true,
                  title: Text(
                    'List of restaurants',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ];
            },
            body: ListView.builder(
              itemCount: state.result!.restaurants.length,
              itemBuilder: (BuildContext context, int index) {
                var restaurant = state.result!.restaurants[index];
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
}
