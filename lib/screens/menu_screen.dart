import 'package:flutter/material.dart';
import 'package:flutter_nuevo/dish.dart';
import 'package:flutter_nuevo/screens/cart_service.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Todos';

  final List<String> _categories = [
    'Todos',
    'Pollos',
    'Acompañamientos',
    'Bebidas',
    'Postres',
  ];

  final List<Dish> _dishes = [
  Dish(
    id: '1',
    name: 'Gaseosa personal',
    description: 'Botella pequeña de gaseosa',
    price: 3.00,
    category: 'Bebidas',
    imageUrl: 'https://berypez.pe/wp-content/uploads/2024/06/personal-gas.jpg', link: '',
  ),
  Dish(
    id: '2',
    name: 'Gaseosa de 1 litro',
    description: 'Botella de gaseosa de 1 litro',
    price: 6.00,
    category: 'Bebidas',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/6f/Coca-Cola_1L_Bottle.jpg', link: '',
  ),
  Dish(
    id: '3',
    name: 'Gaseosa de 1.5 litros',
    description: 'Botella de gaseosa de 1.5 litros',
    price: 8.00,
    category: 'Bebidas',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Coca-Cola_1.5L_Bottle.jpg', link: '',
  ),
  Dish(
    id: '4',
    name: 'Gaseosa de 2.25 litros',
    description: 'Botella de gaseosa de 2.25 litros',
    price: 10.00,
    category: 'Bebidas',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/69/Coca-Cola_2.25L_Bottle.jpg', link: '',
  ),
  Dish(
    id: '5',
    name: 'Inka Kola',
    description: 'Botella de Inka Kola',
    price: 5.00,
    category: 'Bebidas',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/9/9a/Inca_Kola_Bottle.jpg', link: '',
  ),
  Dish(
    id: '6',
    name: 'Agua mineral',
    description: 'Botella de agua mineral',
    price: 3.50,
    category: 'Bebidas',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/09/Bottle_of_water_500ml.jpg', link: '',
  ),
  Dish(
    id: '7',
    name: 'Agua con gas',
    description: 'Botella de agua con gas',
    price: 4.00,
    category: 'Bebidas',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/2c/Sparkling_water_bottle.jpg', link: '',
  ),
  Dish(
    id: '8',
    name: 'Chicha morada',
    description: 'Bebida tradicional peruana de maíz morado',
    price: 5.00,
    category: 'Bebidas',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/66/Chicha_morada_in_Peru.jpg', link: '',
  ),
  Dish(
    id: '9',
    name: 'Jugo de maracuyá',
    description: 'Jugo natural de maracuyá',
    price: 6.00,
    category: 'Bebidas',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/0a/Passionfruit_Juice.jpg', link: '',
  ),
  Dish(
    id: '10',
    name: 'Cerveza',
    description: 'Botella de cerveza',
    price: 8.00,
    category: 'Bebidas',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Beer_bottle.jpg', link: '',
  ),

  // Acompañamientos (15)
  Dish(
    id: '11',
    name: 'Papas fritas',
    description: 'Papas fritas crujientes',
    price: 7.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Golden_French_Fries.jpg', link: '',
  ),
  Dish(
    id: '12',
    name: 'Ensalada clásica',
    description: 'Ensalada fresca clásica',
    price: 6.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/4/45/Greek_salad_%281%29.jpg', link: '',
  ),
  Dish(
    id: '13',
    name: 'Ensalada rusa',
    description: 'Ensalada rusa con mayonesa',
    price: 6.50,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/d/d4/Olivier_salad.jpg', link: '',
  ),
  Dish(
    id: '14',
    name: 'Arroz blanco',
    description: 'Porción de arroz blanco',
    price: 5.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/60/White_rice_dish.jpg', link: '',
  ),
  Dish(
    id: '15',
    name: 'Arroz chaufa de pollo',
    description: 'Arroz chaufa con pollo',
    price: 9.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Chaufa_de_pollo.jpg', link: '',
  ),
  Dish(
    id: '16',
    name: 'Yuca frita',
    description: 'Porción de yuca frita',
    price: 7.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Yuca_frita.jpg', link: '',
  ),
  Dish(
    id: '17',
    name: 'Plátano frito',
    description: 'Plátano maduro frito',
    price: 6.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/7a/Fried_plantains.jpg', link: '',
  ),
  Dish(
    id: '18',
    name: 'Camote frito',
    description: 'Camote frito dulce',
    price: 6.50,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/c/c7/Sweet_potato_fries.jpg', link: '',
  ),
  Dish(
    id: '19',
    name: 'Papas doradas',
    description: 'Papas doradas crocantes',
    price: 7.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/fd/Patatas_doradas.jpg', link: '',
  ),
  Dish(
    id: '20',
    name: 'Papas sancochadas',
    description: 'Papas sancochadas tradicionales',
    price: 5.50,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/1/1f/Boiled_potatoes.jpg', link: '',
  ),
  Dish(
    id: '21',
    name: 'Pan',
    description: 'Pan fresco',
    price: 2.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Fresh_bread_basket.jpg', link: '',
  ),
  Dish(
    id: '22',
    name: 'Ají pollero',
    description: 'Salsa ají especial para pollo',
    price: 1.50,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/26/Peruvian_aji.jpg', link: '',
  ),
  Dish(
    id: '23',
    name: 'Mayonesa',
    description: 'Mayonesa tradicional',
    price: 1.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/e0/Mayonnaise_jar.jpg', link: '',
  ), 
  Dish(
    id: '24',
    name: 'Kétchup',
    description: 'Salsa de kétchup',
    price: 1.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Ketchup_bottle.jpg', link: '',
  ),
  Dish(
    id: '25',
    name: 'Mostaza',
    description: 'Salsa de mostaza',
    price: 1.00,
    category: 'Acompañamientos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Mustard_condiment.jpg', link: '',
  ),

  // Platos principales (15)
  Dish(
    id: '26',
    name: 'Pollo a la brasa entero',
    description: 'Pollo entero a la brasa con papas y ensalada',
    price: 25.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/9/90/Pollo_a_la_Brasa_%28Peruvian_Style_Rotisserie_Chicken%29.jpg', link: '',
  ),
  Dish(
    id: '27',
    name: '½ Pollo a la brasa',
    description: 'Medio pollo a la brasa con papas y ensalada',
    price: 15.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/1/15/Half_Chicken_Rotisserie.jpg', link: '',
  ),
  Dish(
    id: '28',
    name: '¼ Pollo a la brasa',
    description: 'Cuarto de pollo a la brasa con papas y ensalada',
    price: 9.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/1/1f/Quarter_Chicken_Rotisserie.jpg', link: '',
  ),
  Dish(
    id: '29',
    name: 'Pollo broaster',
    description: 'Pollo frito estilo broaster',
    price: 20.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/f9/Broasted_chicken.jpg', link: '',
  ),
  Dish(
    id: '30',
    name: 'Pollo al horno',
    description: 'Pollo al horno jugoso',
    price: 22.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/27/Roast_Chicken_1.jpg', link: '',
  ),
  Dish(
    id: '31',
    name: 'Pollo a la parrilla',
    description: 'Pollo a la parrilla sabroso',
    price: 23.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/3/34/Grilled_chicken.jpg', link: '',
  ),
  Dish(
    id: '32',
    name: 'Anticuchos de pollo',
    description: 'Brochetas de pollo marinadas',
    price: 18.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/9/9e/Anticuchos_Peruanos.jpg', link: '',
  ),
  Dish(
    id: '33',
    name: 'Alitas BBQ',
    description: 'Alitas de pollo con salsa BBQ',
    price: 17.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/3/34/BBQ_chicken_wings.jpg', link: '',
  ),
  Dish(
    id: '34',
    name: 'Alitas picantes',
    description: 'Alitas de pollo picantes',
    price: 17.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/a6/Spicy_chicken_wings.jpg', link: '',
  ),
  Dish(
    id: '35',
    name: 'Nuggets de pollo',
    description: 'Nuggets de pollo crocantes',
    price: 15.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Chicken_nuggets_with_dip.jpg', link: '',
  ),
  Dish(
    id: '36',
    name: 'Combo 1: ¼ pollo + papas + ensalada',
    description: 'Combo con cuarto de pollo, papas y ensalada',
    price: 18.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/4/4d/Chicken_combo.jpg', link: '',
  ),
  Dish(
    id: '37',
    name: 'Combo 2: ½ pollo + arroz chaufa + gaseosa',
    description: 'Combo con medio pollo, arroz chaufa y gaseosa',
    price: 22.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/87/Chicken_rice_combo.jpg', link: '',
  ),
  Dish(
    id: '38',
    name: 'Combo familiar: pollo entero + papas + ensalada + gaseosa 2.25L',
    description: 'Combo familiar con pollo entero y acompañamientos',
    price: 35.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/63/Family_meal.jpg', link: '',
  ),
  Dish(
    id: '39',
    name: 'Pollo con arroz',
    description: 'Pollo acompañado de arroz blanco',
    price: 16.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/3/31/Chicken_and_rice.jpg', link: '',
  ),
  Dish(
    id: '40',
    name: 'Hamburguesa de pollo',
    description: 'Hamburguesa con carne de pollo',
    price: 12.00,
    category: 'Pollos',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/e2/Chicken_burger.jpg', link: '',
  ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Dish> get _filteredDishes {
    return _dishes.where((dish) {
      final matchesCategory =
          _selectedCategory == 'Todos' || dish.category == _selectedCategory;
      final matchesSearch =
          dish.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dish.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú'),
        backgroundColor: Color(0xFFFF6B35),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar platos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    selectedColor: Color(0xFFFF6B35),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : 'Todos';
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _filteredDishes.isEmpty
                ? Center(
                    child: Text(
                      'No se encontraron platos',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: _filteredDishes.length,
                    itemBuilder: (context, index) {
                      final dish = _filteredDishes[index];
                      return _buildDishCard(dish);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishCard(Dish dish) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE0B2),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(dish.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        dish.description,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'S/. ${dish.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6B35),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  CartService.addToCart(dish);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${dish.name} añadido al carrito'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Text('Añadir al carrito'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6B35),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
