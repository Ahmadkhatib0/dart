abstract class JsonData {
  bool containsString<T>(T text);
}

class JsonValue<T> extends JsonData {
  JsonValue(this.value);
  final T value;
  @override
  bool containsString<U>(U text) => text == value;
}

class JsonList extends JsonData {
  JsonList(List<JsonData> elements) : _elements = elements;
  final List<JsonData> _elements;

  int get length => _elements.length;
  JsonData operator [](int index) => _elements[index];

  @override
  bool containsString<T>(T text) {
    for (var element in _elements) {
      if (element.containsString(text)) return true;
    }
    return false;
  }
}

class JsonMap<T> extends JsonData {
  JsonMap(Map<T, JsonData> map) : _map = map;
  final Map<T, JsonData> _map;

  Iterable get keys => _map.keys;
  JsonData operator [](String key) => _map[key] ?? (throw ArgumentError.value(key, "key", "No entry"));

  @override
  bool containsString<U>(U text) {
    for (var entry in _map.entries) {
      if (text == entry.key || entry.value.containsString(text)) {
        return true;
      }
    }
    return false;
  }
}

void main() {
  var map = JsonMap({
    "first": JsonList([JsonValue(1), JsonValue("ok")]),
    "second": JsonValue(false),
  });
  var list = JsonList([JsonValue(1), JsonValue("ok")]);

  print(map.containsString<String>('firs')); // false
  print(list.containsString('ok'));
}
