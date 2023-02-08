import 'dart:math';

void main() {
  // ********************** do while **********************
  var sum = 1;
  do {
    sum += 4;
    print(sum);
  } while (sum < 10);

  sum = 11;
  do {
    sum += 4;
  } while (sum < 10);
  print(sum);
  // the sum at the end will be 15. This is because the do-while loop
  // executed the body of the loop before checking the condition
  final random = Random();
  while (random.nextInt(6) + 1 != 6) {
    print('not a six');
  }
  print('Finally, you got a six!');

  // ********************** for **********************
  for (var i = 0; i < 5; i++) {
    if (i == 2) {
      continue;
    }
    print(i);
  }

  const myString = 'I ❤ Dart';
  for (var point in myString.runes) {
    print(String.fromCharCode(point));
  }
}
