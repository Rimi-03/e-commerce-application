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
        'subCategories': ['Watches', 'Jwellary', 'Bags', 'Sunglasses', 'Belts'],
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
      {
        'name': 'Beauty',
        'displayName': 'Beauty & Care',
        'description': 'Skincare, grooming, and personal care products',
        'isActive': true,
        'sortOrder': 7,
        'subCategories': [
          'Skincare',
          'Haircare',
          'Fragrances',
          'Makeup',
          'Grooming',
        ],
        'metadata': {
          'color': '#00BCD4',
          'icon': 'face_retouching_natural'
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    ];

    try {
      //check if  categories already exists
      final existingCategories = await _firestore
          .collection('categories')
          .limit(1)
          .get();
      if (existingCategories.docs.isEmpty) {
        for (var category in sampleCategories) {
          await _firestore.collection('categories').add(category);
        }
        print('Sample categories added to Firestore successfully!');
      } else {
        print('Categories already exists in Firestore. Skipping seed data.');
      }
    } catch (e) {
      print('Error seeding categories: $e');
    }
  }

  // Add sample products to Firestore
  static Future<void> seedProducts() async {
    final sampleProducts = [
      {
        'name': 'Nike Air Max',
        'description': 'Comfortable running shoes for everyday use',
        'category': 'Sports & Fitness',
        'subcategory': 'Shoes',
        'price': 120.0,
        'oldPrice': 99.0,
        'currency': 'USD',
        'images': ['assets/images/shoe.jpg'],
        'primaryImage':
            'https://images.pexels.com/photos/10657976/pexels-photo-10657976.jpeg',
        'brand': 'Nike',
        'sku': 'NIKE-AM-001',
        'stock': 25,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.5,
        'reviewCount': 10,
        'tags': ['running', 'nike', 'shoes'],
        'specifications': {
          'color': 'white/blue',
          'material': 'Synthetic',
          'sizes': ['7', '8', '9', '10', '11'],
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'nike',
          'air',
          'max',
          '270',
          'shoes',
          'running',
          'footwear',
          'white',
          'blue',
        ],
      },
      {
        'name': 'Wooden Study Table',
        'description': 'Modern wooden table perfect for home office',
        'category': 'Home & Living',
        'subcategory': 'Furniture',
        'price': 250.0,
        'oldPrice': null,
        'currency': 'USD',
        'images': ['assets/images/table.png'],
        'primaryImage':
            'https://images.pexels.com/photos/8250983/pexels-photo-8250983.jpeg',
        'brand': 'IKEA',
        'sku': 'IKEA-TABLE-01',
        'stock': 10,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': false,
        'rating': 4.3,
        'reviewCount': 5,
        'tags': ['table', 'wood', 'furniture'],
        'specifications': {
          'material': 'Wood',
          'dimensions': '120x60x75cm',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'ikea',
          'table',
          'wooden',
          'study',
          'furniture',
          'office',
          'home',
        ],
      },
      {
        'name': 'Wireless Headphones',
        'description': 'Noise cancelling Bluetooth headphones',
        'category': 'Electronics',
        'subcategory': 'Audio',
        'price': 180.0,
        'oldPrice': 150.0,
        'currency': 'USD',
        'images': ['assets/images/headphone.png'],
        'primaryImage':
            'https://images.pexels.com/photos/10292806/pexels-photo-10292806.jpeg',
        'brand': 'Sony',
        'sku': 'SONY-WH-01',
        'stock': 40,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.8,
        'reviewCount': 12,
        'tags': ['headphones', 'wireless', 'bluetooth'],
        'specifications': {
          'color': 'Black',
          'batteryLife': '20h',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'sony',
          'headphones',
          'wireless',
          'bluetooth',
          'audio',
          'noise',
          'cancelling',
        ],
      },
      {
        'name': 'Smart Watch Series 6',
        'description': 'Fitness tracking smart watch with heart rate monitor',
        'category': 'Electronics',
        'subcategory': 'Wearables',
        'price': 220.0,
        'oldPrice': 199.0,
        'currency': 'USD',
        'images': ['assets/images/watch.png'],
        'primaryImage':
            'https://images.pexels.com/photos/29730990/pexels-photo-29730990.jpeg',
        'brand': 'Apple',
        'sku': 'APPLE-SW-06',
        'stock': 30,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': false,
        'rating': 4.7,
        'reviewCount': 8,
        'tags': ['smartwatch', 'fitness', 'apple'],
        'specifications': {
          'color': 'Silver',
          'batteryLife': '18h',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'apple',
          'watch',
          'series',
          '6',
          'smartwatch',
          'fitness',
          'wearable',
        ],
      },
      {
        'name': 'Running Shoes',
        'description': 'Lightweight running shoes for daily workouts',
        'category': 'Sports & Fitness',
        'subcategory': 'Shoes',
        'price': 120.0,
        'oldPrice': 95.0,
        'currency': 'USD',
        'images': ['assets/images/shoe2.jpg'],
        'primaryImage':
            'https://images.pexels.com/photos/4252970/pexels-photo-4252970.jpeg',
        'brand': 'Nike',
        'sku': 'NIKE-RS-001',
        'stock': 50,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': true,
        'rating': 4.5,
        'reviewCount': 15,
        'tags': ['running', 'workout', 'shoes'],
        'specifications': {
          'color': 'Blue',
          'sizes': ['6', '7', '8', '9', '10', '11', '12'],
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'nike',
          'running',
          'shoes',
          'workout',
          'footwear',
          'blue',
          'lightweight',
        ],
      },
      {
        'name': 'Leather Handbag',
        'description': 'Premium leather handbag for everyday use',
        'category': 'Fashion',
        'subcategory': 'Bags',
        'price': 160.0,
        'oldPrice': 135.0,
        'currency': 'USD',
        'images': ['assets/images/handbag.png'],
        'primaryImage':
            'https://images.pexels.com/photos/26736140/pexels-photo-26736140.jpeg',
        'brand': 'Zara',
        'sku': 'ZARA-LH-001',
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
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'zara',
          'handbag',
          'leather',
          'fashion',
          'bag',
          'brown',
          'premium',
        ],
      },
      {
        'name': 'Coffee Maker',
        'description': 'Automatic coffee maker with multiple brew options',
        'category': 'Home & Living',
        'subcategory': 'Appliances',
        'price': 140.0,
        'oldPrice': 119.0,
        'currency': 'USD',
        'images': ['assets/images/coffeemaker.png'],
        'primaryImage':
            'https://images.pexels.com/photos/27638168/pexels-photo-27638168.jpeg',
        'brand': 'Philips',
        'sku': 'PHIL-COF-01',
        'stock': 18,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': true,
        'rating': 4.4,
        'reviewCount': 9,
        'tags': ['coffee', 'appliance', 'kitchen'],
        'specifications': {
          'capacity': '1.5L',
          'power': '1000W',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'philips',
          'coffee',
          'maker',
          'appliance',
          'kitchen',
          'automatic',
          'brew',
        ],
      },
      {
        'name': 'Gaming Keyboard',
        'description': 'Mechanical RGB gaming keyboard with fast response',
        'category': 'Electronics',
        'subcategory': 'Peripherals',
        'price': 110.0,
        'oldPrice': 89.0,
        'currency': 'USD',
        'images': ['assets/images/keyboard.png'],
        'primaryImage':
            'https://images.pexels.com/photos/5944189/pexels-photo-5944189.jpeg',
        'brand': 'Logitech',
        'sku': 'LOGI-GK-01',
        'stock': 35,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.9,
        'reviewCount': 14,
        'tags': ['keyboard', 'gaming', 'mechanical'],
        'specifications': {
          'color': 'Black',
          'keys': 'Mechanical RGB',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'logitech',
          'keyboard',
          'gaming',
          'mechanical',
          'rgb',
          'peripheral',
        ],
      },
      {
        'name': 'Yoga Mat',
        'description': 'Non-slip yoga mat for home workouts and stretching',
        'category': 'Sports & Fitness',
        'subcategory': 'Accessories',
        'price': 45.0,
        'oldPrice': 35.0,
        'currency': 'USD',
        'images': ['assets/images/yogamat.jpg'],
        'primaryImage':
            'https://images.pexels.com/photos/6339731/pexels-photo-6339731.jpeg',
        'brand': 'Adidas',
        'sku': 'ADID-YM-01',
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
          'dimensions': '183cm x 61cm',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'adidas',
          'yoga',
          'mat',
          'fitness',
          'exercise',
          'workout',
          'green',
          'non-slip',
        ],
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
