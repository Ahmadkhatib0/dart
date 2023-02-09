// Type promotion
void main1() {
  // Even though the type is still nullable, Dart can see that name can’t possibly be null because
  // you assigned it a non-null value right before you used it
  String? name;
  name = 'Ray';
  print(name.length);
}

bool isPositive(int? anInteger) {
  if (anInteger == null) {
    return false;
  }
  // FLOW ANALYSIS
  return !anInteger.isNegative;
}

void nullAwareOperators(List<String> args) {
  String? message;
  final text = message ?? 'Error';

  double? fontSize;
  fontSize ??= 20.0;
  // If fontSize is null then it will be assigned 20.0, but otherwise it retains its value.
  // The ??= operator combines the null check with the assignment

  int? age;
  print(age?.isNegative); // null , but the ?. operator prevents that code from crashing

  bool flowerIsBeautiful1 = isBeautiful('flower')!; // or
  bool flowerIsBeautiful2 = isBeautiful('flower') as bool; // or

  User? user = User();
  String? lengthString = user.name?.length.toString();

  List<int>? myList;
  int? myItem = myList?[2];
}

bool? isBeautiful(String? item) {
  if (item == 'flower')
    return true;
  else if (item == 'garbage') return false;
  return null;
}

class User {
  String? name;
  int? id;
}

// **********************  No promotion for non-local variables
bool isLong(String? text) {
  if (text == null) return false;
  return text.length > 100;
}

class TextWidget {
  String? text;
  bool isLong() {
    if (text == null) return false;
    return false;
    // return text.length > 100; // error why here is giving error?
    // The reason is that the Dart compiler can’t guarantee that other methods or subclasses won’t
    // change the value of a non-local variable before it’s used.
  }
}

// ********************************* late keyword
class User1 {
  User1(this.name) {
    _secretNumber = _calculateSecret();
    // Initializing a final variable in the constructor body wouldn’t have been allowed if it weren’t marked as late
  }
  final String name;
  late final int _secretNumber;
  int _calculateSecret() {
    return name.length + 42;
  }
}

class SomeClass {
  late String? value = doHeavyCalculation();
  String? doHeavyCalculation() {}
  // The method doHeavyCalculation is only run after you access value the first time.
  // And if you never access it, you never do the work
}

// The big problem with the old nullable types in the past was
// how easy it was to forget to add code to handle null values.

// Note: The non-nullable type is a subtype of its nullable form. For example,
// String is a subtype of String? since String? can be a String.

// Null-aware operators
// If-null operator (??)
// Null-aware assignment operator (??=)
// Null-aware access operator (?.)
// Null-aware method invocation operator (?.)
// Null assertion operator (!)
// Null-aware cascade operator (?..)
// Null-aware index operator (?[])
// Null-aware spread operator (...?)

// Internally, a property is just a getter method on an object, so the ?. operator works the  same way to call
// methods as it does to access properties. another name for ?. is the null-aware method invocation operator.
// The null-aware index operator (?[]) is used for accessing
// the elements of a list when the list itself might be null
