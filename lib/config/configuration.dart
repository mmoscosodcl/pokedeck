// configuration.dart

class Configuration {
  // Base URL for API requests
  static const String apiBaseUrl = 'https://pokeapi.co/api/v2';

  // Timeout duration for API requests
  static const Duration apiTimeout = Duration(seconds: 30);

  // Application name
  static const String appName = 'PokéDeck';

  // Other configuration constants can be added here
  static const String apiBaseSingleCard   = 'https://api.tcgdex.net/v2/en/cards/';
  static const String apiBaseAllCards     = 'https://api.tcgdex.net/v2/en/cards';
  static const String apiBaseCardSets     = 'https://api.tcgdex.net/v2/en/sets';

  //Series URL
  static const String apiSeriesUrl = 'https://api.tcgdex.net/v2/en/series/';

  //Sets URL
  static const String apiSetsUrl = 'https://api.tcgdex.net/v2/en/sets/';

}