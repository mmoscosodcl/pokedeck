import 'dart:developer';
import 'package:pokedeck/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:pokedeck/config/configuration.dart';
import 'package:pokedeck/services/services_card.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {

  Configuration configuration = Configuration();
  String apiBaseSingleCard = Configuration.apiBaseSingleCard;
  String apiBaseAllCards = Configuration.apiBaseAllCards;
   
  CardService servicesCard = CardService();

  late Future<List<dynamic>> cards;
  List<dynamic> allCards = []; // All cards data
  List<dynamic> filteredCards = []; // Filtered list
  String searchQuery = ""; // Search query


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search by name...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.blueGrey),
          ),
          style: TextStyle(color: Colors.black87),
          onChanged: filterCards, // Update the filtered list on text change
        ),
      ),
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
    );
  }
}


