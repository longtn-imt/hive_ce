import 'dart:convert';

import 'package:glob/glob.dart';
import 'package:build/build.dart';
import 'dart:async';

import 'package:hive_ce_generator/src/helper/helper.dart';

/// Generate the HiveRegistrar for the entire project
class RegistrarBuilder implements Builder {
  @override
  final buildExtensions = const {
    r'$lib$': ['hive/hive_registrar.g.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final uris = <String>[];
    final adapters = <String>[];
    await for (final input
        in buildStep.findAssets(Glob('**/*.hive_registrar.info'))) {
      final content = await buildStep.readAsString(input);
      final data = jsonDecode(content) as Map<String, dynamic>;
      uris.add(data['uri'] as String);
      adapters.addAll((data['adapters'] as List).cast<String>());
    }

    // Do not create the registrar if there are no adapters
    if (adapters.isEmpty) return;

    adapters.sort();
    uris.sort();

    final buffer = StringBuffer('''
// Generated by Hive CE
// Do not modify
// Check into version control

import 'package:hive_ce/hive.dart';
''');

    for (final uri in uris) {
      buffer.writeln("import '$uri';");
    }

    buffer.write('''

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
''');

    for (final adapter in adapters) {
      buffer.writeln('    registerAdapter($adapter());');
    }

    buffer.write('''
  }
}
''');

    await buildStep.writeAsString(
      buildStep.asset('lib/hive/hive_registrar.g.dart'),
      buffer.toString(),
    );
  }
}
