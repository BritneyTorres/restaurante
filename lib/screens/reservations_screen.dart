import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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

  final List<Map<String, dynamic>> _reservations = [];

  bool _isDateFormatInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null).then((_) {
      setState(() {
        _isDateFormatInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime firstDate = DateTime(1900);
    final DateTime lastDate = DateTime(DateTime.now().year + 10);

    DateTime initialDate = _selectedDate;

    if (initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    }

    if (initialDate.isAfter(lastDate)) {
      initialDate = lastDate;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('es', 'ES'),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitReservation() {
    if (_formKey.currentState!.validate()) {
      final reservationDetails = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'date': DateFormat('yyyy-MM-dd').format(_selectedDate),
        'time': _selectedTime.format(context),
        'people': _peopleCount,
        'notes': _notesController.text,
        'table': _selectedTable,
      };

      setState(() {
        _reservations.add(reservationDetails);
      });

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
              Text('Fecha: ${reservationDetails['date']}'),
              Text('Hora: ${reservationDetails['time']}'),
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
                  _emailController.clear();
                  _notesController.clear();
                  _selectedDate = DateTime.now();
                  _selectedTime = TimeOfDay.now();
                  _peopleCount = 2;
                  _selectedTable = 1;
                });
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

  void _deleteReservation(int index) {
    setState(() {
      _reservations.removeAt(index);
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
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
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

    final formattedDate = DateFormat('EEEE, d MMMM', 'es').format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservaciones'),
        backgroundColor: const Color(0xFFFF6B35),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detalles de la Reserva',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Fecha: $formattedDate',
                          style: const TextStyle(fontSize: 16),
                        ),
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
                  const Text(
                    'Selecciona una Mesa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
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
                  const Text(
                    'Tus Datos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre Completo',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Teléfono',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu teléfono';
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
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu email';
                      }
                      if (!value.contains('@')) {
                        return 'Ingresa un email válido';
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
                      child: const Text(
                        'Confirmar Reserva',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_reservations.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Reservas Realizadas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _reservations.length,
                itemBuilder: (context, index) {
                  final reservation = _reservations[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(
                          '${reservation['name']} - Mesa ${reservation['table']}'),
                      subtitle: Text(
                          'Fecha: ${reservation['date']} - Hora: ${reservation['time']} - Personas: ${reservation['people']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteReservation(index),
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
