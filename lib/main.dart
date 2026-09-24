import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'leaderboard_screen.dart';
import 'collection_screen.dart'; // Import halaman koleksi

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bacain App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F4EB),
        fontFamily: 'Roboto', 
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
        '/collection': (context) => const CollectionScreen(), // Rute koleksi ditambahkan
      },
    );
  }
}