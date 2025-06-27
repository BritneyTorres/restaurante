import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapaScreen({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  GoogleMapController? _mapController;  // ahora es nullable
  late LatLng _currentLatLng;
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    _currentLatLng = LatLng(widget.latitude, widget.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _mapReady = true;
    });
  }

  void _centerMap() {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLatLng, 15),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Ubicación')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentLatLng,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('ubicacion_actual'),
                position: _currentLatLng,
                infoWindow: const InfoWindow(title: 'Estás aquí'),
              ),
            },
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),
          if (!_mapReady)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mapReady ? _centerMap : null,
        backgroundColor: _mapReady
            ? Theme.of(context).colorScheme.primary
            : Colors.grey,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
