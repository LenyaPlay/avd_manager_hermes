import 'package:avd_manager_hermes/models/avd_notifier.dart';
import 'package:flutter/material.dart';

class AvdLogs extends StatefulWidget {
  final AvdNotifier avdNotifier;

  const AvdLogs({super.key, required this.avdNotifier});

  @override
  State<AvdLogs> createState() => _AvdLogsState();
}

class _AvdLogsState extends State<AvdLogs> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
