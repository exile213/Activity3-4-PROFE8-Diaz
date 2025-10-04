import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('Communications'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF77A1D3), Color(0xFF79CBCA), Color(0xFFE684AE)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        // TabBar embedded INSIDE the AppBar - This is Task 9!
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.chat_bubble_outline), text: 'Chats'),
            Tab(icon: Icon(Icons.circle_outlined), text: 'Status'),
            Tab(icon: Icon(Icons.call_outlined), text: 'Calls'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildChatsTab(), _buildStatusTab(), _buildCallsTab()],
      ),
    );
  }

  Widget _buildChatsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Center(
          child: Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: Color(0xFF77A1D3),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Project Chats',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Card(
          color: Color(0xFF77A1D3),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Chat System - Complete!\nTabBar embedded inside the AppBar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildChatItem(
          'Survey Team Alpha',
          'Mission complete, data uploaded',
          '5 min ago',
        ),
        _buildChatItem(
          'Client: Construction Co.',
          'Request for additional mapping',
          '1 hour ago',
        ),
        _buildChatItem(
          'Drone Fleet Manager',
          'Maintenance scheduled for tomorrow',
          '3 hours ago',
        ),
        _buildChatItem(
          'Weather Service',
          'Clear skies for next 3 days',
          '6 hours ago',
        ),
      ],
    );
  }

  Widget _buildStatusTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Center(
          child: Icon(
            Icons.circle_outlined,
            size: 80,
            color: Color(0xFF79CBCA),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'System Status',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Card(
          color: Color(0xFF79CBCA),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Status Dashboard\nReal-time system monitoring and updates',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildStatusItem(
          'Drone Fleet',
          'All 5 drones operational',
          Icons.flight_takeoff,
          Colors.green,
        ),
        _buildStatusItem(
          'Weather Conditions',
          'Perfect for surveying',
          Icons.wb_sunny,
          Colors.orange,
        ),
        _buildStatusItem(
          'Active Missions',
          '3 surveys in progress',
          Icons.location_on,
          const Color(0xFF77A1D3),
        ),
        _buildStatusItem(
          'Data Storage',
          '85% capacity remaining',
          Icons.storage,
          Colors.blue,
        ),
        _buildStatusItem(
          'Network Connection',
          'Strong signal strength',
          Icons.signal_cellular_4_bar,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildCallsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Center(
          child: Icon(Icons.call_outlined, size: 80, color: Color(0xFFE684AE)),
        ),
        const SizedBox(height: 20),
        const Text(
          'Call History',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Card(
          color: Color(0xFFE684AE),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Communication Center Complete!\nThree tabs: Chats, Status, Calls',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildCallItem(
          'John Smith - Project Manager',
          'Incoming',
          '15 min ago',
          Icons.call_received,
          Colors.green,
        ),
        _buildCallItem(
          'Sarah Wilson - Client',
          'Outgoing',
          '1 hour ago',
          Icons.call_made,
          Colors.blue,
        ),
        _buildCallItem(
          'Mike Johnson - Pilot',
          'Missed',
          '2 hours ago',
          Icons.call_missed,
          Colors.red,
        ),
        _buildCallItem(
          'Weather Service Hotline',
          'Outgoing',
          '4 hours ago',
          Icons.call_made,
          Colors.blue,
        ),
        _buildCallItem(
          'Emergency Support',
          'Incoming',
          '1 day ago',
          Icons.call_received,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildChatItem(String name, String message, String time) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF77A1D3),
          child: Text(
            name.split(' ')[0][0],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: Text(
          time,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Open chat with $name')));
        },
      ),
    );
  }

  Widget _buildStatusItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(
          color == Colors.green ? Icons.check_circle : Icons.info_outline,
          color: color,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildCallItem(
    String name,
    String type,
    String time,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$type • $time'),
        trailing: IconButton(
          icon: const Icon(Icons.call, color: Color(0xFF77A1D3)),
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Calling $name...')));
          },
        ),
      ),
    );
  }
}
