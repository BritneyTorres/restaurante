class Dish {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final String link;  // Agregado aquí

  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.link,  // Aquí también
  });

  // Método para crear una copia del plato con algunas propiedades modificadas
  Dish copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    String? imageUrl,
    String? link,  // Agregado para que se pueda modificar el link
  }) {
    return Dish(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      link: link ?? this.link,
    );
  }

  // Convertir el plato a un mapa (útil para Firebase o bases de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'link': link,  // También en el mapa
    };
  }

  // Crear un plato desde un mapa (útil para Firebase o bases de datos)
  factory Dish.fromMap(Map<String, dynamic> map) {
    return Dish(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price']?.toDouble() ?? 0.0),
      category: map['category'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      link: map['link'] ?? '',  // Aquí también
    );
  }

  @override
  String toString() {
    return 'Dish(id: $id, name: $name, price: $price, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Dish && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
