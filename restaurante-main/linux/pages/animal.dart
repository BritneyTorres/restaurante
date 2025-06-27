class Animal {
  final String id;
  final String name;
  final String species;

  Animal({
    required this.id,
    required this.name,
    required this.species,
  });

  // Convertir de un Map a un Animal
  factory Animal.fromMap(Map<String, dynamic> data, String documentId) {
    return Animal(
      id: documentId,
      name: data['name'],
      species: data['species'],
    );
  }

  // Convertir de Animal a un Map para agregar a Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'species': species,
    };
  }
}
