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
    imageUrl: 'https://tiptop.com.pe/wp-content/uploads/2023/06/Gaseosa-1.5L-scaled.jpg', link: '',
  ),
  Dish(
    id: '3',
    name: 'Gaseosa de 1.5 litros',
    description: 'Botella de gaseosa de 1.5 litros',
    price: 8.00,
    category: 'Bebidas',
    imageUrl: 'https://www.peoplepizzas.com/app/img_productos/15.jpg', link: '',
  ),
  Dish(
    id: '4',
    name: 'Gaseosa de 2.25 litros',
    description: 'Botella de gaseosa de 2.25 litros',
    price: 10.00,
    category: 'Bebidas',
    imageUrl: 'https://comparafacil.net.pe/wp-content/uploads/2024/02/Gaseosa-Sprite-2.25L.png', link: '',
  ),
  Dish(
    id: '5',
    name: 'Inka Kola',
    description: 'Botella de Inka Kola',
    price: 5.00,
    category: 'Bebidas',
    imageUrl: 'https://daywi.com.pe/wp-content/uploads/2023/07/inca-kola-600x600.webp', link: '',
  ),
  Dish(
    id: '6',
    name: 'Agua mineral',
    description: 'Botella de agua mineral',
    price: 3.50,
    category: 'Bebidas',
    imageUrl: 'https://media.falabella.com/tottusPE/10225059_1/w=1500,h=1500,fit=pad', link: '',
  ),
  Dish(
    id: '7',
    name: 'Agua con gas',
    description: 'Botella de agua con gas',
    price: 4.00,
    category: 'Bebidas',
    imageUrl: 'https://florayfauna.vtexassets.com/arquivos/ids/166430-1200-auto?v=638754042761000000&width=1200&height=auto&aspect=true', link: '',
  ),
  Dish(
    id: '8',
    name: 'Chicha morada',
    description: 'Bebida tradicional peruana de maíz morado',
    price: 5.00,
    category: 'Bebidas',
    imageUrl: 'https://freskos.com.pe/wp-content/uploads/2021/03/10-Chicha-morada.png', link: '',
  ),
  Dish(
    id: '9',
    name: 'Jugo de maracuyá',
    description: 'Jugo natural de maracuyá',
    price: 6.00,
    category: 'Bebidas',
    imageUrl: 'https://lacapilladelcafe.com/Carta/Controllers/cCategoria.php?opcion=imagen&codigo=69', link: '',
  ),
  Dish(
    id: '10',
    name: 'Cerveza',
    description: 'Botella de cerveza',
    price: 8.00,
    category: 'Bebidas',
    imageUrl: 'https://almendariz.com.pe/wp-content/uploads/2022/05/SIX-PACK-CERVEZA-PILSEN-X-310-ML-600x600.jpg', link: '',
  ),

  // Acompañamientos (15)
  Dish(
    id: '11',
    name: 'Papas fritas',
    description: 'Papas fritas crujientes',
    price: 7.00,
    category: 'Acompañamientos',
    imageUrl: 'https://plazavea.vteximg.com.br/arquivos/ids/9813442-465-465/131925.jpg', link: '',
  ),
  Dish(
    id: '12',
    name: 'Ensalada clásica',
    description: 'Ensalada fresca clásica',
    price: 6.00,
    category: 'Acompañamientos',
    imageUrl: 'https://metroio.vtexassets.com/arquivos/ids/422183-1200-auto?v=638280186223430000&width=1200&height=auto&aspect=true', link: '',
  ),
  Dish(
    id: '13',
    name: 'Ensalada rusa',
    description: 'Ensalada rusa con mayonesa',
    price: 6.50,
    category: 'Acompañamientos',
    imageUrl: 'https://wongfood.vtexassets.com/arquivos/ids/554058-1200-auto?v=637904145831630000&width=1200&height=auto&aspect=true', link: '',
  ),
  Dish(
    id: '14',
    name: 'Arroz blanco',
    description: 'Porción de arroz blanco',
    price: 5.00,
    category: 'Acompañamientos',
    imageUrl: 'https://www.infobae.com/resizer/v2/DFN6EUB2SFC7BPEAQWDCKUJUIA.jpg?auth=899099e90e53f8290003d9c77946b92731be4d6d95f6e8edf3e1cfb06bdbc2bb&smart=true&width=992&height=558&quality=85', link: '',
  ),
  Dish(
    id: '15',
    name: 'Arroz chaufa de pollo',
    description: 'Arroz chaufa con pollo',
    price: 9.00,
    category: 'Acompañamientos',
    imageUrl: 'https://origin.cronosmedia.glr.pe/large/2020/12/18/lg_5fdd5b4acf89f80dcc653f1d.jpg', link: '',
  ),
  Dish(
    id: '16',
    name: 'Yuca frita',
    description: 'Porción de yuca frita',
    price: 7.00,
    category: 'Acompañamientos',
    imageUrl: 'https://okdiario.com/img/2024/07/16/yuca-frita_-receta-crujiente-635x358.jpg', link: '',
  ),
  Dish(
    id: '17',
    name: 'Plátano frito',
    description: 'Plátano maduro frito',
    price: 6.00,
    category: 'Acompañamientos',
    imageUrl: 'https://media.istockphoto.com/id/1068984822/es/foto/rodajas-de-pl%C3%A1tano-maduro-frito-profundo-aislados-en-fondo-blanco.jpg?s=2048x2048&w=is&k=20&c=QjT-e3ZxBLhGm6f-Em8GrOcS8CVCAjmuEmrvgjd2Ft8=', link: '',
  ),
  Dish(
    id: '18',
    name: 'Camote frito',
    description: 'Camote frito dulce',
    price: 6.50,
    category: 'Acompañamientos',
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_950721-MPE80703932986_112024-O-mango-deshidratado-en-rodajas-kera-superfoods.webp', link: '',
  ),
  Dish(
    id: '19',
    name: 'Papas doradas',
    description: 'Papas doradas crocantes',
    price: 7.00,
    category: 'Acompañamientos',
    imageUrl: 'https://lamejicana.mx/cdn/shop/products/Papafrita_720x.jpg?v=1596425092', link: '',
  ),
  Dish(
    id: '20',
    name: 'Papas sancochadas',
    description: 'Papas sancochadas tradicionales',
    price: 5.50,
    category: 'Acompañamientos',
    imageUrl: 'https://emofly.b-cdn.net/hbd_exvhac6ayb3ZKT/width:1080/plain/https://storage.googleapis.com/takeapp/media/cm3otzukf00040ck09m1w8rxq.jpeg', link: '',
  ),
  Dish(
    id: '21',
    name: 'Pan',
    description: 'Pan fresco',
    price: 2.00,
    category: 'Acompañamientos',
    imageUrl: 'https://statics.tipti.market/product-media/7143e8c0-3706-4129-91b5-6e1fb30f49e8.jpg', link: '',
  ),
  Dish(
    id: '22',
    name: 'Ají pollero',
    description: 'Salsa ají especial para pollo',
    price: 1.50,
    category: 'Acompañamientos',
    imageUrl: 'https://xipetexmex.com/wp-content/uploads/2024/05/Aji-Pollero.jpg', link: '',
  ),
  Dish(
    id: '23',
    name: 'Mayonesa',
    description: 'Mayonesa tradicional',
    price: 1.00,
    category: 'Acompañamientos',
    imageUrl: 'https://cocina-casera.com/wp-content/uploads/2017/12/Mayonesa-japonesa-1-1.jpg', link: '',
  ), 
  Dish(
    id: '24',
    name: 'Kétchup',
    description: 'Salsa de kétchup',
    price: 1.00,
    category: 'Acompañamientos',
    imageUrl: 'https://static.guiainfantil.com/pictures/recetas2/40000/40945-4-como-hacer-ketchup-receta-de-salsa-casera.jpg', link: '',
  ),
  Dish(
    id: '25',
    name: 'Mostaza',
    description: 'Salsa de mostaza',
    price: 1.00,
    category: 'Acompañamientos',
    imageUrl: 'https://i1.wp.com/tienda.fogo.pe/wp-content/uploads/2021/10/salsa-mostaza.png?w=680&ssl=1', link: '',
  ),

  // Platos principales (15)
  Dish(
    id: '26',
    name: 'Pollo a la brasa entero',
    description: 'Pollo entero a la brasa con papas y ensalada',
    price: 25.00,
    category: 'Pollos',
    imageUrl: 'https://www.infobae.com/resizer/v2/ADCM53ALU5GIFAT3PDG5T2DXO4.jpg?auth=77bc9a31e20fc0f7d48831afb783cda21c5744fd322078336f285f68e4425315&smart=true&width=992&height=558&quality=85', link: '',
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
    imageUrl: 'https://images.rappi.pe/restaurants_background/41698_1661889124985.png?e=webp&d=200x200&q=50', link: '',
  ),
  Dish(
    id: '29',
    name: 'Pollo broaster',
    description: 'Pollo frito estilo broaster',
    price: 20.00,
    category: 'Pollos',
    imageUrl: 'https://jameaperu.com/assets/images/pollo-broaster_800x534.webp', link: '',
  ),
  Dish(
    id: '30',
    name: 'Pollo al horno',
    description: 'Pollo al horno jugoso',
    price: 22.00,
    category: 'Pollos',
    imageUrl: 'https://recetasdecocina.elmundo.es/wp-content/uploads/2024/12/pollo-asado-1024x683.jpg', link: '',
  ),
  Dish(
    id: '31',
    name: 'Pollo a la parrilla',
    description: 'Pollo a la parrilla sabroso',
    price: 23.00,
    category: 'Pollos',
    imageUrl: 'https://diabetesfoodhub.org/sites/foodhub/files/styles/recipe_hero_banner_720w/public/1948-honey-lime-chicken-DFH-MJ20.webp?h=48784f2c&itok=U7I-JyOA', link: '',
  ),
  Dish(
    id: '32',
    name: 'Anticuchos de pollo',
    description: 'Brochetas de pollo marinadas',
    price: 18.00,
    category: 'Pollos',
    imageUrl: 'https://www.cocinacaserayfacil.net/wp-content/uploads/2021/07/Brochetas-de-pollo-marinadas-con-miel-y-mostaza-1.jpg', link: '',
  ),
  Dish(
    id: '33',
    name: 'Alitas BBQ',
    description: 'Alitas de pollo con salsa BBQ',
    price: 17.00,
    category: 'Pollos',
    imageUrl: 'https://www.elespectador.com/resizer/v2/4XAVJU4FBFAULLIA2JOF74BEKU.png?auth=7ee24c6e852e08118ac404af8b5e79df71eba6dca9082ca5814a41def682667e&width=920&height=613&smart=true&quality=60', link: '',
  ),
  Dish(
    id: '34',
    name: 'Alitas picantes',
    description: 'Alitas de pollo picantes',
    price: 17.00,
    category: 'Pollos',
    imageUrl: 'https://polloseldorado.co/wp-content/uploads/2023/04/Imagene-1-1024x536.jpg', link: '',
  ),
  Dish(
    id: '35',
    name: 'Nuggets de pollo',
    description: 'Nuggets de pollo crocantes',
    price: 15.00,
    category: 'Pollos',
    imageUrl: 'https://assets.elgourmet.com/wp-content/uploads/2024/01/Nuguetts-5-1-1024x683.jpg.webp', link: '',
  ),
  Dish(
    id: '36',
    name: 'Combo 1: ¼ pollo + papas + ensalada',
    description: 'Combo con cuarto de pollo, papas y ensalada',
    price: 18.00,
    category: 'Pollos',
    imageUrl: 'https://wongfood.vtexassets.com/arquivos/ids/652982-1200-auto?v=638285926378170000&width=1200&height=auto&aspect=true', link: '',
  ),
  Dish(
    id: '37',
    name: 'Combo 2: ½ pollo + arroz chaufa + gaseosa',
    description: 'Combo con medio pollo, arroz chaufa y gaseosa',
    price: 22.00,
    category: 'Pollos',
    imageUrl: 'https://polleriabrasasdelcentro.wordpress.com/wp-content/uploads/2021/07/pollo-con-chaufa-1.png?w=1024', link: '',
  ),
  Dish(
    id: '38',
    name: 'Combo familiar: pollo entero + papas + ensalada + gaseosa 2.25L',
    description: 'Combo familiar con pollo entero y acompañamientos',
    price: 35.00,
    category: 'Pollos',
    imageUrl: 'https://plazavea.vteximg.com.br/arquivos/ids/203912-1000-1000/pollo-rostizado-papas-fritas-chicha.jpg', link: '',
  ),
  Dish(
    id: '39',
    name: 'Pollo con arroz',
    description: 'Pollo acompañado de arroz blanco',
    price: 16.00,
    category: 'Pollos',
    imageUrl: 'https://storage.googleapis.com/avena-recipes-v2/agtzfmF2ZW5hLWJvdHIZCxIMSW50ZXJjb21Vc2VyGICAgMW2rJ8LDA/01-03-2021/1614640309286.jpeg', link: '',
  ),
  Dish(
    id: '40',
    name: 'Hamburguesa de pollo',
    description: 'Hamburguesa con carne de pollo',
    price: 12.00,
    category: 'Pollos',
    imageUrl: 'https://www.recetasnestle.com.ec/sites/default/files/styles/recipe_detail_desktop_new/public/srh_recipes/681c719667d572276a1507aea71de9ca.webp?itok=BXa7wk3U', link: '',
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
