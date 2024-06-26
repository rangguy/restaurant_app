import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/rating.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.isBookmarked(restaurant.id),
          builder: ((context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
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
                          RatingStar(
                            restaurantRating: restaurant.rating,
                          ),
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
                          onPressed: () {
                            provider.removeBookmark(restaurant.id);
                            final snackBar = SnackBar(
                              content:
                                  const Text('Menghapus Resto dari favorit'),
                              duration: const Duration(milliseconds: 330),
                              action: SnackBarAction(
                                label: 'Batalkan',
                                onPressed: () =>
                                    provider.addBookmark(restaurant),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          })
                      : IconButton(
                          icon: const Icon(Icons.favorite_border),
                          color: Colors.red[800],
                          onPressed: () {
                            provider.addBookmark(restaurant);
                            final snackBar = SnackBar(
                              content: const Text('Menambah Resto ke favorit'),
                              duration: const Duration(milliseconds: 330),
                              action: SnackBarAction(
                                label: 'Batalkan',
                                onPressed: () =>
                                    provider.removeBookmark(restaurant.id),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }),
                  onTap: () => Navigation.intentWithData(
                      RestaurantDetailPage.routeName, restaurant.id),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class FavoriteButton extends StatefulWidget {
  final bool isBookmarked;
  final Restaurant restaurant;
  final DatabaseProvider provider;
  const FavoriteButton(
      {super.key,
      required this.isBookmarked,
      required this.restaurant,
      required this.provider});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final snackBar = SnackBar(
          content: const Text('Menambah Resto ke favorit'),
          action: SnackBarAction(
            label: 'Batalkan',
            onPressed: () =>
                widget.provider.removeBookmark(widget.restaurant.id),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      icon: widget.isBookmarked
          ? IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.red[800],
              onPressed: () =>
                  widget.provider.removeBookmark(widget.restaurant.id),
            )
          : IconButton(
              icon: const Icon(Icons.favorite_border),
              color: Colors.red[800],
              onPressed: () => widget.provider.addBookmark(widget.restaurant),
            ),
    );
  }
}
