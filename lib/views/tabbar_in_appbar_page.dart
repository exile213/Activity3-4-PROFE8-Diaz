import 'package:flutter/material.dart';

class TabBarInAppBarPage extends StatefulWidget {
  const TabBarInAppBarPage({super.key});

  @override
  State<TabBarInAppBarPage> createState() => _TabBarInAppBarPageState();
}

class _TabBarInAppBarPageState extends State<TabBarInAppBarPage>
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
        title: const Text('Messages'),
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
        // TabBar is embedded INSIDE the AppBar using the 'bottom' property
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
          'Chats Tab',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Card(
          color: Color(0xFF77A1D3),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'TabBar in AppBar Demo - Chats',
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
          'Customer Support',
          'Need help with survey booking',
          '2 min ago',
        ),
        _buildChatItem(
          'Survey Team',
          'Survey completed successfully',
          '1 hour ago',
        ),
        _buildChatItem(
          'Project Manager',
          'New area mapping request',
          '3 hours ago',
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
          'Status Tab',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Card(
          color: Color(0xFF79CBCA),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'TabBar in AppBar Demo - Status',
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
          'Drone Fleet Status',
          'All 5 drones operational',
          Icons.check_circle,
          Colors.green,
        ),
        _buildStatusItem(
          'Weather Conditions',
          'Perfect for surveying',
          Icons.wb_sunny,
          Colors.orange,
        ),
        _buildStatusItem(
          'Active Surveys',
          '3 surveys in progress',
          Icons.flight_takeoff,
          const Color(0xFF77A1D3),
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
          'Calls Tab',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Card(
          color: Color(0xFFE684AE),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'TabBar in AppBar Demo - Calls',
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
          'John Smith',
          'Incoming',
          '5 min ago',
          Icons.call_received,
          Colors.green,
        ),
        _buildCallItem(
          'Sarah Wilson',
          'Outgoing',
          '1 hour ago',
          Icons.call_made,
          Colors.blue,
        ),
        _buildCallItem(
          'Mike Johnson',
          'Missed',
          '2 hours ago',
          Icons.call_missed,
          Colors.red,
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
            name[0],
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
          Icons.arrow_forward_ios,
          color: Colors.grey[400],
          size: 16,
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
