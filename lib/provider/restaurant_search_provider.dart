import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService, required this.query}) {
    _searchRestaurant(query);
  }

  late RestaurantSearchResponse _restaurantSearchResult;
  late ResultState _state;
  String _message = '';
  String query;

  String get message => _message;

  RestaurantSearchResponse get result => _restaurantSearchResult;

  ResultState get state => _state;

  Future<dynamic> _searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await apiService.searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantSearchResult = restaurant;
      }
    } catch (e) {
       var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        _state = ResultState.error;
        _message = 'No internet connection';
      } else {
        _state = ResultState.error;
        _message = 'Error --> $e';
      }
      notifyListeners();
      return _message;
    }
  }
}
