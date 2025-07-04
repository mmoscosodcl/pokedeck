import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedeck/config/configuration.dart';



class SetService {
  String baseUrl;

  SetService() : baseUrl = Configuration.apiSetsUrl;

  Future<Map<String, dynamic>> getSet(String setId) async {
    this.baseUrl = Configuration.apiSetsUrl;
    final url = Uri.parse('$baseUrl$setId');
    log('Fetching set info from URL: $url');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      log('Response body: ${response.body}');
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load card information');
    }
  }

  Future<List<dynamic>> getSets() async {
    final baseUrl = Configuration.apiSetsUrl;
    final url = Uri.parse(baseUrl);
    log('Fetching all serie from URL: $url');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      log('Response body: ${response.body}');
      //Exclude the items that has name "Unown" from response.body
      final decodedResponse = json.decode(response.body) as List<dynamic>;
      final filteredResponse = decodedResponse.where((card) => card['name'] != 'Unown').toList();
      // Exclude the items that not has content in image
      //filteredResponse.removeWhere((card) => card['image'] == null || card['image'].isEmpty);
      log('Filtered response: $filteredResponse');
      // Return the filtered response
      return filteredResponse;
    } else {
      throw Exception('Failed to load card information');
    }
  }

}