import 'package:flutter/material.dart';
import 'package:saenz/screens/account_screen.dart';
import 'package:saenz/screens/help_screen.dart';
import 'package:saenz/screens/inbox_screen.dart';
import 'package:saenz/screens/products_screen.dart';
import 'package:saenz/screens/settings_screen.dart';

List<Map<String, dynamic>> menuData = [
  {'id': 0, 'icon': Icons.inbox_rounded, 'title': 'Bandeja de entrada', 'route': const InboxScreen()},
  {'id': 1, 'icon': Icons.person, 'title': 'Cuenta', 'route': const AccountScreen()},
  {'id': 2, 'icon': Icons.settings, 'title': 'Ajustes', 'route': const SettingsScreen()},
  {'id': 3, 'icon': Icons.car_repair, 'title': 'Añadir/eliminar productos', 'route': const ProductsScreen()},
  {'id': 4, 'icon': Icons.help, 'title': 'Ayuda', 'route': const HelpScreen()},
  {'id': 5, 'icon': Icons.exit_to_app, 'title': 'Cerrar sesión', 'route': const InboxScreen()},
];
