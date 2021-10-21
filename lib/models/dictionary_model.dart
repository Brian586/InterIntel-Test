class DictionaryItem {
  final String? key;
  final String? value;

  DictionaryItem({this.key, this.value});

  factory DictionaryItem.fromJson(MapEntry<String, String> map)
  {
    return DictionaryItem(
      key: map.key.toString(),
      value: map.value.toString(),
    );
  }
}