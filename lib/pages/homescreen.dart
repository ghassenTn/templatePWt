import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Template {
  final String imagePath;
  final double price;
  bool isFavorite;
  int quantity;
  List<String> reviews;
  double rating;

  Template({
    required this.imagePath,
    required this.price,
    this.isFavorite = false,
    this.quantity = 0,
    this.reviews = const [],
    this.rating = 0.0,
  });
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PowerPoint Templates Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseAuth _auth; 
  List<Template> templates = [
    Template(
        imagePath: 'images/template1.webp',
        price: 19.99,
        reviews: ['Great template!', 'Good design'],
        rating: 4.5),
    Template(
        imagePath: 'images/template2.webp',
        price: 24.99,
        reviews: ['Nice one!'],
        rating: 3.8),
    Template(
        imagePath: 'images/template3.webp',
        price: 14.99,
        reviews: [],
        rating: 0.0),
    Template(
        imagePath: 'images/template15.webp',
        price: 14.99,
        reviews: ['Awesome!'],
        rating: 5.0),
    Template(
        imagePath: 'images/template6.webp',
        price: 19.99,
        reviews: ['Great template!', 'Good design'],
        rating: 4.5),
    Template(
        imagePath: 'images/template2.webp',
        price: 24.99,
        reviews: ['Nice one!'],
        rating: 3.8),
    Template(
        imagePath: 'images/template1.webp',
        price: 14.99,
        reviews: [],
        rating: 0.0),
    Template(
        imagePath: 'images/template15.webp',
        price: 14.99,
        reviews: ['Awesome!'],
        rating: 5.0),
    Template(
        imagePath: 'images/template1.webp',
        price: 14.99,
        reviews: ['Awesome!'],
        rating: 5.0),
    Template(
        imagePath: 'images/template15.webp',
        price: 14.99,
        reviews: ['Awesome!'],
        rating: 5.0),
  ];

  List<Template> cartItems = [];

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance; 
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PowerPoint Templates',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut(context);
            },
          ),
        ],
        leading: Icon(Icons.person),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: templates.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TemplateDetailsScreen(template: templates[index]),
                  ),
                );
              },
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15.0)),
                        child: Image.asset(
                          templates[index].imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${templates[index].price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                templates[index].isFavorite =
                                    !templates[index].isFavorite;
                              });
                            },
                            icon: Icon(
                              templates[index].isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: templates[index].isFavorite
                                  ? Colors.red
                                  : null,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                templates[index].quantity++;
                                cartItems.add(templates[index]);
                              });
                            },
                            icon: Icon(Icons.add_shopping_cart),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              List<Template> favoriteTemplates =
                  templates.where((template) => template.isFavorite).toList();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavoritesPage(
                        favoriteTemplates: favoriteTemplates,
                        cartItems: cartItems)),
              );
            },
            child: Icon(Icons.favorite),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPage(cartItems: cartItems)),
              );
            },
            child: Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }
}

class TemplateDetailsScreen extends StatefulWidget {
  final Template template;

  TemplateDetailsScreen({required this.template});

  @override
  _TemplateDetailsScreenState createState() => _TemplateDetailsScreenState();
}

class _TemplateDetailsScreenState extends State<TemplateDetailsScreen> {
  double _userRating = 0.0;
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Template Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Template Price: \$${widget.template.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20),
            Text(
              'Rating: ${widget.template.rating.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10),
            RatingBar.builder(
              initialRating: _userRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _userRating = rating;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                
                setState(() {
                  widget.template.rating = _userRating;
                  widget.template.reviews.add(_descriptionController.text);
                });
              },
              child: Text('Submit Review'),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.template.reviews.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.template.reviews[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}

class FavoritesPage extends StatelessWidget {
  final List<Template> favoriteTemplates;
  final List<Template> cartItems;

  FavoritesPage({required this.favoriteTemplates, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite Templates'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: favoriteTemplates.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TemplateDetailsScreen(template: favoriteTemplates[index]),
                ),
              );
            },
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15.0)),
                      child: Image.asset(
                        favoriteTemplates[index].imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\$${favoriteTemplates[index].price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CartPage(cartItems: cartItems)),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Template> cartItems;

  CartPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        cartItems.fold(0, (previous, current) => previous + current.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('\$${cartItems[index].price.toStringAsFixed(2)}'),
            leading: Image.asset(
              cartItems[index].imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Checkout'),
                      content: Text(
                          'Total amount: \$${totalPrice.toStringAsFixed(2)}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
