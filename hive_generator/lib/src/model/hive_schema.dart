import 'package:json_annotation/json_annotation.dart';

part 'hive_schema.g.dart';

/// Information about Hive adapters used to support incremental changes
@JsonSerializable()
class HiveSchema {
  /// The next type ID to use for future updates
  final int nextTypeId;

  /// The adapter types
  final Map<String, HiveSchemaType> types;

  /// Constructor
  const HiveSchema({required this.nextTypeId, required this.types});

  /// From json
  factory HiveSchema.fromJson(Map<String, dynamic> json) =>
      _$HiveSchemaFromJson(json);

  /// To json
  Map<String, dynamic> toJson() => _$HiveSchemaToJson(this);
}

/// Information about a Hive adapter type
@JsonSerializable()
class HiveSchemaType {
  /// The adapter's type ID
  final int typeId;

  /// The next field index to use for future updates
  final int nextIndex;

  /// The fields in the adapter
  final Map<String, HiveSchemaField> fields;

  /// Constructor
  const HiveSchemaType({
    required this.typeId,
    required this.nextIndex,
    required this.fields,
  });

  /// From json
  factory HiveSchemaType.fromJson(Map<String, dynamic> json) =>
      _$HiveSchemaTypeFromJson(json);

  /// To json
  Map<String, dynamic> toJson() => _$HiveSchemaTypeToJson(this);

  /// Copy with
  HiveSchemaType copyWith({
    int? typeId,
    int? nextIndex,
    Map<String, HiveSchemaField>? fields,
  }) {
    return HiveSchemaType(
      typeId: typeId ?? this.typeId,
      nextIndex: nextIndex ?? this.nextIndex,
      fields: fields ?? this.fields,
    );
  }
}

/// Information about a Hive adapter field
@JsonSerializable()
class HiveSchemaField {
  /// The field index
  final int index;

  /// Constructor
  const HiveSchemaField({required this.index});

  /// From json
  factory HiveSchemaField.fromJson(Map<String, dynamic> json) =>
      _$HiveSchemaFieldFromJson(json);

  /// To json
  Map<String, dynamic> toJson() => _$HiveSchemaFieldToJson(this);
}
