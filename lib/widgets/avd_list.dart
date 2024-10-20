import 'package:avd_manager_hermes/models/avd_notifier.dart';
import 'package:avd_manager_hermes/repository/emulator_repository.dart';
import 'package:avd_manager_hermes/widgets/avd_tile.dart';
import 'package:flutter/material.dart';

class AvdList extends StatefulWidget {
  const AvdList({super.key});

  @override
  State<AvdList> createState() => _AvdListState();
}

class _AvdListState extends State<AvdList> {
  EmulatorRepository get emulatorRepository => EmulatorRepository.of(context);
  var avdNotifiers = <AvdNotifier>[];
  AvdNotifier? selectedAvd;

  Future<void> load() async {
    var avds = await emulatorRepository.getList();
    avdNotifiers =
        (avds).map((avd) => AvdNotifier(emulatorRepository, avd)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: load,
          child: const Text('List'),
        ),
        ...avdNotifiers.map((e) => AvdTile(avdNotifier: e)),
        Expanded(
          child: DefaultTabController(
            length: avdNotifiers.length,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    ...avdNotifiers.map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const Icon(Icons.phone_android),
                            const SizedBox(width: 10),
                            Text(avdNotifiers.first.avd.name),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ...avdNotifiers.map(
                        (e) => SingleChildScrollView(
                          reverse: true,
                          child: ListenableBuilder(
                            listenable: e,
                            builder: (BuildContext context, Widget? child) {
                              return Text(e.stdout);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
