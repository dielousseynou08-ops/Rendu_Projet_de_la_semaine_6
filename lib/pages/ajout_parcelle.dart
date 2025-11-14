import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ronkhlab_agro/widgets/widget_button.dart';
import 'package:ronkhlab_agro/widgets/widget_input_text.dart';

class AjoutParcelles extends StatefulWidget {
  const AjoutParcelles({super.key});

  @override
  State<AjoutParcelles> createState() => _AjoutParcellesState();
}

class _AjoutParcellesState extends State<AjoutParcelles> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  LatLng? selectedPosition; // Coordonnées du point sélectionné

  final MapController _mapController = MapController();

  Future<void> _saveParcelle() async {
    if (nameController.text.isEmpty ||
        typeController.text.isEmpty ||
        dateController.text.isEmpty ||
        selectedPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Veuillez remplir tous les champs et sélectionner un point sur la carte.",
          ),
        ),
      );
      return;
    }

    //  Enregistre dans Firestore
    await FirebaseFirestore.instance.collection('Champs').add({
      'Name': nameController.text,
      'Type': typeController.text,
      'Date de Semi': dateController.text,
      'Latitude': selectedPosition!.latitude,
      'Longitude': selectedPosition!.longitude,
      'createdAt': Timestamp.now(),
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Champ ajouté avec succès !")));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'RonkhLab_Agro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10),
              WidgetInputText(
                controller: nameController,
                hintText: 'Entrez le nom du champ !',
              ),
              const SizedBox(height: 10),
              WidgetInputText(
                controller: typeController,
                hintText: 'Entrez le type de culture !',
              ),
              const SizedBox(height: 10),
              WidgetInputText(
                controller: dateController,
                hintText: 'Entrez la date de semi !',
              ),
              const SizedBox(height: 15),

              // Ajout du champ "Sélection de la parcelle"
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sélectionnez la position du champ sur la carte :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Container(
                height: 300,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                      16.0194,
                      -16.5107,
                    ), // Position de Ronkh (par défaut)
                    initialZoom: 13,
                    onTap: (tapPosition, point) {
                      setState(() {
                        selectedPosition = point;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    if (selectedPosition != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: selectedPosition!,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              if (selectedPosition != null)
                Text(
                  "Position sélectionnée :\nLat: ${selectedPosition!.latitude.toStringAsFixed(5)}, "
                  "Lng: ${selectedPosition!.longitude.toStringAsFixed(5)}",
                  textAlign: TextAlign.center,
                ),

              const SizedBox(height: 20),
              WidgetButton(name: 'Ajouter un Champ', onTap: _saveParcelle),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
