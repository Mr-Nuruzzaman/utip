import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utip/providers/ThemeProvider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: Icon(
        themeProvider.isDarkMode ? Icons.sunny : Icons.nightlight_round,
        color: const Color.fromARGB(255, 209, 201, 201),
      ),
      iconSize: 30.0,
      onPressed: () {
        themeProvider.toggleTheme();
      },
    );
  }
}
