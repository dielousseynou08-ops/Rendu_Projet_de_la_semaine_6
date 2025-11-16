import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Fonction pour supprimer une parcelle

Future<void> deleteChamp(String docID) async {
  await FirebaseFirestore.instance.collection('Champs').doc(docID).delete();
}

// Fonction pour mettre à jour une parcelle
Future<void> updateChamp(String docID, Map<String, dynamic> newData) async {
  await FirebaseFirestore.instance
      .collection('Champs')
      .doc(docID)
      .update(newData);
}

// Boîte de dialogue pour modifier les infos
void showEditDialog(BuildContext context, DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;

  final nameController = TextEditingController(text: data['Name']);
  final typeController = TextEditingController(text: data['Type']);
  final dateSemiController = TextEditingController(text: data['Date de Semi']);
  final latitudeController = TextEditingController(
    text: data['Latitude']?.toString(),
  );
  final longitudeController = TextEditingController(
    text: data['Longitude']?.toString(),
  );

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Modifier la parcelle"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Nom"),
              controller: nameController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Type"),
              controller: typeController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Date de semi"),
              controller: dateSemiController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Latitude"),
              controller: latitudeController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Longitude"),
              controller: longitudeController,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        ElevatedButton(
          onPressed: () {
            updateChamp(doc.id, {
              "Name": nameController.text,
              "Type": typeController.text,
              "Date de Semi": dateSemiController.text,
              "Latitude": double.tryParse(latitudeController.text),
              "Longitude": double.tryParse(longitudeController.text),
            });
            Navigator.pop(context);
          },
          child: const Text("Enregistrer"),
        ),
      ],
    ),
  );
}

// Boîte de dialogue pour confirmer la suppression
void confirmDelete(BuildContext context, String docID) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Supprimer"),
      content: const Text("Voulez-vous vraiment supprimer cette parcelle ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            deleteChamp(docID);
            Navigator.pop(context);
          },
          child: const Text("Supprimer"),
        ),
      ],
    ),
  );
}
