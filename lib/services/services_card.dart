import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedeck/config/configuration.dart';



class CardService {
  String baseUrl;

  CardService() : baseUrl = Configuration.apiBaseUrl;

  Future<Map<String, dynamic>> getCardInfo(String cardId) async {
    this.baseUrl = Configuration.apiBaseSingleCard;
    final url = Uri.parse('$baseUrl$cardId');
    print('Fetching card info from URL: $url');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load card information');
    }
  }

  Future<List<dynamic>> getCardsInfo() async {
    final baseUrl = Configuration.apiBaseAllCards;
    final url = Uri.parse(baseUrl);
    log('Fetching all cards from URL: $url');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      log('Response body: ${response.body}');
      //Exclude the items that has name "Unown" from response.body
      final decodedResponse = json.decode(response.body) as List<dynamic>;
      final filteredResponse = decodedResponse.where((card) => card['name'] != 'Unown').toList();
      // Exclude the items that not has content in image
      filteredResponse.removeWhere((card) => card['image'] == null || card['image'].isEmpty);
      log('Filtered response: $filteredResponse');
      // Return the filtered response
      return filteredResponse;
    } else {
      throw Exception('Failed to load card information');
    }
  }

  Future<List<dynamic>> getCardsRamdomly() async {
    final url = Uri.parse("https://api.tcgdex.net/v2/en/cards?pagination:page=3&pagination:itemsPerPage=10");
    log('Fetching cards from URL: $url');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      log('Response body: ${response.body}');
      final decodedResponse = json.decode(response.body) as List<dynamic>;
      // Exclude the items that not has content in image
      decodedResponse.removeWhere((card) => card['image'] == null || card['image'].isEmpty);
      log('Filtered response: $decodedResponse');
      return decodedResponse;
    } else {
      throw Exception('Failed to load cards by series');
    }
  }


}