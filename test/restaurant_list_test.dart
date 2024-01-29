import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import 'restaurant_list_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('List Restaurant', () {
    test('returns a RestaurantResult if the http call completes successfully',
        () async {
      final client = MockClient();
      var restaurant = ApiService(client);

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"error": false, "message": "success", "count": 20, "restaurants":[{"id":"rqdv5juczeskfw1e867", "name":"Mock", "description":"mock", "pictureId":"14", "city":"Medan", "rating": 4.0}]}',
              200));

      var result = await restaurant.listRestaurant();

      expect(result.restaurants[0], isA<Restaurant>());
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();
      var restaurant = ApiService(client);

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Use `throwsA` matcher to check if the exception is thrown
      expect(() async => await restaurant.listRestaurant(), throwsException);
    });
  });
}
