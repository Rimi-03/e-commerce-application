import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataSeeder {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Seed all data
  static Future<void> seedAllData() async {
    await seedProducts();
  }

  //Add sample products to Firestore
  static Future<void> seedProducts() async {
    final List<Map<String, dynamic>> sampleProducts = [
      {
        'name': 'Nike Air Max',
        'description': 'Comfortable running shoes for everyday use',
        'price': 120.0,
        'discountPrice': 99.0,
        'category': 'Sports & Fitness',
        'brand': 'Nike',
        'imageUrl': 'https://example.com/images/nike_air_max.png',
        'isFeatured': true,
        'isOnSale': true,
        'isActive': true,
        'stock': 25,
        'rating': 4.6,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Wooden Study Table',
        'description': 'Modern wooden table perfect for home office',
        'price': 250.0,
        'discountPrice': null,
        'category': 'Home & Living',
        'brand': 'IKEA',
        'imageUrl': 'https://example.com/images/study_table.png',
        'isFeatured': false,
        'isOnSale': false,
        'isActive': true,
        'stock': 10,
        'rating': 4.3,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Wireless Headphones',
        'description': 'Noise cancelling Bluetooth headphones',
        'price': 180.0,
        'discountPrice': 150.0,
        'category': 'Electronics',
        'brand': 'Sony',
        'imageUrl': 'https://example.com/images/headphones.png',
        'isFeatured': true,
        'isOnSale': true,
        'isActive': true,
        'stock': 40,
        'rating': 4.8,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Smart Watch Series 6',
        'description': 'Fitness tracking smart watch with heart rate monitor',
        'price': 220.0,
        'discountPrice': 199.0,
        'category': 'Electronics',
        'brand': 'Apple',
        'imageUrl': 'https://example.com/images/smartwatch.png',
        'isFeatured': true,
        'isOnSale': false,
        'isActive': true,
        'stock': 30,
        'rating': 4.7,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Running Shoes',
        'description': 'Lightweight running shoes for daily workouts',
        'price': 120.0,
        'discountPrice': 95.0,
        'category': 'Sports & Fitness',
        'brand': 'Nike',
        'imageUrl': 'https://example.com/images/shoes.png',
        'isFeatured': false,
        'isOnSale': true,
        'isActive': true,
        'stock': 50,
        'rating': 4.5,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Leather Handbag',
        'description': 'Premium leather handbag for everyday use',
        'price': 160.0,
        'discountPrice': 135.0,
        'category': 'Fashion',
        'brand': 'Zara',
        'imageUrl': 'https://example.com/images/handbag.png',
        'isFeatured': true,
        'isOnSale': false,
        'isActive': true,
        'stock': 20,
        'rating': 4.6,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Coffee Maker',
        'description': 'Automatic coffee maker with multiple brew options',
        'price': 140.0,
        'discountPrice': 119.0,
        'category': 'Home & Living',
        'brand': 'Philips',
        'imageUrl': 'https://example.com/images/coffeemaker.png',
        'isFeatured': false,
        'isOnSale': true,
        'isActive': true,
        'stock': 18,
        'rating': 4.4,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Gaming Keyboard',
        'description': 'Mechanical RGB gaming keyboard with fast response',
        'price': 110.0,
        'discountPrice': 89.0,
        'category': 'Electronics',
        'brand': 'Logitech',
        'imageUrl': 'https://example.com/images/keyboard.png',
        'isFeatured': true,
        'isOnSale': true,
        'isActive': true,
        'stock': 35,
        'rating': 4.9,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Yoga Mat',
        'description': 'Non-slip yoga mat for home workouts and stretching',
        'price': 45.0,
        'discountPrice': 35.0,
        'category': 'Sports & Fitness',
        'brand': 'Adidas',
        'imageUrl': 'https://example.com/images/yogamat.png',
        'isFeatured': false,
        'isOnSale': true,
        'isActive': true,
        'stock': 60,
        'rating': 4.3,
        'createdAt': FieldValue.serverTimestamp(),
      },
    ];

    try {
      //Check if products already exist
      final existingProducts = await _firestore
          .collection('products')
          .limit(1)
          .get();

      if (existingProducts.docs.isEmpty) {
        //Add sample products only if collection is empty
        for (var product in sampleProducts) {
          await _firestore.collection('products').add(product);
        }
        print('Sample products added to firestore successfully!.');
      } else {
        print('Product already exist in Firestore. Skipping seed data.');
      }
    } catch (e) {
      print('Error seeding products: $e');
    }
  }
}
