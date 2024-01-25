import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class ListCustomerReview extends StatelessWidget {
  final List<CustomerReview> reviewItems;

  const ListCustomerReview({super.key, required this.reviewItems});

  @override
  Widget build(BuildContext context) {
    return Column(
    children: List.generate(
      reviewItems.length,
      (index) {
        CustomerReview review = reviewItems[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            title: Text(
              review.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  review.date,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  review.review,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    ),
  );
  }
}

