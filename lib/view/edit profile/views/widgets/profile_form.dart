import 'package:ecommerce_app/controllers/auth_controller.dart';
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
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final authController = Get.find<AuthController>();
    _nameController.text = authController.userName ?? '';
    _emailController.text = authController.userEmail ?? '';
    _phoneController.text = authController.userPhone ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withAlpha(50)
                        : Colors.black.withAlpha(25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CustomTextfield(
                label: 'Full Name',
                prefixIcon: Icons.person_outline,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Your Full Name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be contain at least 2 character';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withAlpha(50)
                        : Colors.black.withAlpha(25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CustomTextfield(
                label: 'Email',
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Your Email Address';
                  }
                  if (!GetUtils.isEmail(value.trim())) {
                    return 'Please Enter a Valid Email Address';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withAlpha(50)
                        : Colors.black.withAlpha(25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CustomTextfield(
                label: 'Phone Number',
                prefixIcon: Icons.phone_outlined,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    if (value.trim().length < 2) {
                      return 'Please Enter a Valid Phone Number';
                    }
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Save Changes',
                        style: AppTextStyle.withColor(
                          AppTextStyle.buttonMedium,
                          Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //save the changes
  Future<void> _saveProfile() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authController = Get.find<AuthController>();

      //check if user is authenticated
      if (authController.user == null) {
        Get.snackbar(
          'Error',
          'Please sign in to update your profile',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      //Get current values
      final currentName = authController.userName ?? '';
      final currentEmail = authController.userEmail ?? '';
      final currentPhone = authController.userPhone ?? '';

      //Get new values
      final newName = _nameController.text.trim();
      final newEmail = _emailController.text.trim();
      final newPhone = _phoneController.text.trim();

      //check if data is changed
      if (newName == currentName &&
          newEmail == currentEmail &&
          newPhone == currentPhone) {
        Get.snackbar(
          'No Changes',
          'No change were made to your profile',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        return;
      }
      //update profile
      final success = await authController.updateUserProfile(
        name: newName.isNotEmpty ? newName : null,
        phoneNumber: newPhone.isNotEmpty ? newPhone : null,
      );

      if (success) {
        Get.snackbar(
          'Success',
          'Profile Updated Successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        //Wait for snackbar to be visible before navigating back
        await Future.delayed(const Duration(milliseconds: 1000));
        if (mounted) {
          Get.back();
        } else {
          Get.snackbar(
            'Error',
            'Failed to update profile.please try again later.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occured.please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
