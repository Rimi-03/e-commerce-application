import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/utils/app_textstyles.dart';
import 'package:ecommerce_app/view/main_screen.dart';
import 'package:ecommerce_app/view/signup_screen.dart';
import 'package:ecommerce_app/view/widgets/custom_textfield.dart' show CustomTextfield;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/view/forgot_password_screen.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text(
                'Welcome Back!',
                style: AppTextStyle.withColor(AppTextStyle.h1, Theme.of(context).textTheme.bodyLarge!.color!)
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue shopping',
                style: AppTextStyle.withColor(
                  AppTextStyle.bodyLarge, 
                  isDark 
                    ? Colors.grey.shade400 
                    : Colors.grey.shade600
                ),
              ),
              const SizedBox(height: 40),
              //email field
              CustomTextfield(
                label: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              //password field
              CustomTextfield(
                label: 'Password',
                prefixIcon: Icons.lock_outline,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 8),
              //forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.to(() => ForgotPasswordScreen()),
                  
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyle.withColor(
                      AppTextStyle.bodyMedium,
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: AppTextStyle.withColor(
                      AppTextStyle.bodyMedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              //sign up textButton 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: AppTextStyle.withColor(
                      AppTextStyle.bodyMedium,
                      isDark 
                        ? Colors.grey.shade400 
                        : Colors.grey.shade600,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => SignUpScreen(),),
                    
                    child: Text(
                      'Sign Up',
                      style: AppTextStyle.withColor(
                        AppTextStyle.bodyMedium,
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ]
              )
            ],
          ),
        )
        ),
    );
  }

  // sign in button onpressed
  void _handleSignIn() {
    final AuthController authController = Get.find<AuthController>();
    authController.login();
    Get.offAll(() => const MainScreen());
  }

}