import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nuevo/screens/cart_service.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static List<Map<String, dynamic>> orderHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Carrito'),
        backgroundColor: Color(0xFFFF6B35),
        foregroundColor: Colors.white,
        actions: [
          if (!CartService.isEmpty)
            IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: _showClearCartDialog,
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CartService.isEmpty
                ? _buildEmptyCart()
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: CartService.items.length,
                          itemBuilder: (context, index) {
                            final item = CartService.items[index];
                            return _buildCartItem(item);
                          },
                        ),
                      ),
                      _buildOrderSummary(),
                    ],
                  ),
          ),
          if (orderHistory.isNotEmpty) ...[
            Divider(thickness: 1),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Historial de Pedidos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B35),
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  final order = orderHistory[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.history, color: Color(0xFFFF6B35)),
                      title: Text(
                        'Pedido #${index + 1} - ${order['itemCount']} artículos',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Total: S/. ${order['total'].toStringAsFixed(2)}\nFecha: ${order['date']}'),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: Colors.grey[400],
          ),
          SizedBox(height: 24),
          Text(
            'Tu carrito está vacío',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Agrega algunos platos deliciosos a tu carrito',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/menu');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.restaurant_menu),
                SizedBox(width: 8),
                Text('Ver Menú'),
              ],
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFFFFE0B2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.restaurant, size: 35, color: Color(0xFFFF6B35)),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.dish.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'S/. ${item.dish.price.toStringAsFixed(2)} c/u',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Total: S/. ${item.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6B35),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          CartService.updateQuantity(
                            item.dish.id,
                            item.quantity > 1 ? item.quantity - 1 : 1,
                          );
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '${item.quantity}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          CartService.updateQuantity(
                            item.dish.id,
                            item.quantity + 1,
                          );
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF6B35),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.add, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      CartService.removeFromCart(item.dish.id);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete, size: 14, color: Colors.red),
                        SizedBox(width: 4),
                        Text(
                          'Eliminar',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Artículos (${CartService.itemCount}):',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              Text(
                'S/. ${CartService.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery:',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              Text(
                'S/. 5.00',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
          Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'S/. ${(CartService.totalAmount + 5.00).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B35),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _showOrderConfirmation,
              child: Text(
                'Realizar Pedido',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vaciar Carrito'),
          content: Text(
            '¿Estás seguro de que quieres eliminar todos los artículos del carrito?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  CartService.clearCart();
                });
                Navigator.of(context).pop();
              },
              child: Text('Vaciar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  void _showOrderConfirmation() {
    final now = DateTime.now();
    final formattedDate =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Pedido'),
        content: Text('¿Quieres confirmar tu pedido? Después de confirmar no podrás hacer cambios.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final pedido = {
                'itemCount': CartService.itemCount,
                'total': CartService.totalAmount + 5.00,
                'date': Timestamp.now(),
                'items': CartService.items.map((item) => {
                  'dishId': item.dish.id,
                  'dishName': item.dish.name,
                  'quantity': item.quantity,
                  'unitPrice': item.dish.price,
                  'totalPrice': item.totalPrice,
                }).toList(),
                'userId': FirebaseAuth.instance.currentUser?.uid ?? 'anonimo',
              };

              try {
                await FirebaseFirestore.instance.collection('pedidos').add(pedido);

                setState(() {
                  orderHistory.add({
                    'itemCount': pedido['itemCount'],
                    'total': pedido['total'],
                    'date': formattedDate,
                  });
                  CartService.clearCart();
                });

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Pedido realizado con éxito'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al guardar pedido: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}