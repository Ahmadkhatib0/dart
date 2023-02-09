// ********************************************
void main(List<String> args) {
  print(withinTolerance1(4, 1, 10));
  print(withinTolerance2(44, min: 3, max: 33));
  print(withinTolerance3(value: 55, min: 3));

// ******************************************** Closures

  final counter1 = countingFunction();
  final counter2 = countingFunction();
  print(counter1()); // 1
  print(counter2()); // 1
  print(counter1()); // 2
  print(counter1()); // 3
  print(counter2()); // 2
}

bool withinTolerance1(int value, [int min = 0, int max = 10]) {
  return min <= value && value <= max;
}

bool withinTolerance2(int value, {int min = 0, int max = 10}) {
  return min <= value && value <= max;
}

bool withinTolerance3({required int value, int min = 0, int max = 10}) {
  return min <= value && value <= max;
}

// Writing good functions
// 1- Avoiding side effects (anything that affects the world outside of the function, is a side effect)
void hello() {
  print('Hello!');
} // side affect  // also

var myPreciousData = 5782;
String anInnocentLookingFunction(String name) {
  myPreciousData = -1;
  return 'Hello, $name. Heh, heh, heh.';
} // side affect

String hello1() {
  return 'Hello!';
} // PURE FUNCTIONS

// 2- Doing only one thing  (Single Responsibility Principle)

// Choosing good names
// A - Use noun phrases for pure functions; that is, ones without side effects. For example, use
//  averageTemperature instead of getAverageTemperature and studentNames instead of extractStudentNames.
// B - Use verb phrases for functions with side effects. For example, updateDatabase or printHello.
// C - Also use verb phases if you want to emphasize that the function does a lot of work.
//  For example calculateFibonacci or parseJson
// D - Don’t repeat parameter names in the function name.  For example, use cube(int number) instead of
//  cubeNumber(int number), or printStudent(String name) instead of printStudentName(String name) .

//  Functions that return functions, or that accept them as parameters, are called higher order functions
Function countingFunction() {
  var counter = 0;
  final incrementCounter = () {
    counter += 1;
    return counter;
  };
  return incrementCounter;
}
