import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import 'restaurant_provider_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('List Restaurant', () {
    test('returns an Restaurant if the http call completes successfully',
        () async {
      final client = MockClient();
      var restaurant = RestaurantProvider(apiService: ApiService());

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async =>
              http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await restaurant.fetchAllRestaurant(), isA<RestaurantResult>());
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();
      var restaurant = RestaurantProvider(apiService: ApiService());

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(await restaurant.fetchAllRestaurant(), throwsException);
    });
  });
}
