import 'dart:convert';
import 'dart:io';

import 'package:avd_manager_hermes/models/avd.dart';

class AvdWrapper {
  Future<List<Avd>> getList() async {
    var process = await Process.start(
      r'C:\Users\lenyaplay\AppData\Local\Android\Sdk\cmdline-tools\latest\bin\avdmanager.bat',
      ['list', 'avd'],
    );

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

    List<String> avdList = data.split(Platform.lineTerminator).skip(1).toList();

    var avds = <Map<String, String>>[];
    var avd = <String, String>{};
    for (String line in avdList) {
      if (line.isEmpty) continue;
      if (line == '---------') {
        avds.add(avd);
        avd = {};
        continue;
      }
      var [key, ...value] = line.split(':');
      avd[key.trim()] = value.join().trim();
    }
    avds.add(avd);

    return avds.map((e) => Avd(map: e)).toList();
  }
}
