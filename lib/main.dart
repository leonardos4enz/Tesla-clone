import 'package:flutter/material.dart';
import 'package:saenz/screens/explore_screen.dart';
// ignore: unused_import
import 'package:saenz/screens/start_screen.dart';
// ignore: unused_import
import 'package:saenz/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  int value = (prefs.getInt('firstTime') ?? 1);
  print(value);
  runApp(MyApp(value));
}

class MyApp extends StatelessWidget {
  final int firstTime;
  const MyApp(this.firstTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saenz',
      home: SafeArea(child: firstTime == 1 ? const StartScreen() : const ExploreScreen()),
    );
  }
}

//flutter run -d chrome --no-sound-null-safety --web-renderer=html

