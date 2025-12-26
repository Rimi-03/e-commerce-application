import 'package:get/get.dart';
import '../services/supabase_service.dart';

class UserController extends GetxController {
  final SupabaseService _supabaseService = SupabaseService();

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
      userProfile.value = profile;
    } catch (e) {
      errorMessage.value = e.toString();
      print('[v0] Error fetching user profile: $e');
    } finally {
      isLoading.value = false;
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
      if (userId == null) throw Exception('User not logged in');

      await _supabaseService.updateUserProfile(
        userId: userId,
        fullName: fullName,
        // phone: phone,
        // address: address,
      );

      // Refresh profile after update
      await fetchUserProfile();
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to update profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Get user's display name
  String get displayName {
    return userProfile.value?['full_name'] ?? 'User';
  }

  /// Get user's email
  String get userEmail {
    return _supabaseService.currentUser?.email ?? 'No email';
  }
}
