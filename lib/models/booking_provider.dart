import 'package:flutter/material.dart';

/// Booking model for drone survey services
class Booking {
  final String id;
  final String clientName;
  final String serviceType;
  final DateTime date;
  final TimeOfDay time;
  final String location;
  final String notes;
  final double totalCost;
  final List<String> equipmentIds;

  Booking({
    required this.id,
    required this.clientName,
    required this.serviceType,
    required this.date,
    required this.time,
    required this.location,
    required this.notes,
    required this.totalCost,
    required this.equipmentIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientName': clientName,
      'serviceType': serviceType,
      'date': date.toIso8601String(),
      'time': '${time.hour}:${time.minute}',
      'location': location,
      'notes': notes,
      'totalCost': totalCost,
      'equipmentIds': equipmentIds,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    final timeParts = map['time'].split(':');
    return Booking(
      id: map['id'],
      clientName: map['clientName'],
      serviceType: map['serviceType'],
      date: DateTime.parse(map['date']),
      time: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
      location: map['location'],
      notes: map['notes'],
      totalCost: map['totalCost'].toDouble(),
      equipmentIds: List<String>.from(map['equipmentIds']),
    );
  }
}

/// Provider for managing bookings with ChangeNotifier
/// Demonstrates the difference between context.read() and context.watch()
class BookingProvider extends ChangeNotifier {
  final List<Booking> _bookings = [];

  List<Booking> get bookings => List.unmodifiable(_bookings);

  int get totalBookings => _bookings.length;

  double get totalRevenue =>
      _bookings.fold(0.0, (sum, booking) => sum + booking.totalCost);

  /// Add a new booking - use context.read() to call this method
  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners(); // This will trigger context.watch() listeners
  }

  /// Remove a booking - use context.read() to call this method
  void removeBooking(String bookingId) {
    _bookings.removeWhere((booking) => booking.id == bookingId);
    notifyListeners(); // This will trigger context.watch() listeners
  }

  /// Update booking notes - use context.read() to call this method
  void updateBookingNotes(String bookingId, String newNotes) {
    final index = _bookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      final oldBooking = _bookings[index];
      _bookings[index] = Booking(
        id: oldBooking.id,
        clientName: oldBooking.clientName,
        serviceType: oldBooking.serviceType,
        date: oldBooking.date,
        time: oldBooking.time,
        location: oldBooking.location,
        notes: newNotes,
        totalCost: oldBooking.totalCost,
        equipmentIds: oldBooking.equipmentIds,
      );
      notifyListeners(); // This will trigger context.watch() listeners
    }
  }

  /// Get bookings for a specific date - use context.watch() to listen to changes
  List<Booking> getBookingsForDate(DateTime date) {
    return _bookings
        .where(
          (booking) =>
              booking.date.year == date.year &&
              booking.date.month == date.month &&
              booking.date.day == date.day,
        )
        .toList();
  }

  /// Get upcoming bookings - use context.watch() to listen to changes
  List<Booking> get upcomingBookings {
    final now = DateTime.now();
    return _bookings.where((booking) => booking.date.isAfter(now)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  /// Clear all bookings
  void clearAllBookings() {
    _bookings.clear();
    notifyListeners();
  }
}
