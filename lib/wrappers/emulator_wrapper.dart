import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:avd_manager_hermes/environment.dart';
import 'package:avd_manager_hermes/models/avd.dart';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class EmulatorWrapper {
  static const skipStarts = [
    'INFO    |',
    'ERROR   |',
  ];

  String get defaultExecutable => androidHome + r'\emulator\emulator.exe';

  String get executable => defaultExecutable;

  /// If messages begin with them, then these are some kind of logs (including error logs)

  Future<Process> runAvd(Avd avd) async {
    var process = await Process.start(executable, ['-avd', avd.name]);
    return process;
  }

  bool stopAvd(Process process) {
    if (Platform.isWindows) {
      getAllWindowsFromProcessID(process.pid);
      return false;
    }

    return process.kill();
  }

  void getAllWindowsFromProcessID(int dwProcessID) {
    List<int> vhWnds = [];

    int enumWindowsCallback(int hWnd, int lParam) {
      final dwProcID = calloc<Uint32>();
      GetWindowThreadProcessId(hWnd, dwProcID);
      if (dwProcID.value == dwProcessID) {
        vhWnds.add(hWnd);
      }
      free(dwProcID);
      return 1; // Возвращаем 1, чтобы продолжить перечисление окон
    }

    final x = NativeCallable<WNDENUMPROC>.isolateLocal(
      enumWindowsCallback,
      exceptionalReturn: 0,
    );

    EnumWindows(x.nativeFunction, 0);
  }

  Future<List<Avd>> getList() async {
    var process = await Process.start(executable, ['-list-avds']);

    String data = "";
    String error = "";

    await Future.wait([
      process.stdout
          .transform(utf8.decoder)
          .join()
          .then((value) => data = value),
      process.stderr
          .transform(utf8.decoder)
          .join()
          .then((value) => error = value),
    ]);

    if (error.isNotEmpty) {
      throw Exception(error);
    }

    bool goodStart(String line) =>
        !skipStarts.any((start) => line.startsWith(start));

    var names = data
        .split(Platform.lineTerminator)
        .where(goodStart)
        .where((element) => element.isNotEmpty);

    return names.map(Avd.fromName).toList();
  }
}
