import 'package:ecommerce_app/controllers/user_controller.dart';
import 'package:ecommerce_app/view/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_textstyles.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  late UserController userController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with empty values first
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();

    // Get the controller instance
    userController = Get.find<UserController>();

    // Load data
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    // Make sure profile is loaded
    if (userController.userProfile.value == null) {
      await userController.fetchUserProfile();
    }

    // Set form data
    final profile = userController.userProfile.value;
    fullNameController.text = profile?['full_name'] ?? '';
    emailController.text = userController.userEmail;
    phoneController.text = profile?['phone']?.toString() ?? '';
    addressController.text = profile?['address']?.toString() ?? '';

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Full Name
          _buildTextField(
            controller: fullNameController,
            label: 'Full Name',
            prefixIcon: Icons.person_outline,
            isDark: isDark,
          ),

          const SizedBox(height: 16),

          // Email (read-only)
          _buildTextField(
            controller: emailController,
            label: 'Email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            readOnly: true,
            isDark: isDark,
          ),

          const SizedBox(height: 16),

          // Phone
          _buildTextField(
            controller: phoneController,
            label: 'Phone Number',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            isDark: isDark,
          ),

          const SizedBox(height: 16),

          // Address (multiline)
          _buildTextField(
            controller: addressController,
            label: 'Address',
            prefixIcon: Icons.location_on_outlined,
            maxLines: 2,
            isDark: isDark,
          ),

          const SizedBox(height: 32),

          // Save Changes Button
          Obx(
                () => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: userController.isLoading.value
                    ? null
                    : () => _saveChanges(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  userController.isLoading.value
                      ? 'Saving...'
                      : 'Save Changes',
                  style: AppTextStyle.withColor(
                    AppTextStyle.buttonMedium,
                    Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveChanges() async {
    try {
      // Trim the input values
      final fullName = fullNameController.text.trim();
      final phone = phoneController.text.trim();
      final address = addressController.text.trim();

      // Validate full name (required)
      if (fullName.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Full name is required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Call the update method
      await userController.updateUserProfile(
        fullName: fullName,
        phone: phone.isNotEmpty ? phone : null,
        address: address.isNotEmpty ? address : null,
      );

      // Navigate back only if save was successful
      if (!userController.isLoading.value) {
        Get.back();
      }
    } catch (e) {
      // Show error snackbar directly here as a fallback
      Get.snackbar(
        'Error',
        'Failed to save changes: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    int maxLines = 1,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CustomTextfield(
        controller: controller,
        label: label,
        prefixIcon: prefixIcon,
        keyboardType: keyboardType,
        readOnly: readOnly,
        maxLines: maxLines,
      ),
    );
  }
}