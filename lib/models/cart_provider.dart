import 'package:flutter/material.dart';

/// Equipment item for drone rental cart
class EquipmentItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  int quantity;

  EquipmentItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 0,
  });

  double get totalPrice => price * quantity;

  EquipmentItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? quantity,
  }) {
    return EquipmentItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}

/// Cart provider for drone equipment rental
class CartProvider extends ChangeNotifier {
  final List<EquipmentItem> _items = [];

  // Available equipment for rent
  final List<EquipmentItem> _availableEquipment = [
    EquipmentItem(
      id: '1',
      name: 'Extra Battery Pack',
      description: 'High-capacity LiPo battery for extended flight time',
      price: 25.00,
      imageUrl: 'assets/images/battery.jpg',
    ),
    EquipmentItem(
      id: '2',
      name: '4K Camera Gimbal',
      description: 'Professional 4K camera with 3-axis stabilization',
      price: 150.00,
      imageUrl: 'assets/images/camera.jpg',
    ),
    EquipmentItem(
      id: '3',
      name: 'Thermal Imaging Camera',
      description: 'FLIR thermal camera for specialized surveys',
      price: 300.00,
      imageUrl: 'assets/images/thermal_camera.jpg',
    ),
    EquipmentItem(
      id: '4',
      name: 'Landing Pad',
      description: 'Portable landing pad for safe takeoff and landing',
      price: 20.00,
      imageUrl: 'assets/images/landing_pad.jpg',
    ),
    EquipmentItem(
      id: '5',
      name: 'Weather Station',
      description: 'Portable weather monitoring device',
      price: 75.00,
      imageUrl: 'assets/images/weather_station.jpg',
    ),
  ];

  List<EquipmentItem> get cartItems => List.unmodifiable(_items);
  List<EquipmentItem> get availableEquipment =>
      List.unmodifiable(_availableEquipment);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Add item to cart - demonstrates context.read() usage
  void addToCart(String equipmentId) {
    final existingIndex = _items.indexWhere((item) => item.id == equipmentId);

    if (existingIndex >= 0) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      final equipment = _availableEquipment.firstWhere(
        (item) => item.id == equipmentId,
      );
      _items.add(equipment.copyWith(quantity: 1));
    }

    notifyListeners();
  }

  /// Remove item from cart - demonstrates context.read() usage
  void removeFromCart(String equipmentId) {
    final existingIndex = _items.indexWhere((item) => item.id == equipmentId);

    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex] = _items[existingIndex].copyWith(
          quantity: _items[existingIndex].quantity - 1,
        );
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  /// Clear entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// Get quantity of specific item in cart
  int getItemQuantity(String equipmentId) {
    final item = _items.firstWhere(
      (item) => item.id == equipmentId,
      orElse: () => EquipmentItem(
        id: '',
        name: '',
        description: '',
        price: 0,
        imageUrl: '',
      ),
    );
    return item.quantity;
  }
}
