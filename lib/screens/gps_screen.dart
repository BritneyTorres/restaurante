import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';
import 'mapascreen.dart';


class GPSScreen extends StatefulWidget {
  const GPSScreen({Key? key}) : super(key: key);

  @override
  State<GPSScreen> createState() => _GPSScreenState();
}

class _GPSScreenState extends State<GPSScreen> {
  final LocationService locationService = LocationService();

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await locationService.getCurrentLocation();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MapaScreen(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener la ubicación: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: _getCurrentLocation,
          child: const Text('Obtener Ubicación Actual'),
        ),
      ),
    );
  }
}
