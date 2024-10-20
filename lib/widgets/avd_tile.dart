import 'package:avd_manager_hermes/models/avd_notifier.dart';
import 'package:avd_manager_hermes/repository/emulator_repository.dart';
import 'package:flutter/material.dart';

class AvdTile extends StatefulWidget {
  final AvdNotifier avdNotifier;

  const AvdTile({super.key, required this.avdNotifier});

  @override
  State<AvdTile> createState() => _AvdTileState();
}

class _AvdTileState extends State<AvdTile> {
  EmulatorRepository get emulatorRepository => EmulatorRepository.of(context);

  void run() async {
    widget.avdNotifier.run();
  }

  void stop() async {
    widget.avdNotifier.stop();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.avdNotifier.avd.name),
          Row(
            children: [
              IconButton.outlined(
                color: Colors.green[500],
                onPressed: run,
                icon: const Icon(Icons.play_arrow),
              ),
              const SizedBox(width: 10),
              IconButton.outlined(
                color: Colors.red[500],
                onPressed: stop,
                icon: const Icon(Icons.stop),
              ),
            ],
          )
        ],
      ),
      children: [
        ListTile(
          title: SelectableText(widget.avdNotifier.avd.toString()),
        ),
      ],
    );
  }
}
