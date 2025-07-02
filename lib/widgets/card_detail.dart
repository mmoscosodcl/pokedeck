import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pokedeck/services/services_card.dart';
import 'dart:developer';

class CardDetailScreen extends StatefulWidget {
  final String id;
  final String localId;
  final String name;
  final String imageUrl;
  final String detailUrl;

  const CardDetailScreen({
    required this.id,
    required this.localId,
    required this.name,
    required this.imageUrl,
    required this.detailUrl,
    Key? key,
  }) : super(key: key);

  @override
  _CardDetailScreenState createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  late FlutterTts flutterTts;
  late String imageHighPng = '';
  CardService servicesCard = CardService();
  Future<Map<String, dynamic>> detailCard = Future.value({});
  bool isLiked = false;
  

  @override
  void initState() {
    super.initState();

    //Getting detail of card
    print('Card ID: ${widget.id}');
    //detailCard = servicesCard.getCardInfo(widget.id);
    //print('Detail URL: ${detailCard}');

    servicesCard.getCardInfo(widget.id).then((result) {
    print('Card Details: $result');
  }).catchError((error) {
    print('Error fetching card details: $error');
  });

    //Image
    imageHighPng = widget.imageUrl+'/high.png';
    print('Image URL: $imageHighPng');


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
    body: FutureBuilder<Map<String, dynamic>>(
      future: servicesCard.getCardInfo(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final cardDetails = snapshot.data!;
          bool isLiked = false; // Track the like button state

          return Stack(
            children: [
              // Full-screen card layout
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Top image with like button
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('${cardDetails['image']}/high.png'),
                            ),
                          ),
                          child: Container(
                            // Optional overlay for better text visibility
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.transparent,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        // Like button
                        Positioned(
                          top: 20,
                          right: 20,
                          child: StatefulBuilder(
                            builder: (context,setState) {
                            return IconButton(
                              icon: Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                color: isLiked ? Colors.red : Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  log("Like button pressed");
                                  isLiked = !isLiked;
                                });
                              },
                            );
                            }
                          ),
                        ),
                      ],
                    ),
                    // Content body
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cardDetails['name'] ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.volume_up, color: Colors.blue),
                                onPressed: () {
                                  speak(cardDetails['name'] ?? 'Unknown');
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          // Illustrator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Illustrator: ${cardDetails['illustrator'] ?? 'Unknown'}',
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: Icon(Icons.volume_up, color: Colors.blue),
                                onPressed: () {
                                  speak('Illustrator: ${cardDetails['illustrator'] ?? 'Unknown'}');
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          // Category and Rarity
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Category: ${cardDetails['category'] ?? 'Unknown'}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Rarity: ${cardDetails['rarity'] ?? 'Unknown'}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.volume_up, color: Colors.blue),
                                onPressed: () {
                                  speak(
                                    'Category: ${cardDetails['category'] ?? 'Unknown'}\nRarity: ${cardDetails['rarity'] ?? 'Unknown'}',
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          // HP and Types
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'HP: ${cardDetails['hp'] ?? 'Unknown'}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Types: ${cardDetails['types']?.join(', ') ?? 'Unknown'}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.volume_up, color: Colors.blue),
                                onPressed: () {
                                  speak(
                                    'HP: ${cardDetails['hp'] ?? 'Unknown'}\nTypes: ${cardDetails['types']?.join(', ') ?? 'Unknown'}',
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          // Stage
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Stage: ${cardDetails['stage'] ?? 'Unknown'}',
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: Icon(Icons.volume_up, color: Colors.blue),
                                onPressed: () {
                                  speak('Stage: ${cardDetails['stage'] ?? 'Unknown'}');
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          // Attacks
                          Text(
                            'Attacks:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ...?cardDetails['attacks']?.map((attack) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '- ${attack['name']}: ${attack['effect'] ?? 'No effect'}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.volume_up, color: Colors.blue),
                                  onPressed: () {
                                    speak(
                                      '${attack['name']}: ${attack['effect'] ?? 'No effect'}',
                                    );
                                  },
                                ),
                              ],
                            );
                          }),
                          SizedBox(height: 8),
                          // Weaknesses
                          Text(
                            'Weaknesses:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ...?cardDetails['weaknesses']?.map((weakness) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '- ${weakness['type']}: ${weakness['value'] ?? 'No value'}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.volume_up, color: Colors.blue),
                                  onPressed: () {
                                    speak(
                                      '${weakness['type']}: ${weakness['value'] ?? 'No value'}',
                                    );
                                  },
                                ),
                              ],
                            );
                          }),
                          SizedBox(height: 8),
                          // Retreat Cost
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Retreat Cost: ${cardDetails['retreat'] ?? 'Unknown'}',
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: Icon(Icons.volume_up, color: Colors.blue),
                                onPressed: () {
                                  speak('Retreat Cost: ${cardDetails['retreat'] ?? 'Unknown'}');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    ),
  );
}
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: servicesCard.getCardInfo(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final cardDetails = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Image.network(
                    '${cardDetails['image']}/high.png',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Container(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade200,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  // Name
                  Text(
                    cardDetails['name'] ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Illustrator
                  Text(
                    'Illustrator: ${cardDetails['illustrator'] ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  // Category and Rarity
                  Text(
                    'Category: ${cardDetails['category'] ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Rarity: ${cardDetails['rarity'] ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  // HP and Types
                  Text(
                    'HP: ${cardDetails['hp'] ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Types: ${cardDetails['types']?.join(', ') ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  // Stage
                  Text(
                    'Stage: ${cardDetails['stage'] ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  // Attacks
                  Text(
                    'Attacks:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...?cardDetails['attacks']?.map((attack) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '- ${attack['name']}: ${attack['effect'] ?? 'No effect'}',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }),
                  SizedBox(height: 8),
                  // Weaknesses
                  Text(
                    'Weaknesses:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...?cardDetails['weaknesses']?.map((weakness) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '- ${weakness['type']}: ${weakness['value'] ?? 'No value'}',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }),
                  SizedBox(height: 8),
                  // Retreat Cost
                  Text(
                    'Retreat Cost: ${cardDetails['retreat'] ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  // Legal Information
                  Text(
                    'Legal Information:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Standard: ${cardDetails['legal']?['standard'] == true ? 'Yes' : 'No'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Expanded: ${cardDetails['legal']?['expanded'] == true ? 'Yes' : 'No'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  // Updated Date
                  Text(
                    'Last Updated: ${cardDetails['updated'] ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
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
  }*/
}