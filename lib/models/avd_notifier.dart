import 'dart:convert';
import 'dart:io';

import 'package:avd_manager_hermes/models/avd.dart';
import 'package:avd_manager_hermes/repository/emulator_repository.dart';
import 'package:flutter/material.dart';

class AvdNotifier extends ChangeNotifier {
  final EmulatorRepository emulator;
  Process? process;
  Avd avd;

  String stdout = "";
  String stderr = "";

  AvdNotifier(this.emulator, this.avd);

  Future<void> run() async {
    stdout = "";
    stderr = "";

    var process = await emulator.runAvd(avd);

    process.stdout.transform(utf8.decoder).forEach(writeSTDOUT);
    process.stderr.transform(utf8.decoder).forEach(writeSTDERR);

    this.process = process;
    notifyListeners();
  }

  bool stop() {
    bool result = false;
    if (process != null) {
      result = emulator.stopAvd(process!);
      // process = null;
    }
    notifyListeners();
    return result;
  }

  void writeSTDOUT(String value) {
    stdout += value;
    notifyListeners();
  }

  void writeSTDERR(String value) {
    stderr += value;
    notifyListeners();
  }
}
