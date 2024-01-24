class RestaurantReview {
  final String id;
  final String name;
  final String review;

  RestaurantReview({
    required this.id,
    required this.name,
    required this.review,
  });

  factory RestaurantReview.fromJson(Map<String, dynamic> json) {
    return RestaurantReview(
      id: json['id'],
      name: json['name'],
      review: json['review'],
    );
  }
}