import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PagePrevisions extends StatelessWidget {
  final List<dynamic> previsions;

  const PagePrevisions({super.key, required this.previsions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Prévisions de la semaine",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: previsions.isEmpty
          ? const Center(child: Text("Aucune prévision disponible."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: previsions.length,
              itemBuilder: (context, index) {
                final jour = previsions[index];
                final date = DateTime.fromMillisecondsSinceEpoch(
                  jour['dt'] * 1000,
                );
                final temp = jour['temp']['day'].round();
                final desc = jour['weather'][0]['description'];
                final icon = jour['weather'][0]['icon'];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.network(
                      "https://openweathermap.org/img/wn/$icon@2x.png",
                      width: 50,
                      height: 50,
                    ),
                    title: Text(
                      DateFormat('EEEE d MMMM', 'fr_FR').format(date),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(desc),
                    trailing: Text(
                      "$temp°C",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
