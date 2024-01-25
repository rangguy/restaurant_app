import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class FavoritePage extends StatelessWidget {
  static const String favoriteTitle = 'Favorites';

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const SliverAppBar(
                  backgroundColor: Colors.green,
                  floating: true,
                  pinned: true,
                  title: Text(
                    'Your favorite restaurants',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                ),
              ];
            },
            body: ListView.builder(
              itemCount: provider.bookmarks.length,
              itemBuilder: (context, index) {
                return CardRestaurant(restaurant: provider.bookmarks[index]);
              },
            ),
          );
        } else {
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const SliverAppBar(
                  backgroundColor: Colors.green,
                  floating: true,
                  pinned: true,
                  title: Text(
                    'Your favorite restaurants',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                ),
              ];
            },
            body: Center(
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
                    provider.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
