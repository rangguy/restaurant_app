import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widgets/add_customer_review.dart';
import 'package:restaurant_app/widgets/categories_items.dart';
import 'package:restaurant_app/widgets/list_customer_review.dart';
import 'package:restaurant_app/widgets/menu_items.dart';
import 'package:restaurant_app/widgets/rating.dart';

class DetailRestaurant extends StatefulWidget {
  final RestaurantDetails restaurant;

  const DetailRestaurant({super.key, required this.restaurant});

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  bool isDescriptionExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.isBookmarked(widget.restaurant.id),
          builder: ((context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Column(
              children: [
                Hero(
                  tag: widget.restaurant.id,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.restaurant.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {},
                              ),
                              isBookmarked
                                  ? IconButton(
                                      icon: const Icon(Icons.favorite),
                                      color: Colors.red[800],
                                      onPressed: () {
                                        provider.removeBookmark(
                                            widget.restaurant.id);
                                        final snackBar = SnackBar(
                                          content: const Text(
                                              'Menghapus Resto dari favorit'),
                                          duration:
                                              const Duration(milliseconds: 330),
                                          action: SnackBarAction(
                                            label: 'Batalkan',
                                            onPressed: () => provider
                                                .addBookmark(widget.restaurant
                                                    .toRestaurant()),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      })
                                  : IconButton(
                                      icon: const Icon(Icons.favorite_border),
                                      color: Colors.red[800],
                                      onPressed: () {
                                        provider.addBookmark(
                                            widget.restaurant.toRestaurant());
                                        final snackBar = SnackBar(
                                          content: const Text(
                                              'Menambah Resto ke favorit'),
                                          duration:
                                              const Duration(milliseconds: 330),
                                          action: SnackBarAction(
                                            label: 'Batalkan',
                                            onPressed: () =>
                                                provider.removeBookmark(
                                                    widget.restaurant.id),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                    ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                          ),
                          const SizedBox(width: 5),
                          Text(
                              "${widget.restaurant.address},  Kota ${widget.restaurant.city}"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          RatingStar(
                              restaurantRating: widget.restaurant.rating),
                          const SizedBox(width: 5),
                          Text(
                            widget.restaurant.rating.toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Divider(height: 10),
                      const SizedBox(height: 10),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.restaurant.description,
                        maxLines: isDescriptionExpanded ? null : 4,
                        style: const TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDescriptionExpanded = !isDescriptionExpanded;
                          });
                        },
                        child: Text(
                          isDescriptionExpanded ? 'Read Less' : 'Read More',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 10),
                      const SizedBox(height: 10),
                      const Text(
                        'Categories ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Categories(categoryItem: widget.restaurant.categories),
                      const SizedBox(height: 10),
                      const Divider(height: 10),
                      const SizedBox(height: 10),
                      const Text(
                        'Menus ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Foods:',
                      ),
                      MenuItems(menuItem: widget.restaurant.menus.foods),
                      const SizedBox(height: 10),
                      const Text(
                        'Drinks:',
                      ),
                      MenuItems(menuItem: widget.restaurant.menus.drinks),
                      const SizedBox(height: 10),
                      const Divider(height: 10),
                      const SizedBox(height: 10),
                      const Text(
                        'Leave a Review',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      AddReview(idRestaurant: widget.restaurant.id),
                      const SizedBox(height: 10),
                      const Divider(height: 10),
                      const SizedBox(height: 10),
                      const Text(
                        'Customer Reviews',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ListCustomerReview(
                          reviewItems: widget.restaurant.customerReviews),
                    ],
                  ),
                )
              ],
            );
          }),
        );
      },
    );
  }
}
