import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class MenuItems extends StatelessWidget {
  final List<MenuItem> menuItem;

  const MenuItems({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menuItem.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  menuItem[index].name,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
