import 'dart:convert';
import 'dart:async';
import "dart:io";
import 'dart:isolate';

void main() async {
  // final jsonData = await Isolate.run(_readAndParseJson); // you can send closures also instead
  // print('Number of JSON keys: ${jsonData.length}');

  var file = File("assets/text_long.txt");
  var lines = utf8.decoder.bind(file.openRead()).transform(const LineSplitter());
  await for (final line in lines) {
    if (!line.startsWith('#')) print(line);
  }
}

Future<Map<String, dynamic>> _readAndParseJson(String filename) async {
  final fileData = await File(filename).readAsString();
  final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
  return jsonData;
}
