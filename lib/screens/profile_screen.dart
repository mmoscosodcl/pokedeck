import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Profile'),
            Tab(text: 'Preferences'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(),
          _buildPreferencesTab(),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: John Doe', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('Username: johndoe123', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('Email: johndoe@example.com', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('Profile ID: 12345', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('Points: 250', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return Center(
      child: Text(
        'Preferences',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}