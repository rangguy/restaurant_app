import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_review.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantReviewProvider(
      {required this.apiService,
      required this.id,
      required this.name,
      required this.review}) {
    _addReview(id, name, review);
  }

  late RestaurantReview _restaurantReview;
  late ResultState _state;
  String _message = '';
  String id;
  String name;
  String review;

  String get message => _message;

  RestaurantReview get result => _restaurantReview;

  ResultState get state => _state;

  Future<dynamic> _addReview(String id, String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantReview = await apiService.addReview(id, name, review);
      if (restaurantReview.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantReview = restaurantReview;
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
