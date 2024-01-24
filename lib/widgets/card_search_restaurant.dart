import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/rating.dart';

class CardSearchRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardSearchRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.isBookmarked(restaurant.id),
          builder: ((context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              color: primaryColor,
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  leading: Hero(
                    tag: restaurant.id,
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                      width: 100,
                      errorBuilder: (ctx, error, _) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          const SizedBox(width: 5),
                          Text(
                            restaurant.city,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RatingStar(restaurantRating: restaurant.rating),
                          const SizedBox(width: 5),
                          Text(
                            '(${restaurant.rating.toString()})',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: isBookmarked
                      ? IconButton(
                          icon: const Icon(Icons.favorite),
                          color: Colors.red[800],
                          onPressed: () => provider.removeBookmark(restaurant.id),
                        )
                      : IconButton(
                          icon: const Icon(Icons.favorite_border),
                          color: Colors.red[800],
                          onPressed: () => provider.addBookmark(restaurant),
                        ),
                  onTap: () {
                    Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                        arguments: restaurant.id);
                  },
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
