import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  double? _latitude;
  double? _longitude;

  void _saveLocation() {
    if (_latitude == null || _longitude == null) return;
    Navigator.of(context).pop(
      PlaceLocation(latitude: _latitude!, longitude: _longitude!, address: ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveLocation,
            ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Enter Latitude and Longitude',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _latitude = double.tryParse(value);
                },
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _longitude = double.tryParse(value);
                },
              ),
              const SizedBox(height: 20),
              if (!widget.isSelecting)
                Text(
                  'Selected Location: (${widget.location.latitude}, ${widget.location.longitude})',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              if (_latitude != null && _longitude != null)
                Text(
                  'Preview Location: ($_latitude, $_longitude)',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
            ],
          )),
    );
  }
}
