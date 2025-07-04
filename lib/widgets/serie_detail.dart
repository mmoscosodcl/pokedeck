import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:developer';

import 'package:pokedeck/services/services_serie.dart';

class SerieDetailScreen extends StatefulWidget {
  final String id;
  final String name;
  final String imageUrl;

  const SerieDetailScreen({
    required this.id,
    required this.name,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  _SerieDetailScreenState createState() => _SerieDetailScreenState();
}

class _SerieDetailScreenState extends State<SerieDetailScreen> {
  late FlutterTts flutterTts;
  late String imageHighPng = '';
  SerieService servicesSerie = SerieService();
  Future<Map<String, dynamic>> detailCard = Future.value({});
  bool isLiked = false;
  

  @override
  void initState() {
    super.initState();

    //Getting detail of card
    log('Serie ID: ${widget.id}');
    servicesSerie..getSerie(widget.id).then((result) {
      print('Serie Details: $result');
    }).catchError((error) {
      print('Error fetching card details: $error');
    });

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
      future: servicesSerie.getSerie(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final serieDetails = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    serieDetails['logo']+'.png' ?? '',
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
                // Series Name
                Text(
                  serieDetails['name'] ?? 'Unknown Series',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                // Release Date
                Text(
                  'Release Date: ${serieDetails['releaseDate'] ?? 'Unknown'}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                // First Set
                Text(
                  'First Set:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        serieDetails['firstSet']?['logo']+'.png' ?? '',
                        width: 50,
                        height: 50,
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
                        serieDetails['firstSet']?['name'] ?? 'Unknown',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Last Set
                Text(
                  'Last Set:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        serieDetails['lastSet']?['logo']+'.png' ?? '',
                        width: 50,
                        height: 50,
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
                        serieDetails['lastSet']?['name'] ?? 'Unknown',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Sets List
                Text(
                  'Sets:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: serieDetails['sets']?.length ?? 0,
                  itemBuilder: (context, index) {
                    final set = serieDetails['sets']?[index];
                    final logoUrl = set['logo'] != null ? '${set['logo']}.png' : ''; // Check for null and concatenate
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          logoUrl,
                          width: 50,
                          height: 50,
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
                      title: Text(set['name'] ?? 'Unknown'),
                      subtitle: Text(
                        'Cards: ${set['cardCount']?['official'] ?? 0} / ${set['cardCount']?['total'] ?? 0}',
                      ),
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