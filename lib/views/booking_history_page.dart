import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_time_picker.dart';
import '../widgets/custom_button.dart';
import '../models/booking_provider.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _serviceTypeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _serviceTypeController.dispose();
    _locationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _addBooking() {
    if (_serviceTypeController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields and select date/time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create new booking using Provider - demonstrates context.read()
    final newBooking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      clientName: 'Current User', // In real app, get from user session
      serviceType: _serviceTypeController.text,
      date: _selectedDate!,
      time: _selectedTime!,
      location: _locationController.text,
      notes: 'Survey booking created from booking history page',
      totalCost: 250.0, // Default cost, can be calculated based on service
      equipmentIds: [], // Can be enhanced to include equipment from cart
    );

    // Use context.read() for one-time action - adding booking
    context.read<BookingProvider>().addBooking(newBooking);

    _serviceTypeController.clear();
    _locationController.clear();
    setState(() {
      _selectedDate = null;
      _selectedTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Survey booking added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drone Survey Bookings'),
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.add), text: 'New Booking'),
            Tab(icon: Icon(Icons.history), text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildNewBookingTab(), _buildHistoryTab()],
      ),
    );
  }

  Widget _buildNewBookingTab() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add New Survey Booking',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CustomFormField(
            label: 'Survey Type',
            hint:
                'e.g., Aerial Survey, Land Mapping, Infrastructure Inspection',
            controller: _serviceTypeController,
          ),
          const SizedBox(height: 16),
          CustomFormField(
            label: 'Location',
            hint: 'e.g., Manila, Cebu, Project Site Address',
            controller: _locationController,
          ),
          const SizedBox(height: 16),
          CustomDatePicker(
            label: 'Select Date',
            selectedDate: _selectedDate,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
          const SizedBox(height: 16),
          CustomTimePicker(
            label: 'Select Time',
            selectedTime: _selectedTime,
            onTimeSelected: (time) {
              setState(() {
                _selectedTime = time;
              });
            },
          ),
          const SizedBox(height: 20),
          CustomButton(text: 'Add Survey Booking', onPressed: _addBooking),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Survey Bookings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              // Statistics using Consumer to watch changes
              Consumer<BookingProvider>(
                builder: (context, bookingProvider, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${bookingProvider.totalBookings} bookings',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Revenue display using Consumer - demonstrates context.watch()
          Consumer<BookingProvider>(
            builder: (context, bookingProvider, child) {
              return Text(
                'Total Revenue: \$${bookingProvider.totalRevenue.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          Expanded(
            // Use Consumer to watch booking changes - demonstrates context.watch()
            child: Consumer<BookingProvider>(
              builder: (context, bookingProvider, child) {
                final bookings = bookingProvider.bookings;

                if (bookings.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No survey bookings yet',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add a booking from the New Booking tab',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[700],
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(booking.serviceType),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('👤 ${booking.clientName}'),
                            Text('📍 ${booking.location}'),
                            Text(
                              '📅 ${booking.date.day}/${booking.date.month}/${booking.date.year} at ${booking.time.format(context)}',
                            ),
                            Text(
                              '💰 \$${booking.totalCost.toStringAsFixed(2)}',
                            ),
                            if (booking.notes.isNotEmpty)
                              Text(
                                '📝 ${booking.notes}',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == 'delete') {
                              // Use context.read() for one-time action - deleting booking
                              context.read<BookingProvider>().removeBooking(
                                booking.id,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Booking deleted'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            } else if (value == 'edit_notes') {
                              _showEditNotesDialog(context, booking);
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem<String>(
                              value: 'edit_notes',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  SizedBox(width: 8),
                                  Text('Edit Notes'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditNotesDialog(BuildContext context, Booking booking) {
    final notesController = TextEditingController(text: booking.notes);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Booking Notes'),
          content: TextField(
            controller: notesController,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Use context.read() for one-time action - updating notes
                context.read<BookingProvider>().updateBookingNotes(
                  booking.id,
                  notesController.text,
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notes updated successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
