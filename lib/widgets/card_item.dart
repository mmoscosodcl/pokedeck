import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pokedeck/widgets/card_detail.dart';

class CardItemWidget extends StatefulWidget {
  final String id;
  final String localId;
  final String name;
  final String imageUrl;
  final String detailUrl;

  const CardItemWidget({
    required this.id,
    required this.localId,
    required this.name,
    required this.imageUrl,
    required this.detailUrl,
    Key? key,
  }) : super(key: key);

  @override
  _CardItemWidgetState createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {
  late FlutterTts flutterTts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(
          id: widget.id,
          localId: widget.localId,
          name: widget.name,
          imageUrl: widget.imageUrl,
          detailUrl: widget.detailUrl,
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
                        '${widget.imageUrl}/low.png',
                        fit: BoxFit.cover,
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
                  // Image thumbnail with white border
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      '${widget.imageUrl}/low.png',
                      width: 50,
                      height: 70,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade200,
                        child: Center(
                        child: CircularProgressIndicator(),
                        ),
                      );
                      },
                      errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade200,
                        child: Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 30,
                        ),
                        ),
                      );
                      },
                    ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Text content
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
