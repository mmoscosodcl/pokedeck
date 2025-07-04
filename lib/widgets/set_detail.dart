import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:developer';

import 'package:pokedeck/services/services_serie.dart';
import 'package:pokedeck/services/services_set.dart';
import 'package:pokedeck/widgets/card_item.dart';

class SetDetailScreen extends StatefulWidget {
  final String id;
  final String name;
  final String imageUrl;

  const SetDetailScreen({
    required this.id,
    required this.name,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  _SetDetailScreenState createState() => _SetDetailScreenState();
}

class _SetDetailScreenState extends State<SetDetailScreen> {
  late FlutterTts flutterTts;
  late String imageHighPng = '';
  SetService services = SetService();
  Future<Map<String, dynamic>> detailCard = Future.value({});
  bool isLiked = false;
  

  @override
  void initState() {
    super.initState();

    //Image
    imageHighPng = widget.imageUrl+'.png';
    log('Image URL: $imageHighPng');


    flutterTts = FlutterTts();

    // Configure TTS settings
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.5);
  }

  @override
  void dispose() {
    flutterTts.stop(); // Stop any ongoing speech
    flutterTts = FlutterTts(); // Dispose of the TTS instance
    super.dispose();
  }

  void speak(String text) async {
    await flutterTts.speak(text);
  }
  
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.name),
      backgroundColor: Colors.blueGrey,
    ),
    body: FutureBuilder<Map<String, dynamic>>(
      future: services.getSet(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final setDetails = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageHighPng ?? '',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade200,
                        child: Center(
                          child: Icon(Icons.error, color: Colors.red, size: 50),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                // Set Name
                Text(
                  setDetails['name'] ?? 'Unknown Set',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                // Release Date
                Text(
                  'Release Date: ${setDetails['releaseDate'] ?? 'Unknown'}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                // Card Counts
                Text(
                  'Card Counts:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Official: ${setDetails['cardCount']?['official'] ?? 0}'),
                        Text('Total: ${setDetails['cardCount']?['total'] ?? 0}'),
                        Text('Normal: ${setDetails['cardCount']?['normal'] ?? 0}'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Holo: ${setDetails['cardCount']?['holo'] ?? 0}'),
                        Text('Reverse: ${setDetails['cardCount']?['reverse'] ?? 0}'),
                        Text('First Ed: ${setDetails['cardCount']?['firstEd'] ?? 0}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Legal Status
                Text(
                  'Legal Status:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Standard: ${setDetails['legal']?['standard'] == true ? 'Legal' : 'Not Legal'}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Expanded: ${setDetails['legal']?['expanded'] == true ? 'Legal' : 'Not Legal'}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Series Information
                Text(
                  'Series:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          setDetails['serie']?['name'] ?? 'Unknown Series',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'ID: ${setDetails['serie']?['id'] ?? 'Unknown'}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Cards Section
                Text(
                  'Cards:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                setDetails['cards']?.isEmpty ?? true
                    ? Text('No cards available for this set.')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: setDetails['cards']?.length ?? 0,
                        itemBuilder: (context, index) {
                          final card = setDetails['cards']?[index];
                          return CardItemWidget(
                            id: card['id'] ?? 'Unknown',
                            localId: card['localId'] ?? 'Unknown',
                            name: card['name'] ?? 'Unknown',
                            imageUrl: card['image'] ?? '',
                            detailUrl: card['detailUrl'] ?? '',
                          );
                        },
                      ),
              ],
            ),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    ),
  );
}


}