import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final double restaurantRating;

  const RatingStar({super.key, required this.restaurantRating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) {
          double currentRating = restaurantRating;
          int fullStarCount = currentRating.floor();
          double decimalPart = currentRating - fullStarCount;
          if (index < fullStarCount) {
            // Bintang full
            return  Icon(Icons.star, color: Colors.yellow[900]);
          } else if (index == fullStarCount && decimalPart > 0.5) {
            // Pembulatan jika di atas 0.5
            return  Icon(Icons.star, color: Colors.yellow[900]);
          } else if (index == fullStarCount &&
              decimalPart <= 0.5 &&
              decimalPart > 0) {
            // Bintang menjadi setengah jika sama dengan atau kurang 0.5
            return  Icon(Icons.star_half, color: Colors.yellow[900]);
          } else {
            // Bintang kosong atau hanya border
            return  Icon(Icons.star_border, color: Colors.yellow[900]);
          }
        },
      ),
    );
  }
}
