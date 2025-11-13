/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:ronkhlab_agro/pages/prevision_de_la_semaine.dart';

Future<void> _voirPrevisions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Étape 1 : obtenir la latitude et longitude de Ronkh
      final geocodeUrl =
          'https://api.openweathermap.org/data/2.5/weather?q=$_location&appid=$_apiKey&lang=fr';
      final geoResponse = await http.get(Uri.parse(geocodeUrl));
      if (geoResponse.statusCode != 200) throw Exception("Erreur de géolocalisation");

      final geoData = json.decode(geoResponse.body);
      final lat = geoData['coord']['lat'];
      final lon = geoData['coord']['lon'];

      // Étape 2 : requête des prévisions sur 7 jours
      final forecastUrl =
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly,alerts&appid=$_apiKey&units=metric&lang=fr';
      final forecastResponse = await http.get(Uri.parse(forecastUrl));

      if (forecastResponse.statusCode == 200) {
        final data = json.decode(forecastResponse.body);
        final previsions = data['daily'] as List<dynamic>;

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PagePrevisions(previsions: previsions),
            ),
          );
        }
      } else {
        throw Exception("Erreur de récupération des prévisions");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }*/
