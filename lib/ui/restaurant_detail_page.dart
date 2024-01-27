import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/detail_restaurant.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late String id;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    ApiService().detailRestaurant(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: const Text(
          'Restaurant App',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: ListenableProvider<RestaurantDetailProvider>(
          create: (_) =>
              RestaurantDetailProvider(apiService: ApiService(), id: widget.id),
          builder: (context, child) {
            return Consumer<RestaurantDetailProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  // loading widget
                  return const Center(
                    child: Material(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state.state == ResultState.hasData) {
                  var restaurant = state.result.restaurants;
                  return DetailRestaurant(restaurant: restaurant);
                } else if (state.state == ResultState.noData) {
                  // error widget with a more descriptive error message
                  return Center(
                    child: Material(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.restaurant_menu,
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
                  // error widget with a more descriptive error message
                  return Center(
                    child: Material(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } else {
                  // show a loading indicator
                  return const Center(
                    child: Material(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
