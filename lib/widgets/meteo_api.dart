import 'package:flutter/material.dart';

class DonneesMeteo extends StatelessWidget {
  final Map<String, dynamic> donneesMeteo;

  const DonneesMeteo({super.key, required this.donneesMeteo});

  @override
  Widget build(BuildContext context) {
    final double temperature = donneesMeteo['main']['temp'];
    final String description = donneesMeteo['weather'][0]['description'];
    final String ville = donneesMeteo['name'];
    final int humidite = donneesMeteo['main']['humidity'];
    final double vitesseVent = donneesMeteo['wind']['speed'];

    return Card(
      margin: const EdgeInsets.only(top: 20),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Météo à $ville',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '$temperature°C - $description',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text('Humidité : $humidite%'),
            Text('Vent : $vitesseVent m/s'),
          ],
        ),
      ),
    );
  }
}
