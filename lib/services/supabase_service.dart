import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  SupabaseClient get client => Supabase.instance.client;
  Session? get currentSession => client.auth.currentSession;
  User? get currentUser => client.auth.currentUser;

  // ============ AUTHENTICATION ============

  /// Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return currentUser != null;
  }

  // ============ USER PROFILE ============

  /// Get user profile
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await client
          .from('users')
          .select()
          .eq('id', userId)
          .single();
      return response as Map<String, dynamic>?;
    } catch (e) {
      rethrow;
    }
  }

  /// Update user profile
  Future<void> updateUserProfile({
    required String userId,
    required String fullName,
    String? phone,
    String? address,
  }) async {
    try {
      await client.from('users').update({
        'full_name': fullName,
        if (phone != null) 'phone': phone,
        if (address != null) 'address': address,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', userId);
    } catch (e) {
      rethrow;
    }
  }

  // ============ PRODUCTS ============

  /// Get all products
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final response = await client
          .from('products')
          .select()
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Get products by category
  Future<List<Map<String, dynamic>>> getProductsByCategory(String category) async {
    try {
      final response = await client
          .from('products')
          .select()
          .eq('category', category)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Get single product
  Future<Map<String, dynamic>?> getProduct(int productId) async {
    try {
      final response = await client
          .from('products')
          .select()
          .eq('id', productId)
          .single();
      return response as Map<String, dynamic>?;
    } catch (e) {
      rethrow;
    }
  }

  // ============ CART ============

  /// Add item to cart
  Future<void> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      await client.from('cart_items').upsert({
        'user_id': userId,
        'product_id': productId,
        'quantity': quantity,
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Get cart items
  Future<List<Map<String, dynamic>>> getCartItems() async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      final response = await client
          .from('cart_items')
          .select('*, products(*)')
          .eq('user_id', userId);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Update cart item quantity
  Future<void> updateCartItemQuantity({
    required int productId,
    required int quantity,
  }) async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      await client
          .from('cart_items')
          .update({'quantity': quantity})
          .eq('user_id', userId)
          .eq('product_id', productId);
    } catch (e) {
      rethrow;
    }
  }

  /// Remove item from cart
  Future<void> removeFromCart(int productId) async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      await client
          .from('cart_items')
          .delete()
          .eq('user_id', userId)
          .eq('product_id', productId);
    } catch (e) {
      rethrow;
    }
  }

  /// Clear clear cart
  Future<void> clearCart() async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      await client
          .from('cart_items')
          .delete()
          .eq('user_id', userId);
    } catch (e) {
      rethrow;
    }
  }

  // ============ ORDERS ============

  /// Create order from cart
  Future<int> createOrder(double totalAmount) async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      final response = await client
          .from('orders')
          .insert({
        'user_id': userId,
        'total_amount': totalAmount,
        'status': 'pending',
      })
          .select()
          .single();

      return response['id'] as int;
    } catch (e) {
      rethrow;
    }
  }

  /// Get user orders
  Future<List<Map<String, dynamic>>> getUserOrders() async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      final response = await client
          .from('orders')
          .select('*, order_items(*, products(*))')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Update order status
  Future<void> updateOrderStatus(int orderId, String status) async {
    try {
      await client
          .from('orders')
          .update({'status': status})
          .eq('id', orderId);
    } catch (e) {
      rethrow;
    }
  }

  // ============ WISHLIST ============

  /// Add to wishlist
  Future<void> addToWishlist(int productId) async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      await client.from('wishlist').insert({
        'user_id': userId,
        'product_id': productId,
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Remove from wishlist
  Future<void> removeFromWishlist(int productId) async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      await client
          .from('wishlist')
          .delete()
          .eq('user_id', userId)
          .eq('product_id', productId);
    } catch (e) {
      rethrow;
    }
  }

  /// Get wishlist
  Future<List<Map<String, dynamic>>> getWishlist() async {
    try {
      final userId = currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      final response = await client
          .from('wishlist')
          .select('*, products(*)')
          .eq('user_id', userId);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }
}
