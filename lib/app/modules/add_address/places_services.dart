import 'dart:convert';
import 'package:http/http.dart' as http;

class PlacesService {
  final String apiKey;

  PlacesService(this.apiKey);

  Future<List<Map<String, dynamic>>> getAutocomplete(String input) async {
    final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {

      final decoded = json.decode(response.body);
      final predictions = decoded['predictions'] as List;
      return predictions.map((p) {
        return {
          'description': p['description'],
          'place_id': p['place_id'],
        };
      }).toList();
    } else {
      throw Exception('Failed to fetch autocomplete');
    }
  }

  Future<Map<String, double>> getPlaceLatLng(String placeId) async {
    final url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['result'];
      final location = result['geometry']['location'];
      return {
        'lat': location['lat'],
        'lng': location['lng'],
      };
    } else {
      throw Exception('Failed to fetch place details');
    }
  }
}
