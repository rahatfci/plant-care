import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/constants.dart';
import 'package:plant_watch/screens/cart/cart_screen.dart';
import 'package:plant_watch/screens/categories/categories_screen.dart';
import 'package:plant_watch/screens/categories_admin/categories_admin_screen.dart';
import 'package:plant_watch/screens/home/home_screen.dart';
import 'package:plant_watch/screens/login_sign_up/sign_up_screen.dart';
import 'package:plant_watch/screens/products_admin/products_admin_screen.dart';
import 'package:plant_watch/screens/settings/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tree Plant',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: kTextColor, fontFamily: 'Poppins'),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      routes: {
        '/': (context) => FirebaseAuth.instance.currentUser == null
            ? const SignUpScreen()
            : const HomeScreen(),
        '/categories': (context) => const CategoriesScreen(),
        '/cart': (context) => CartScreen(),
        '/settings': (context) => SettingsScreen(),
        '/categories_admin': (context) => const CategoriesAdminScreen(),
        '/products_admin': (context) => const ProductsAdminScreen(),
      },
    );
  }
}
