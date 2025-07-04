import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedeck/widgets/serie_detail.dart';

class SerieItemWidget extends StatefulWidget {
  final String id;
  final String name;
  final String logo;

  const SerieItemWidget({
    required this.id,
    required this.name,
    required this.logo,
    Key? key,
  }) : super(key: key);

  @override
  _SerieItemWidgetState createState() => _SerieItemWidgetState();
}

class _SerieItemWidgetState extends State<SerieItemWidget> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        log('Tapped on Serie: ${widget.name}');
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => SerieDetailScreen(
              id: widget.id,
              name: widget.name,
              imageUrl: widget.logo // Assuming logo is the image URL
            ),
          ),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Stack(
          children: [
            ClipRRect(
                        borderRadius: BorderRadius.circular(15.0), // Match the Card's border radius
                        child: Image.network(
                        '${widget.logo}.png',
                        //fit: BoxFit.cover,
                        width: double.infinity, // Ensure bounded width
                        height: 150, // Set a fixed height for the image
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                          return child;
                          }
                          return Container(
                          color: Colors.grey.shade200,
                          child: Center(child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
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
                      ),
            Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  //Liked button 
                  StatefulBuilder(
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
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3, red: 2.2, green: 0.1, blue: 1.0), // Semi-transparent background
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Title font color set to white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
