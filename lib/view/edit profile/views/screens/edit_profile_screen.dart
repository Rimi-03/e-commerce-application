import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/user_controller.dart';
import '../../../../utils/app_textstyles.dart';
import '../widgets/profile_form.dart';
import '../widgets/profile_image.dart';


class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Make sure UserController is initialized
    final UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Edit Profile',
          style: AppTextStyle.withColor(
            AppTextStyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        // Show loading if fetching profile
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error if any
        if (userController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              userController.errorMessage.value,
              style: AppTextStyle.bodyMedium,
            ),
          );
        }

        return const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              ProfileImage(),
              SizedBox(height: 32),
              ProfileForm(),
            ],
          ),
        );
      }),
    );
  }
}
