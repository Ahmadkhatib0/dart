import 'package:characters/characters.dart';

void main() {
  // ********************** strings **********************
  const family = ' ';
  print(family.characters.length);

  final message = StringBuffer();
  message.write('Hello');
  message.write(' my name is ');
  message.write('Ray');
  message.toString(); // "Hello my name is Ray"
  // StringBuffer This creates a mutable location in memory where you can add to the string
  // without having to create a new string for every change.

  // you can create a raw string by putting r in front of the string literal
  const rawString = r'My name \n is $name.'; // My name \n is $name.
  print('I \u2764 Dart\u0021'); // I ❤ Dart!
  // Here, you’ve used \u, followed by a four-digit hexadecimal code unit value. 2764 is the hex value
  // for the heart emoji, and 21 is the hex value for an exclamation mark. Since 21 is
  // only two digits, you pad it with extra zeros as 0021.
  // For code points with values higher than hexadecimal FFFF, you need to surround the code with curly braces:
  print('I love \u{1F3AF}'); // I love 🎯
}
