import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_review.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _list = 'list';
  static const String _detail = 'detail';
  static const String _review = 'review';

  Future<RestaurantResult> listRestaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl/$_list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<RestaurantDetailsResponse> detailRestaurant(String id) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/$_detail/$id"));
      if (response.statusCode == 200) {
        // Check for null or empty response body
        if (response.body.isEmpty) {
          throw Exception('Empty response body');
        }
        final dynamic responseData = json.decode(response.body);
        // Check if the JSON structure is as expected
        if (responseData is Map<String, dynamic>) {
          return RestaurantDetailsResponse.fromJson(responseData);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception(
            'Failed to load detail restaurant. Status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      // Print the error and stack trace for debugging
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      // Throw a generic exception message
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String restaurant) async {
    final response =
        await http.get(Uri.parse("$_baseUrl/search?q=$restaurant"));
    try {
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic>) {
          if (responseData['error'] == false) {
            final restaurantSearch =
                RestaurantSearchResponse.fromJson(responseData);
            return restaurantSearch;
          } else {
            throw Exception(
                'API returned an error: ${responseData['message']}');
          }
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception(
            'Failed to load detail restaurant. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<RestaurantReview> addReview(
      String id, String name, String review) async {
    final Uri uri = Uri.parse("$_baseUrl/$_review");

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      'id': id,
      'name': name,
      'review': review,
    };

    final String jsonBody = json.encode(body);

    final http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return RestaurantReview.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add restaurant review');
    }
  }
}
