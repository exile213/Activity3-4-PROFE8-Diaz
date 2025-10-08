import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_provider.dart';

class EquipmentCartPage extends StatelessWidget {
  const EquipmentCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment Rental Cart'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          // Cart total badge - demonstrates context.watch()
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                  label: Text(
                    '\$${cart.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green.shade600,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Available Equipment Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Equipment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cart.availableEquipment.length,
                        itemBuilder: (context, index) {
                          final equipment = cart.availableEquipment[index];
                          return _buildEquipmentCard(context, equipment);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Cart Items Section
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cart, child) {
                if (cart.cartItems.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Your cart is empty',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        Text(
                          'Add equipment from the options above',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    // Cart header
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cart Items (${cart.totalItems})',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // Demonstrates context.read() - one-time action
                              context.read<CartProvider>().clearCart();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Cart cleared'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            },
                            icon: const Icon(Icons.clear_all),
                            label: const Text('Clear All'),
                          ),
                        ],
                      ),
                    ),

                    // Cart items list
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cart.cartItems[index];
                          return _buildCartItem(context, item);
                        },
                      ),
                    ),

                    // Cart total and checkout
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${cart.totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: cart.cartItems.isNotEmpty
                                  ? () {
                                      _showCheckoutDialog(context);
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              child: const Text(
                                'Add to Booking',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentCard(BuildContext context, EquipmentItem equipment) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Equipment image using Image.asset() - demonstrates task 6
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Image.asset(
                  _getEquipmentImagePath(equipment.name),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to icon if image not found
                    return Icon(
                      _getEquipmentIcon(equipment.name),
                      size: 30,
                      color: Colors.blue.shade700,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    equipment.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '\$${equipment.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    height: 24,
                    child: ElevatedButton(
                      onPressed: () {
                        // Demonstrates context.read() - one-time action
                        context.read<CartProvider>().addToCart(equipment.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${equipment.name} added to cart'),
                            duration: const Duration(seconds: 1),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text('Add', style: TextStyle(fontSize: 10)),
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

  Widget _buildCartItem(BuildContext context, EquipmentItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Equipment image using Image.asset() - demonstrates task 6
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  _getEquipmentImagePath(item.name),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to icon if image not found
                    return Icon(
                      _getEquipmentIcon(item.name),
                      color: Colors.blue.shade700,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Equipment details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    item.description,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.price.toStringAsFixed(2)} each',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Quantity controls
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Demonstrates context.read() - one-time action
                        context.read<CartProvider>().removeFromCart(item.id);
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                      color: Colors.red.shade600,
                    ),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Demonstrates context.read() - one-time action
                        context.read<CartProvider>().addToCart(item.id);
                      },
                      icon: const Icon(Icons.add_circle_outline),
                      color: Colors.green.shade600,
                    ),
                  ],
                ),
                Text(
                  '\$${item.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getEquipmentIcon(String equipmentName) {
    switch (equipmentName.toLowerCase()) {
      case 'extra battery pack':
        return Icons.battery_charging_full;
      case '4k camera gimbal':
        return Icons.camera_alt;
      case 'thermal imaging camera':
        return Icons.thermostat;
      case 'landing pad':
        return Icons.radio_button_checked;
      case 'weather station':
        return Icons.cloud;
      default:
        return Icons.build;
    }
  }

  // Get equipment image path for Image.asset() - demonstrates task 6
  String _getEquipmentImagePath(String equipmentName) {
    // Using the same drone1.jpg for all equipment items for simplicity
    return 'assets/images/drone1.jpg';
  }

  void _showCheckoutDialog(BuildContext context) {
    final cart = context.read<CartProvider>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Equipment to Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Equipment will be added to your current booking:'),
              const SizedBox(height: 12),
              ...cart.cartItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '• ${item.name} x${item.quantity} - \$${item.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const Divider(),
              Text(
                'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add equipment to booking and clear cart
                context.read<CartProvider>().clearCart();
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to previous screen

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Equipment added to your booking!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
