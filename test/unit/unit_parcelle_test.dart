import 'package:flutter_test/flutter_test.dart';
import 'package:ronkhlab_agro/models/parccelle_model.dart';

void main() {
  test("Parcelle Model - Conversion Firestore → Objet", () {
    final docId = "123";
    final data = {
      "Name": "Maïs",
      "Type": "Céréale",
      "Date de Semi": "2025-03-01",
      "Latitude": 14.6543,
      "Longitude": -16.7788,
    };

    final parcelle = Parcelle.fromFirestore(docId, data);

    expect(parcelle.id, "123");
    expect(parcelle.name, "Maïs");
    expect(parcelle.type, "Céréale");
    expect(parcelle.latitude, 14.6543);
  });

  test("Parcelle Model - Conversion Objet → Map", () {
    final parcelle = Parcelle(
      id: "1",
      name: "Riz",
      type: "Culture humide",
      dateSemi: "2025-02-10",
      latitude: 15.0,
      longitude: -16.0,
    );

    final map = parcelle.toMap();

    expect(map['Name'], "Riz");
    expect(map['Type'], "Culture humide");
  });
}
