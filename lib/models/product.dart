import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final String? subcategory;
  final double price;
  final double? oldPrice;
  final String currency;
  final String description;
  final List<String> images;
  final String primaryImage;
  final String? brand;
  final String? sku;
  final int stock;
  final bool isActive;
  final bool isFeatured;
  final bool isOnSale;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final Map<String, dynamic> specifications;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    this.subcategory,
    required this.price,
    this.oldPrice,
    this.currency = 'USD',
    required this.images,
    required this.primaryImage,
    required this.description,
    this.brand,
    this.sku,
    this.stock = 0,
    this.isActive = true,
    this.isFeatured = false,
    this.isOnSale = false,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.tags = const [],
    this.specifications = const {},
    this.createdAt,
    this.updatedAt,
  });

  // Create product from firestore document
  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      subcategory: data['subcategory'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      oldPrice: data['oldPrice']?.toDouble(),
      currency: data['currency'] ?? 'USD',
      images: List<String>.from(data['images'] ?? []),
      primaryImage: data['primaryImage'] ?? data['images']?[0] ?? '',
      description: data['description'] ?? '',
      brand: data['brand'],
      sku: data['sku'],
      stock: data['stock'] ?? 0,
      isActive: data['isActive'] ?? true,
      isFeatured: data['isFeatured'] ?? false,
      isOnSale: data['isOnSale'] ?? false,
      rating: (data['rating'] ?? 0.0).toDouble(),
      reviewCount: data['reviewCount'] ?? 0,
      tags: List<String>.from(data['tags'] ?? []),
      specifications: Map<String, dynamic>.from(data['specification'] ?? {}),
      createdAt: data['createdAt']?.toDate(),
      updatedAt: data['updatedAt']?.toDate(),
    );
  }

  // Convert Product to frestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': category,
      'subcategory': subcategory,
      'price': price,
      'oldPrice': oldPrice,
      'currency': currency,
      'images': images,
      'primaryImage': primaryImage,
      'brand': brand,
      'sku': sku,
      'stock': stock,
      'isActive': isActive,
      'isFeatured': isFeatured,
      'isOnSale': isOnSale,
      'rating': rating,
      'reviewCount': reviewCount,
      'tags': tags,
      'specifications': specifications,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  //Backward compatibility getter for imageUrl
  String get imageUrl => primaryImage;

  //check if product has discount
  bool get hasDiscount => oldPrice != null && oldPrice! > price;

  // Calculate discount percentage
  int get discountPercentage {
    if (!hasDiscount) return 0;
    return (((oldPrice! - price) / oldPrice!) * 100).round();
  }

  //Check if product is in stock
  bool get isInStock => stock > 0;

  //Get formatted price
  String? get formattedOldPrice =>
      oldPrice != null ? '\$${oldPrice!.toStringAsFixed(2)}' : null;
}


//Legacy dummy data for backwark compatibility
final List<Product> products = [
  const Product(
    id: 'p1',
    name: 'Shoes',
    category: 'Footwear',
    price: 69.00,
    oldPrice: 189.00,
    images: ['assets/images/shoe.jpg'],
    primaryImage: 'assets/images/shoe.jpg',
    description: 'This is a description of product 1',
  ),
  const Product(
    id: 'p2',
    name: 'Laptop',
    category: 'Electronics',
    price: 699.00,
    oldPrice: 899.00,
    images: ['assets/images/laptop.jpg'],
    primaryImage: 'assets/images/laptop.jpg',
    description: 'This is a description of product 2',
  ),
  const Product(
    id: 'p3',
    name: 'Jordan Shoes',
    category: 'Footwear',
    price: 120.00,
    oldPrice: 189.00,
    images: ['assets/images/shoe2.jpg'],
    primaryImage: 'assets/images/shoe2.jpg',
    description: 'This is a description of product 3',
  ),
  const Product(
    id: 'p4',
    name: 'Puma',
    category: 'Footwear',
    price: 99.00,
    oldPrice: 149.00,
    images: ['assets/images/shoes2.jpg'],
    primaryImage: 'assets/images/shoes2.jpg',
    description: 'This is a description of product 4',
  ),
];
