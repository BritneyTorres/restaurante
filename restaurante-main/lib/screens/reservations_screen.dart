import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _peopleCount = 2;
  int _selectedTable = 1;
  bool _isDateFormatInitialized = false;

  final List<Map<String, dynamic>> _reservations = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null).then((_) {
      setState(() {
        _isDateFormatInitialized = true;
      });
    });
    _loadUserAndReservations();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadUserAndReservations() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('user_email') ?? '';
    if (savedEmail.isNotEmpty) {
      _emailController.text = savedEmail;
      _fetchReservations(savedEmail);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
      locale: const Locale('es', 'ES'),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitReservation() async {
    if (_formKey.currentState!.validate()) {
      final DateTime fullDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      if (fullDateTime.isBefore(DateTime.now())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La fecha y hora deben ser futuras')),
        );
        return;
      }

      final reservationDetails = {
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'datetime': Timestamp.fromDate(fullDateTime),
        'people': _peopleCount,
        'notes': _notesController.text.trim(),
        'table': _selectedTable,
        'createdAt': FieldValue.serverTimestamp(),
      };

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Registrando reserva...'),
            ],
          ),
        ),
      );

      try {
        await FirebaseFirestore.instance
            .collection('reservations')
            .add(reservationDetails);

        // Guarda el email localmente
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', _emailController.text.trim());

        setState(() {
          _reservations.add(reservationDetails);
        });

        Navigator.of(context).pop(); // Cierra loading

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Reserva Confirmada'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre: ${reservationDetails['name']}'),
                Text('Mesa: ${reservationDetails['table']}'),
                Text(
                    'Fecha: ${DateFormat('dd/MM/yyyy HH:mm').format(fullDateTime)}'),
                Text('Personas: ${reservationDetails['people']}'),
                const SizedBox(height: 16),
                const Text('¡Tu reserva ha sido confirmada!'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _formKey.currentState!.reset();
                  setState(() {
                    _nameController.clear();
                    _phoneController.clear();
                    _notesController.clear();
                    _selectedDate = DateTime.now();
                    _selectedTime = TimeOfDay.now();
                    _peopleCount = 2;
                    _selectedTable = 1;
                  });
                  _fetchReservations(_emailController.text.trim());
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      } catch (e) {
        Navigator.of(context).pop(); // Cierra loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar la reserva: $e')),
        );
      }
    }
  }

  void _deleteReservation(int index) {
    setState(() {
      _reservations.removeAt(index);
    });
  }

  void _fetchReservations(String email) async {
    if (email.isEmpty) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('reservations')
        .where('email', isEqualTo: email)
        .orderBy('datetime', descending: true)
        .get();

    setState(() {
      _reservations.clear();
      _reservations.addAll(snapshot.docs.map((doc) => doc.data()));
    });
  }

  Widget _buildTableItem(int tableNumber) {
    final isSelected = _selectedTable == tableNumber;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTable = tableNumber;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.orange.withOpacity(0.3) : Colors.white,
        ),
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_seat,
              size: 36,
              color: isSelected ? Colors.orange : Colors.grey[600],
            ),
            const SizedBox(height: 6),
            Text(
              'Mesa $tableNumber',
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
                color: isSelected ? Colors.orange[800] : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isDateFormatInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final formattedDate =
        DateFormat('EEEE, d MMMM', 'es').format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Reservaciones'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Detalles de la Reserva',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('Fecha: $formattedDate',
                        style: const TextStyle(fontSize: 16)),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Cambiar'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.access_time),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Hora: ${_selectedTime.format(context)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: const Text('Cambiar'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.people),
                  const SizedBox(width: 12),
                  const Text('Personas:', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (_peopleCount > 1) {
                        setState(() {
                          _peopleCount--;
                        });
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$_peopleCount', style: const TextStyle(fontSize: 16)),
                  IconButton(
                    onPressed: () {
                      if (_peopleCount < 10) {
                        setState(() {
                          _peopleCount++;
                        });
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Selecciona una Mesa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 0.9,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                children: List.generate(10, (index) {
                  final tableNumber = index + 1;
                  return _buildTableItem(tableNumber);
                }),
              ),
              const Divider(height: 40),
              const Text('Tus Datos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre Completo',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Por favor ingresa tu nombre'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono (9 dígitos)',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa tu teléfono';
                  }
                  if (!RegExp(r'^\d{9}$').hasMatch(value.trim())) {
                    return 'Debe tener exactamente 9 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa tu email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value.trim())) {
                    return 'Correo electrónico inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notas adicionales (opcional)',
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitReservation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B35),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Confirmar Reserva',
                      style: TextStyle(fontSize: 18)),
                ),
              ),
              if (_reservations.isNotEmpty) ...[
                const SizedBox(height: 24),
                const Text('Reservas Realizadas',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _reservations.length,
                  itemBuilder: (context, index) {
                    final res = _reservations[index];
                    final date = (res['datetime'] as Timestamp).toDate();
                    return Card(
                      child: ListTile(
                        title: Text('${res['name']} - Mesa ${res['table']}'),
                        subtitle: Text(
                            'Fecha: ${DateFormat('dd/MM/yyyy HH:mm').format(date)} - Personas: ${res['people']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteReservation(index),
                        ),
                      ),
                    );
                  },
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
