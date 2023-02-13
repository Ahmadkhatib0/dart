// import 'package:lib2/lib2.dart' hide foo; Import all names EXCEPT foo.
// import 'package:greetings/hello.dart' deferred as hello; // lazily imported

void main() async {
  // await hello.loadLibrary(); then  hello.printGreeting(); // to use that lazily library

  // ********************************* generator function *********************************
  naturalsTo(5).forEach((element) => print(element));

  // Callable classes
  var wf = WannabeFunction();
  var out = wf('Hi', 'there,', 'gang');
  print(out); // Hi there, gang!

  // ********************************* typedef *********************************
  int sort(int a, int b) => a - b;
  assert(sort is Compare<int>); // True!
}

// ********************************* generator function *********************************
// (When you need to lazily produce a sequence of values)
// Generators  (Synchronous returns Iterable & Asynchronous return Stream )
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}

Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}

Iterable<int> naturalsDownFrom(int n) sync* {
  // If your generator is recursive, you can improve its performance by using yield*:
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}

// ********************************* Callable classes  *********************************
class WannabeFunction {
  // The call() method allows any class that defines it to emulate a function
  String call(String a, String b, String c) => '$a $b $c!';
}

// ********************************* typedef  *********************************
typedef ListMapper<X> = Map<X, List<X>>; // A type alias can have type parameters:
Map<String, List<String>> m1 = {}; // Verbose.
ListMapper<String> m2 = {}; // Same thing but shorter and clearer.

typedef Compare<T> = int Function(T a, T b); // function typedef

// ********************************* custom metadata  *********************************
// Metadata can appear before a library, class, typedef, type parameter, constructor,
// factory, function, field, parameter, or variable declaration and before an import
// or export directive.  You can retrieve metadata at runtime using reflection.
class Todo {
  final String who;
  final String what;
  const Todo(this.who, this.what);
}

@Todo('Dash', 'Implement this function')
void doSomething() {
  print('Do something');
}

// ********************************* Implementing generic extensions  *********************************
extension MyFancyList<T> on List<T> {
  int get doubleLength => length * 2;
  List<T> operator -() => reversed.toList();
  List<List<T>> split(int at) => [sublist(0, at), sublist(at)];
}

// ********************************* lazily imported *********************************
// 1- A deferred library’s constants aren’t constants in the importing file.
// Remember, these constants don’t exist until the deferred library is loaded.
// 2- You can’t use types from a deferred library in the importing file. Instead, consider moving
// interface types to a library imported by both the deferred library and the importing file.
// 3- Dart implicitly inserts loadLibrary() into the namespace that you define using
// deferred as namespace. The loadLibrary() function returns a Future.
