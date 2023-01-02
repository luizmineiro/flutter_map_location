// ignore_for_file: avoid_print, depend_on_referenced_packages, library_private_types_in_public_api, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttericon/typicons_icons.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({Key? key}) : super(key: key);

  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  List<LatLng> tappedPoints = [];

  void _handleTap(position, LatLng latlng) {
    setState(() {
      print(latlng);
      tappedPoints.add(latlng);
    });
  }

  @override
  Widget build(BuildContext context) {
    var markers = tappedPoints.map((latlng) {
      return Marker(
        // dimensao dos marcadores
        width: 35,
        height: 35,
        // coordenadas do marcadores.
        point: latlng,
        builder: (context) => GestureDetector(
          onTap: () {
            // Mostrar uma SnackBar quando clicar em um marcador
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Latitude = ${latlng.latitude.toStringAsFixed(5)} ; Longitude = ${latlng.longitude.toStringAsFixed(5)}",
                ),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(34, 190, 135, 1), 
              shape: BoxShape.circle
            ),
            child: const Icon(
              // Icone do marcador
              Typicons.location,
              color: Colors.white,
              size: 19,
            ),
          ),
        ),
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 190, 135, 1),
        centerTitle: true,
        title: const Text(
          "Flutter - Mapa",
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          //coordenada central do map
          center: LatLng(-2.90393, -41.7763),
          zoom: 17,
          onTap: _handleTap,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: markers,
          )
        ],
      ),
    );
  }
}
