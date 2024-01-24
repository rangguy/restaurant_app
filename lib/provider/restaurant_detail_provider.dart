import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _detailRestaurant(id);
  }

  late RestaurantDetailsResponse _restaurantDetails;
  late ResultState _state;
  String _message = '';
  String id = '';

  String get message => _message;

  RestaurantDetailsResponse get result => _restaurantDetails;

  ResultState get state => _state;

  Future<dynamic> _detailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await apiService.detailRestaurant(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantDetails = restaurant;
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
