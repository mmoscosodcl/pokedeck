import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pokedeck/services/services_serie.dart';
import 'package:pokedeck/widgets/serie_item.dart';

class SerieScreen extends StatefulWidget {
  @override
  _SerieScreenState createState() => _SerieScreenState();
}

class _SerieScreenState extends State<SerieScreen> {

  
  SerieService services = SerieService();
  late Future<List<dynamic>> series;
  List<dynamic> allSeries = []; // All cards data
  List<dynamic> filteredSeries = []; // Filtered list
  String searchQuery = ""; // Search query


  @override
  void initState() {
    super.initState();


    series = services.getSeries();
    series.then((data) {
      setState(() {
        log('Series data fetched: ${data.length} series found in initState');
        allSeries = data; // Store all cards data
        filteredSeries = data; // Initialize filtered list
      });
    });
    log('Series data initialized');
  }


  void filterSeries(String query) {
    setState(() {
      searchQuery = query;
      filteredSeries = query.isEmpty
          ? allSeries
          : allSeries.where((serie) {
              final name = serie['name']?.toLowerCase() ?? '';
              return name.contains(query.toLowerCase());
            }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Pokedeck Series',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4), // Add some space between title and search field
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
        future: series,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
        final serieData = snapshot.data!;
        return ListView.builder(
          itemCount: filteredSeries.length,
          itemBuilder: (context, index) {
            final serie = filteredSeries[index];
            //CardItemSerie is a widget that displays the card information
            return SerieItemWidget(
              id: serie['id'],
              name: serie['name'] ?? 'Unknown Series',
              logo: serie['logo'] ?? '',
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

class  CardItemSerie extends StatelessWidget {
  final dynamic serie;

  CardItemSerie({required this.serie});

  @override
  Widget build(BuildContext context) {
    log('Building CardItemSerie for: ${serie['name']}');
    return ListTile(
      title: Text(serie['name'] ?? 'Unknown Series'),
      leading: serie['logo'] != null
          ? Image.network(serie['logo']+'.png', width: 50, height: 50)
          : Icon(Icons.image_not_supported),
      onTap: () {
        log('Tapped on Serie: ${serie['name']}');
      },
    );
  }
}


