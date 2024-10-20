class Avd {
  final Map<String, String> _map;

  Avd({required Map<String, String> map}) : _map = map;

  Avd.fromName(String name) : _map = {'Name': name};

  @override
  String toString() {
    return _map.entries.map((e) => "${e.key}: ${e.value}").join("\n");
  }

  String get name => _map["Name"]!;
}
