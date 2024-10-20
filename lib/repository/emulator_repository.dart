import 'dart:io';

import 'package:avd_manager_hermes/wrappers/emulator_wrapper.dart';
import 'package:avd_manager_hermes/models/avd.dart';
import 'package:flutter/material.dart';

class EmulatorRepository extends InheritedWidget {
  final EmulatorWrapper wrapper = EmulatorWrapper();

  EmulatorRepository({super.key, required super.child});

  Future<Process> runAvd(Avd avd) async {
    return await wrapper.runAvd(avd);
  }

  bool stopAvd(Process process) {
    return wrapper.stopAvd(process);
  }

  Future<List<Avd>> getList() async {
    return await wrapper.getList();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static EmulatorRepository of(BuildContext context) {
    final repository =
        context.dependOnInheritedWidgetOfExactType<EmulatorRepository>();
    assert(repository != null,
        "The context does not have an EmulatorRepository, make sure that EmulatorRepositroy is present in the widget tree");
    return repository!;
  }
}
