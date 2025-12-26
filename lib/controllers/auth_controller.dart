import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/supabase_service.dart';

class AuthController extends GetxController {
  final SupabaseService _supabaseService = SupabaseService();
  final GetStorage _storage = GetStorage();

  static const String _firstTimeKey = 'is_first_time';

  // ================= ONBOARDING =================

  bool get isFirstTime {
    return _storage.read(_firstTimeKey) ?? true;
  }

  void setFirstTimeDone() {
    _storage.write(_firstTimeKey, false);
  }

  // ================= AUTH =================
  Future<void> signup({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await _supabaseService.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
    } catch (e) {
      Get.snackbar(
        'Sign Up Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  bool get isLoggedIn {
    return _supabaseService.isLoggedIn();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _supabaseService.signIn(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _supabaseService.signOut();
    } catch (e) {
      Get.snackbar(
        'Logout Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
