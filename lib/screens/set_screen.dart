import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pokedeck/services/services_set.dart';
import 'package:pokedeck/widgets/serie_item.dart';
import 'package:pokedeck/widgets/set_detail.dart';

class SetScreen extends StatefulWidget {
  @override
  _SetScreenState createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {

  
  SetService services = SetService();
  late Future<List<dynamic>> sets;
  List<dynamic> allSets = []; // All cards data
  List<dynamic> filteredSets = []; // Filtered list
  String searchQuery = ""; // Search query


  @override
  void initState() {
    super.initState();


    sets = services.getSets();
    sets.then((data) {
      setState(() {
        log('Sets data fetched: ${data.length} sets found in initState');
        allSets = data; // Store all cards data
        filteredSets = data; // Initialize filtered list
      });
    });
    log('Series data initialized');
  }


  void filterSeries(String query) {
    setState(() {
      searchQuery = query;
      filteredSets = query.isEmpty
          ? allSets
          : allSets.where((set) {
              final name = set['name']?.toLowerCase() ?? '';
              return name.contains(query.toLowerCase());
            }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.blueGrey),
                ),
                style: TextStyle(color: Colors.black87),
                onChanged: filterSeries, // Update the filtered list on text change
              ),
            ],
          ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: sets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
        return ListView.builder(
          itemCount: filteredSets.length,
          itemBuilder: (context, index) {
            final set = filteredSets[index];
            //CardItemSerie is a widget that displays the card information
            return SetItemWidget(
              id: set['id'],
              name: set['name'] ?? 'Unknown Series',
              logo: set['logo'] ?? '',
              cardCount: set['cardCount'],
            );
                // Navigate to the card details page
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

class  SetItemWidget extends StatelessWidget {
  final String id;
  final String name;
  final String logo;
  final Map<String, dynamic> cardCount;

  const SetItemWidget({
    required this.id,
    required this.name,
    required this.logo,
    required this.cardCount,
  });
  

  @override
  Widget build(BuildContext context) {
    log('Building Card for SET: $name with ID: $id');
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          logo + '.png',
          width: 70,
          height: 70,
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
      title: Text(
        name,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // Ensures the trailing content doesn't take up extra space
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                '${cardCount['total'] ?? 0}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(width: 16), // Add spacing between Total and Official
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Official',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                '${cardCount['official'] ?? 0}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(width: 16), // Add spacing between Official and Icon
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.style, color: Colors.blue),
                onPressed: () {
                  log('Navigating to cards for set: $id');
                  // Navigate to the cards page for the set (to be implemented)
                  Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => SetDetailScreen(id: id, name: name, imageUrl: logo),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


