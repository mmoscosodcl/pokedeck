import 'dart:developer';
import 'package:pokedeck/screens/card_screen.dart';
import 'package:pokedeck/screens/serie_screen.dart';
import 'package:pokedeck/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:pokedeck/config/configuration.dart';
import 'package:pokedeck/services/services_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Configuration configuration = Configuration();
  String apiBaseSingleCard = Configuration.apiBaseSingleCard;
  String apiBaseAllCards = Configuration.apiBaseAllCards;
   
  CardService servicesCard = CardService();

  late Future<List<dynamic>> cards;
  List<dynamic> allCards = []; // All cards data
  List<dynamic> filteredCards = []; // Filtered list
  String searchQuery = ""; // Search query
  String username = "User56589";
  String points = "1568";


  @override
  void initState() {
    super.initState();
    log('API Base Single Card: $apiBaseSingleCard');
    log('API Base All Cards: $apiBaseAllCards');

    cards = servicesCard.getCardsInfo();
    cards.then((data) {
      setState(() {
        allCards = data; // Store all cards data
        filteredCards = data; // Initialize filtered list
      });
    });
    log('Cards data initialized');
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
  }

  void navigateToSets() {
    // Navigate to Sets page (still not developed)
    log('Navigating to Sets page...');
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
      /*appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search by name...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.blueGrey),
          ),
          style: TextStyle(color: Colors.black87),
          onChanged: filterCards, // Update the filtered list on text change
        ),
      ),*/
      body: FutureBuilder<List<dynamic>>(
        future: cards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
        final cardData = snapshot.data!;
        return ListView.builder(
          itemCount: filteredCards.length,
          itemBuilder: (context, index) {
            final card = filteredCards[index];
            return CardItemWidget(
              id: card['id'] ?? 'Unknown',
              localId: card['localId'] ?? 'Unknown',
              name: card['name'] ?? 'Unknown',
              imageUrl: card['image'] ?? '',
              detailUrl: apiBaseSingleCard+'/'+card['id'] ?? ''
          );
          },
        );
          } else {
        return Center(child: Text('No data available'));
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
        child: BottomNavigationBar(
          elevation: 12,
          selectedFontSize: 16,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          currentIndex: 2, // Cards page is the current index
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          showSelectedLabels: true,
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


