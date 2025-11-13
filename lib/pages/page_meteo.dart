import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ronkhlab_agro/pages/prevision_de_la_semaine.dart';
import 'dart:convert';
import 'package:ronkhlab_agro/widgets/meteo_api.dart';
import 'package:ronkhlab_agro/widgets/widget_button.dart';

class PageMeteo extends StatefulWidget {
  const PageMeteo({super.key});

  @override
  State<PageMeteo> createState() => _PageMeteoState();
}

class _PageMeteoState extends State<PageMeteo> {
  bool _isLoading = false;
  Map<String, dynamic>? _donneesMeteo;

  final String _apiKey = "925603a3bc1c30df6506663f7566c526";
  final String _location = 'Ronkh';

  // la Fonction pour récupérer les données météo
  Future<void> _recupererDonnees() async {
    final ville = _location;
    if (ville.isEmpty) return;

    setState(() {
      _isLoading = true;
      _donneesMeteo = null;
    });

    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$ville&appid=$_apiKey&units=metric&lang=fr';

    try {
      final reponse = await http.get(Uri.parse(url));

      if (reponse.statusCode == 200) {
        setState(() {
          _donneesMeteo = json.decode(reponse.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ville non trouvée ou erreur de requête.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //pour afficher la prevision de la semaine
  Future<void> _voirPrevisions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Étape 1 : obtenir la latitude et longitude de Ronkh
      final geocodeUrl =
          'https://api.openweathermap.org/data/2.5/weather?q=$_location&appid=$_apiKey&lang=fr';
      final geoResponse = await http.get(Uri.parse(geocodeUrl));
      if (geoResponse.statusCode != 200) {
        throw Exception("Erreur de géolocalisation");
      }

      final geoData = json.decode(geoResponse.body);
      final lat = geoData['coord']['lat'];
      final lon = geoData['coord']['lon'];

      // Étape 2 : requête des prévisions sur 7 jours
      final forecastUrl =
          'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly,alerts&appid=$_apiKey&units=metric&lang=fr';
      final forecastResponse = await http.get(Uri.parse(forecastUrl));

      print("Status: ${forecastResponse.statusCode}");
      print("Body: ${forecastResponse.body}");

      if (forecastResponse.statusCode == 200) {
        final data = json.decode(forecastResponse.body);
        final previsions = data['daily'] as List<dynamic>;

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PagePrevisions(previsions: previsions),
            ),
          );
        }
      } else {
        throw Exception("Erreur de récupération des prévisions");
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur : $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _recupererDonnees(); //pour Charge la météo automatiquement au démarrage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
      body: RefreshIndicator(
        onRefresh:
            _recupererDonnees, // pour permetre  de rafraîchir en glissant vers le bas
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Bandeau décoratif je pense que je vais le supprimer
                Container(
                  height: 100,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      "Le temps actuel",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Contenu météo
                if (_isLoading)
                  const CircularProgressIndicator()
                else if (_donneesMeteo != null)
                  DonneesMeteo(donneesMeteo: _donneesMeteo!)
                else
                  const Text(
                    'Aucune donnée pour le moment.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                const SizedBox(height: 30),

                // Boutons d'action
                WidgetButton(
                  name: 'les prévisions de la semaine',
                  onTap: _voirPrevisions,
                ),
                const SizedBox(height: 10),
                WidgetButton(
                  name: 'Alerte automatique',
                  onTap: () {
                    // à implementer pour visualiser les alerte
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
