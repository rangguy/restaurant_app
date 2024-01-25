import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDetailsResponse {
  bool error;
  String message;
  RestaurantDetails restaurants;

  RestaurantDetailsResponse({
    required this.error,
    required this.message,
    required this.restaurants,
  });

  factory RestaurantDetailsResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailsResponse(
      error:
          json['error'] ?? true, // Provide a default value or handle null case
      message:
          json['message'] ?? '', // Provide a default value or handle null case
      restaurants: RestaurantDetails.fromJson(json["restaurant"]),
    );
  }
}

class RestaurantDetails {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menu menus;
  double rating;
  List<CustomerReview> customerReviews;

  RestaurantDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) {
    return RestaurantDetails(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: json["pictureId"],
      categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x)),
      ),
      menus: Menu.fromJson(json["menus"]),
      rating: json["rating"].toDouble(),
      customerReviews: List<CustomerReview>.from(
        json["customerReviews"].map((x) => CustomerReview.fromJson(x)),
      ),
    );
  }

  Restaurant toRestaurant() {
    return Restaurant(
      id: id,
      name: name,
      description: description,
      city: city,
      pictureId: pictureId,
      rating: rating,
    );
  }
}

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json["name"],
    );
  }
}

class Menu {
  List<MenuItem> foods;
  List<MenuItem> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      foods: List<MenuItem>.from(
        json["foods"].map((x) => MenuItem.fromJson(x)),
      ),
      drinks: List<MenuItem>.from(
        json["drinks"].map((x) => MenuItem.fromJson(x)),
      ),
    );
  }
}

class MenuItem {
  String name;

  MenuItem({
    required this.name,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json["name"],
    );
  }
}

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json["name"],
      review: json["review"],
      date: json["date"],
    );
  }
}
