import 'package:hive_ce/hive.dart';

part 'hive_adapters.hive.dart';

@GenerateAdapters(
  [
    AdapterSpec<ClassSpec1>(),
    AdapterSpec<ClassSpec2>(),
    AdapterSpec<EnumSpec>(),
  ],
  firstTypeId: 50,
)
_() {}

class ClassSpec1 {
  final int value;
  final int value2;

  ClassSpec1(this.value, this.value2);
}

class ClassSpec2 {
  final String value;
  final String value2;

  ClassSpec2(this.value, this.value2);
}

enum EnumSpec { value1, value2 }
