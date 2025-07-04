import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedeck/config/configuration.dart';



class SerieService {
  String baseUrl;

  SerieService() : baseUrl = Configuration.apiSeriesUrl;

  Future<Map<String, dynamic>> getSerie(String serieId) async {
    this.baseUrl = Configuration.apiSeriesUrl;
    final url = Uri.parse('$baseUrl$serieId');
    print('Fetching serie info from URL: $url');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load card information');
    }
  }

  Future<List<dynamic>> getSeries() async {
    final baseUrl = Configuration.apiSeriesUrl;
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

  Future<List<dynamic>> getSeriesRandom() async {
    final baseUrl = "${Configuration.apiSeriesUrl}logo=notnull:&pagination:page=2&pagination:itemsPerPage=5";
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
      throw Exception('Failed to load series information');
    }
  }

}