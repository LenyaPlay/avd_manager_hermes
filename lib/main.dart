import 'package:avd_manager_hermes/repository/emulator_repository.dart';
import 'package:avd_manager_hermes/widgets/avd_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return EmulatorRepository(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.amber,
            onPrimary: Colors.white,
            secondary: Colors.teal,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            surface: Colors.white.withOpacity(0.2),
            onSurface: Colors.white,
          ),
        ),
        home: const Scaffold(
          body: AvdList(),
        ),
      ),
    );
  }
}
