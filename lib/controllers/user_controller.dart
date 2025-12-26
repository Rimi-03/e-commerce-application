import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';

class UserController extends GetxController {
  final SupabaseService _supabaseService = SupabaseService();
  final SupabaseClient _client = Supabase.instance.client;

  final Rxn<Map<String, dynamic>> userProfile = Rxn<Map<String, dynamic>>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  /// Fetch current user profile from database
  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final userId = _supabaseService.currentUser?.id;
      if (userId == null) {
        errorMessage.value = 'User not logged in';
        return;
      }

      final profile = await _supabaseService.getUserProfile(userId);

      // If profile doesn't exist, create one
      if (profile == null) {
        await _createUserProfile(userId);
        // Fetch again after creation
        userProfile.value = await _supabaseService.getUserProfile(userId);
      } else {
        userProfile.value = profile;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print('[UserController] Error fetching user profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Create a user profile if it doesn't exist
  Future<void> _createUserProfile(String userId) async {
    try {
      final user = _supabaseService.currentUser;
      if (user == null) return;

      // Create a basic profile
      await _client.from('users').upsert({
        'id': userId,
        'email': user.email,
        'full_name': user.userMetadata?['full_name'] ??
            user.email?.split('@').first ??
            'User',
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('[UserController] Error creating user profile: $e');
    }
  }

  /// Update user profile
  Future<void> updateUserProfile({
    required String fullName,
    String? phone,
    String? address,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final userId = _supabaseService.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in');
      }

      // Prepare update data
      final updateData = <String, dynamic>{
        'full_name': fullName.trim(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Only include phone if provided (not empty)
      if (phone != null && phone.trim().isNotEmpty) {
        updateData['phone'] = phone.trim();
      } else {
        // Set to null if empty string is passed
        updateData['phone'] = null;
      }

      // Only include address if provided (not empty)
      if (address != null && address.trim().isNotEmpty) {
        updateData['address'] = address.trim();
      } else {
        // Set to null if empty string is passed
        updateData['address'] = null;
      }

      // Update profile in database
      await _client
          .from('users')
          .update(updateData)
          .eq('id', userId);

      // Update local profile data immediately
      userProfile.value = {
        ...?userProfile.value,
        ...updateData,
      };

      // Force UI update
      update();

      // Use a delayed approach to ensure context is available
      Future.delayed(Duration.zero, () {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }

        Get.showSnackbar(
          GetSnackBar(
            message: 'Profile updated successfully',
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
          ),
        );
      });

    } catch (e) {
      errorMessage.value = e.toString();

      // Use a delayed approach to ensure context is available
      Future.delayed(Duration.zero, () {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }

        Get.showSnackbar(
          GetSnackBar(
            message: 'Failed to update profile: ${e.toString()}',
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
          ),
        );
      });

      rethrow; // Re-throw so calling code knows it failed
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  /// Force refresh profile data
  Future<void> refreshProfile() async {
    userProfile.value = null;
    await fetchUserProfile();
  }

  /// Get user's display name (with fallback)
  String get displayName {
    if (userProfile.value != null && userProfile.value!['full_name'] != null) {
      return userProfile.value!['full_name'];
    }

    final user = _supabaseService.currentUser;
    if (user != null) {
      return user.userMetadata?['full_name'] ??
          user.email?.split('@').first ??
          'User';
    }

    return 'User';
  }

  /// Get user's email (with fallback)
  String get userEmail {
    return _supabaseService.currentUser?.email ?? 'No email';
  }

  /// Get user's phone number
  String? get phoneNumber {
    return userProfile.value?['phone'];
  }

  /// Get user's address
  String? get address {
    return userProfile.value?['address'];
  }

  /// Check if user has a complete profile
  bool get hasCompleteProfile {
    final profile = userProfile.value;
    if (profile == null) return false;

    return profile['full_name'] != null &&
        profile['full_name'].toString().isNotEmpty;
  }

  /// Get the complete user profile data
  Map<String, dynamic>? get profileData {
    return userProfile.value;
  }
}