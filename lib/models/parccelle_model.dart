class Parcelle {
  final String id;
  final String name;
  final String type;
  final String dateSemi;
  final double latitude;
  final double longitude;

  Parcelle({
    required this.id,
    required this.name,
    required this.type,
    required this.dateSemi,
    required this.latitude,
    required this.longitude,
  });

  factory Parcelle.fromFirestore(String id, Map<String, dynamic> data) {
    return Parcelle(
      id: id,
      name: data['Name'] ?? '',
      type: data['Type'] ?? '',
      dateSemi: data['Date de Semi'] ?? '',
      latitude: (data['Latitude'] ?? 0).toDouble(),
      longitude: (data['Longitude'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Name": name,
      "Type": type,
      "Date de Semi": dateSemi,
      "Latitude": latitude,
      "Longitude": longitude,
    };
  }
}
