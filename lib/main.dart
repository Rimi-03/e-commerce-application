import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/controllers/navigation_controller.dart';
import 'package:ecommerce_app/controllers/theme_controller.dart';
import 'package:ecommerce_app/utils/app_themes.dart';
import 'package:ecommerce_app/view/splash_screen.dart';
import 'package:ecommerce_app/view/test_supabase_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://zeiypjermcgnwrplchkj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InplaXlwamVybWNnbndycGxjaGtqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY2NjcxMjQsImV4cCI6MjA4MjI0MzEyNH0.i3YxNkm-oBuZzFsV-CRB4w3cjoIEb__Jd5xNbyyUh38',
  );

  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(AuthController());
  Get.put(NavigationController());

  // _testSupabaseConnection();

  runApp(const MyApp());
}

// void _testSupabaseConnection() {
//   try {
//     final client = Supabase.instance.client;
//     print('[v0] Supabase initialized successfully!');
//     // print('[v0] Supabase URL: ${client.supabaseUrl}');
//     print('[v0] Ready to use Supabase API');
//   } catch (e) {
//     print('[v0] ERROR: Supabase initialization failed: $e');
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion Store',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: themeController.theme,
      defaultTransition: Transition.fade,
      home: SplashScreen(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}