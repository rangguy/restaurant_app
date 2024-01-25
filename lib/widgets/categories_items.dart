import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class Categories extends StatelessWidget {
  final List<Category> categoryItem;

  const Categories({super.key, required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryItem.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  categoryItem[index].name,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
