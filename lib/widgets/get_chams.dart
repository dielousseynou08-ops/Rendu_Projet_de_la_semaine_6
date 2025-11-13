import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ChampInformation extends StatefulWidget {
  const ChampInformation({super.key});

  @override
  _ChampInformationState createState() => _ChampInformationState();
}

class _ChampInformationState extends State<ChampInformation> {
  final Stream<QuerySnapshot> _champsStream = FirebaseFirestore.instance
      .collection('Champs')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _champsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Erreur de chargement des données.'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Aucun champ trouvé.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot document = snapshot.data!.docs[index];
            final data = document.data() as Map<String, dynamic>;

            // 🔹 Récupération sécurisée des coordonnées
            final double? latitude = data['Latitude']?.toDouble();
            final double? longitude = data['Longitude']?.toDouble();

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ListTile(
                // 🌍 Mini carte dans le leading
                leading: (latitude != null && longitude != null)
                    ? SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(latitude, longitude),
                              initialZoom: 13,
                              interactionOptions: const InteractionOptions(
                                flags: InteractiveFlag.none, // pas de mouvement
                              ),
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.app',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: LatLng(latitude, longitude),
                                    width: 40,
                                    height: 40,
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.map_outlined,
                        color: Colors.grey,
                        size: 40,
                      ),

                title: Text(data['Name'] ?? 'Nom non défini'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Type : ${data['Type'] ?? 'Inconnu'}'),
                    Text(
                      'Date de semi : ${data['Date de Semi'] ?? 'Non précisée'}',
                    ),
                    if (latitude != null && longitude != null)
                      Text(
                        'Lat: ${latitude.toStringAsFixed(5)}, '
                        'Lng: ${longitude.toStringAsFixed(5)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
