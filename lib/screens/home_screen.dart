import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pokedeck/screens/card_screen.dart';
import 'package:pokedeck/screens/profile_screen.dart';
import 'package:pokedeck/screens/serie_screen.dart';
import 'package:pokedeck/screens/set_screen.dart';
import 'package:flutter/material.dart';
import 'package:pokedeck/config/configuration.dart';
import 'package:pokedeck/services/services_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String apiBaseSingleCard = Configuration.apiBaseSingleCard;
  String apiBaseAllCards = Configuration.apiBaseAllCards;
  
  CardService servicesCard = CardService();

  late Future<List<dynamic>> cards;
  List<dynamic> allCards = []; // All cards data
  List<dynamic> filteredCards = []; // Filtered list
  late Future<List<dynamic>> series;
  bool isConnected = true; // Connection status 

  String searchQuery = ""; // Search query
  String username = "User56589";
  String points = "1568";


  @override
  void initState() {
    super.initState();

    //Check connection status
    log('Checking connection status...');
    checkConnectivity();

    // Listen for connectivity changes
     

    // Fetch all cards data
    if (isConnected) {  
      cards = servicesCard.getCardsRamdomly();
      cards.then((data) {
        setState(() {
          allCards = data; // Store all cards data
        });
      });
      log('Cards data initialized');
    }
  }

  void checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
    });

    if (!isConnected) {
      log('No internet connection');
      showNoInternetDialog();
    }
  }

   void showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Internet Connection'),
        content: Text('Please check your internet connection and try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void filterCards(String query) {
    setState(() {
      searchQuery = query;
      filteredCards = query.isEmpty
          ? allCards
          : allCards.where((card) {
              final name = card['name']?.toLowerCase() ?? '';
              return name.contains(query.toLowerCase());
            }).toList();
    });
  }

  void navigateToProfile() {
    // Navigate to the profile page (still not developed)
    log('Navigating to profile page...');
    Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      ),
    );
  }

  void navigateToSets() {
    // Navigate to Sets page (still not developed)
    log('Navigating to Sets page...');
    Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => SetScreen()
      ),
    );
  }

  void navigateToSeries() {
    // Navigate to Series page (still not developed)
    log('Navigating to Series page...');
    Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => SerieScreen(),
      ),
    );
  }
  
  void navigateToCards() {
    // Navigate to Series page (still not developed)
    log('Navigating to Series page...');
    Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => CardScreen(),
      ),
    );
  }

  void navigateToDecks() {
    // Navigate to Decks page (still not developed)
    log('Navigating to Decks page...');
  }

  @override
  Widget build(BuildContext context) {
    if (!isConnected) {
      return Scaffold(
        appBar: AppBar(
          title: Text('No Internet'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Text(
            'Please check your internet connection.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Username and points
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Points: ${points}',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            // Right: Circular avatar
            GestureDetector(
              onTap: navigateToProfile,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  username[0].toUpperCase(),
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Row: News and Search Bar
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'News',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search cards by name...',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: filterCards,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Second Row: Card of the Day
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card of the Day',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        FutureBuilder<Map<String, dynamic>>(
                            future: servicesCard.getCardInfo(
                            allCards.isNotEmpty
                              ? allCards[(DateTime.now().millisecondsSinceEpoch % allCards.length)]['id']
                              : 'randomCardId', // Fallback if no cards are available
                            ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final card = snapshot.data!;
                              return Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      card['image']+'/low.png' ?? '',
                                      width: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey.shade200,
                                          child: Center(
                                            child: Icon(Icons.error, color: Colors.red, size: 24),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      card['name'] ?? 'Unknown Card',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Text('No card available');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Third Row: Carousel of Series Images
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cards',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 150, // Set height for the carousel
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: allCards.length, // Replace with series data
                            itemBuilder: (context, index) {
                              final serie = allCards[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    serie['image']+'/low.png' ?? '',
                                    width: 100,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 150,
                                        color: Colors.grey.shade200,
                                        child: Center(
                                          child: Icon(Icons.error, color: Colors.red, size: 24),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )
      ,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
        child: BottomNavigationBar(
          elevation: 12,
          selectedFontSize: 16,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          //currentIndex: 2, // Cards page is the current index
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          //showSelectedLabels: true,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.layers),
              label: 'Sets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Series',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.style),
              label: 'Cards',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.deck),
              label: 'Decks',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                navigateToSets();
                break;
              case 1:
                navigateToSeries();
                break;
              case 2:
                navigateToCards();
                break;
              case 3:
                navigateToDecks();
                break;
            }
          },
        ),
      ),
    );
  }
}


