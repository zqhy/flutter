
class KeyValue<K, V> {
  final K key;
  final V? value;

  const KeyValue(this.key, this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyValue &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          value == other.value;

  @override
  int get hashCode => key.hashCode ^ value.hashCode;

  KeyValue.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        value = json['value'];

  Map<String, dynamic> toJson() =>
      {
        'key': key,
        'value': value,
      };
}