import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataSeeder {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Seed all data
  static Future<void> seedAllData() async {
    await seedProducts();
    await seedCategories();
  }

  // Add sample products to Firestore
  static Future<void> seedCategories() async {
    final sampleCategories = [
      {
        'name': 'Electronics',
        'displayName': 'Electronics',
        'description': 'Electronics devices and gadgets',
        'isActive': true,
        'sortOrder': 1,
        'subCategories': [
          'Smartphones',
          'Laptops',
          'Tablets',
          'Wearables',
          'Audio',
        ],
        'metadata': {'color': '#2196F3', 'icon': 'electronics'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Footwear',
        'displayName': 'Footwear',
        'description': 'Shoes and footwear for all occasions',
        'isActive': true,
        'sortOrder': 2,
        'subCategories': [
          'Running Shoes',
          'Basketball Shoes',
          'Lifestyle Shoes',
          'Boots',
          'Sandals',
        ],
        'metadata': {'color': '#FF9800', 'icon': 'footwear'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Clothing',
        'displayName': 'Clothing',
        'description': 'Fashion and apparel for men and women',
        'isActive': true,
        'sortOrder': 3,
        'subCategories': [
          'T-shirts',
          'Jeans',
          'Dreases',
          'Jackets',
          'Activewear',
        ],
        'metadata': {'color': '#E91E63', 'icon': 'clothing'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Accessories',
        'displayName': 'Accessories',
        'description': 'Fashion accessories and jwellary',
        'isActive': true,
        'sortOrder': 4,
        'subCategories': [
          'Watches',
          'Jwellary',
          'Bags',
          'Sunglasses',
          'Belts',
        ],
        'metadata': {'color': '#9C27B0', 'icon': 'accessories'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Home',
        'displayName': 'Home & Living',
        'description': 'Home decor and living essentials',
        'isActive': true,
        'sortOrder': 5,
        'subCategories': [
          'Furniture',
          'Decor',
          'Kitchen',
          'Bedding',
          'Storage',
        ],
        'metadata': {'color': '#4CAF50', 'icon': 'home'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Sports',
        'displayName': 'Sports & Fitness',
        'description': 'Sports equipment and fitness gear',
        'isActive': true,
        'sortOrder': 6,
        'subCategories': [
          'Gym Equipment',
          'Outdoor Sports',
          'Team Sports',
          'Fitness Apparel',
        ],
        'metadata': {'color': '#FF5722', 'icon': 'sports'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    ];

    try{
      //check if  categories already exists
      final existingCategories = await _firestore.collection('categories').limit(1).get();
      if(existingCategories.docs.isNotEmpty){
        for(var category in sampleCategories){
          await _firestore.collection('categories').add(category);
        }
        print('Sample categories added to Firestore successfully!');
      }else{
        print('Categories already exists in Firestore. Skipping seed data.');
      }
    }catch(e){
      print('Error seeding categories: $e');
    }
  }


  // Add sample products to Firestore
  static Future<void> seedProducts() async {
    final sampleProducts = [
      {
        'name': 'Nike Air Max',
        'description': 'Comfortable running shoes for everyday use',
        'price': 120.0,
        'oldPrice': 99.0,
        'category': 'Sports & Fitness',
        'subcategory': 'Shoes',
        'brand': 'Nike',
        'sku': 'NIKE-AM-001',
        'images': ['assets/images/shoe.jpg'],
        'primaryImage':
            'https://images.pexels.com/photos/10657976/pexels-photo-10657976.jpeg',
        'stock': 25,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.6,
        'reviewCount': 10,
        'tags': ['running', 'nike', 'shoes'],
        'specifications': {'color': 'Red', 'sizeRange': '6-12'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Wooden Study Table',
        'description': 'Modern wooden table perfect for home office',
        'price': 250.0,
        'oldPrice': null,
        'category': 'Home & Living',
        'subcategory': 'Furniture',
        'brand': 'IKEA',
        'sku': 'IKEA-TABLE-01',
        'images': ['assets/images/table.png'],
        'primaryImage':
            'https://images.pexels.com/photos/8250983/pexels-photo-8250983.jpeg',
        'stock': 10,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': false,
        'rating': 4.3,
        'reviewCount': 5,
        'tags': ['table', 'wood', 'furniture'],
        'specifications': {'material': 'Wood', 'dimensions': '120x60x75cm'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Wireless Headphones',
        'description': 'Noise cancelling Bluetooth headphones',
        'price': 180.0,
        'oldPrice': 150.0,
        'category': 'Electronics',
        'subcategory': 'Audio',
        'brand': 'Sony',
        'sku': 'SONY-WH-01',
        'images': ['assets/images/headphone.png'],
        'primaryImage':
            'https://images.pexels.com/photos/10292806/pexels-photo-10292806.jpeg',
        'stock': 40,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.8,
        'reviewCount': 12,
        'tags': ['headphones', 'wireless', 'bluetooth'],
        'specifications': {'batteryLife': '20h', 'color': 'Black'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Smart Watch Series 6',
        'description': 'Fitness tracking smart watch with heart rate monitor',
        'price': 220.0,
        'oldPrice': 199.0,
        'category': 'Electronics',
        'subcategory': 'Wearables',
        'brand': 'Apple',
        'sku': 'APPLE-SW-06',
        'images': ['assets/images/watch.png'],
        'primaryImage':
            'https://images.pexels.com/photos/29730990/pexels-photo-29730990.jpeg',
        'stock': 30,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': false,
        'rating': 4.7,
        'reviewCount': 8,
        'tags': ['smartwatch', 'fitness', 'apple'],
        'specifications': {'batteryLife': '18h', 'color': 'Silver'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Running Shoes',
        'description': 'Lightweight running shoes for daily workouts',
        'price': 120.0,
        'oldPrice': 95.0,
        'category': 'Sports & Fitness',
        'subcategory': 'Shoes',
        'brand': 'Nike',
        'sku': 'NIKE-RS-001',
        'images': ['assets/images/shoe2.jpg'],
        'primaryImage':
            'https://images.pexels.com/photos/4252970/pexels-photo-4252970.jpeg',
        'stock': 50,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': true,
        'rating': 4.5,
        'reviewCount': 15,
        'tags': ['running', 'workout', 'shoes'],
        'specifications': {'color': 'Blue', 'sizeRange': '6-12'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Leather Handbag',
        'description': 'Premium leather handbag for everyday use',
        'price': 160.0,
        'oldPrice': 135.0,
        'category': 'Fashion',
        'subcategory': 'Bags',
        'brand': 'Zara',
        'sku': 'ZARA-LH-001',
        'images': ['assets/images/handbag.png'],
        'primaryImage':
            'https://images.pexels.com/photos/26736140/pexels-photo-26736140.jpeg',
        'stock': 20,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': false,
        'rating': 4.6,
        'reviewCount': 7,
        'tags': ['handbag', 'leather', 'fashion'],
        'specifications': {
          'color': 'Brown',
          'material': 'Leather',
          'weight': '0.5kg',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Coffee Maker',
        'description': 'Automatic coffee maker with multiple brew options',
        'price': 140.0,
        'oldPrice': 119.0,
        'category': 'Home & Living',
        'subcategory': 'Appliances',
        'brand': 'Philips',
        'sku': 'PHIL-COF-01',
        'images': ['assets/images/coffeemaker.png'],
        'primaryImage':
            'https://images.pexels.com/photos/27638168/pexels-photo-27638168.jpeg',
        'stock': 18,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': true,
        'rating': 4.4,
        'reviewCount': 9,
        'tags': ['coffee', 'appliance', 'kitchen'],
        'specifications': {'capacity': '1.5L', 'power': '1000W'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Gaming Keyboard',
        'description': 'Mechanical RGB gaming keyboard with fast response',
        'price': 110.0,
        'oldPrice': 89.0,
        'category': 'Electronics',
        'subcategory': 'Peripherals',
        'brand': 'Logitech',
        'sku': 'LOGI-GK-01',
        'images': ['assets/images/keyboard.png'],
        'primaryImage':
            'https://images.pexels.com/photos/5944189/pexels-photo-5944189.jpeg',
        'stock': 35,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.9,
        'reviewCount': 14,
        'tags': ['keyboard', 'gaming', 'mechanical'],
        'specifications': {'color': 'Black', 'keys': 'Mechanical RGB'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Yoga Mat',
        'description': 'Non-slip yoga mat for home workouts and stretching',
        'price': 45.0,
        'oldPrice': 35.0,
        'category': 'Sports & Fitness',
        'subcategory': 'Accessories',
        'brand': 'Adidas',
        'sku': 'ADID-YM-01',
        'images': ['assets/images/yogamat.jpg'],
        'primaryImage':
            'https://images.pexels.com/photos/6339731/pexels-photo-6339731.jpeg',
        'stock': 60,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': true,
        'rating': 4.3,
        'reviewCount': 6,
        'tags': ['yoga', 'fitness', 'exercise'],
        'specifications': {
          'color': 'Green',
          'material': 'TPE',
          'length': '183cm',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    ];

    try {
      final existingProducts = await _firestore
          .collection('products')
          .limit(1)
          .get();

      if (existingProducts.docs.isEmpty) {
        for (var product in sampleProducts) {
          await _firestore.collection('products').add(product);
        }
        print('Sample products added to Firestore successfully!');
      } else {
        print('Products already exist in Firestore. Skipping seed data.');
      }
    } catch (e) {
      print('Error seeding products: $e');
    }
  }
}
