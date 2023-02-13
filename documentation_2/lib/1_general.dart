void main() {
  // *********************************  Cascade notation  *********************************
  // final addressBook = (AddressBookBuilder()
  //       ..name = 'jenny'
  //       ..email = 'jenny@example.com'
  //       ..phone = (PhoneNumberBuilder()  // nest cascades
  //             ..number = '415-555-0100'
  //             ?..label = 'home')
  //           .build())
  //     .build();
  var sb = StringBuffer();
  // sb.write('foo')..write('bar'); // Error: method 'write' isn't defined for 'void'.

  // ********************************* closures in for loop *********************************
  // Closures inside for loops capture the value of the index, avoiding a common pitfall found in JavaScrip
  var callbacks = [];
  for (var i = 0; i < 2; i++) callbacks.add(() => print(i));
  for (final c in callbacks) c();
  // 0 and then 1, as expected. In contrast, the example would print 2 and then 2 in JavaScript

  // ********************************* fall-through with continue in Switch *********************************
  var command = 'CLOSED';
  switch (command) {
    case 'CLOSED': // A case clause can have local variables, visible only inside the scope of that clause.
      // executeClosed();
      continue nowClosed; // Continues executing at the nowClosed label.
    nowClosed:
    case 'NOW_CLOSED':
      // executeNowClosed(); // Runs for both CLOSED and NOW_CLOSED.
      break;
  }

  // ********************************* Exceptions *********************************
  try {
    // ···
  } on Exception catch (e) {
    print('Exception details:\n $e');
  } catch (e, s) {
    print('Exception details:\n $e');
    print('Stack trace:\n $s');
  }

  // ******************************** compile-time constants *********************************
  // Constructing two identical compile-time constants results in a single, canonical instance
  // var a = const ImmutablePoint(1, 1);
  // var b = const ImmutablePoint(1, 1);
  // assert(identical(a, b)); // They are the same instance!

  // ********************************* unnamed no-argument superclass constructor ************************************
  var employee = Employee.fromJson({});
  print(employee); // in Person =>  in Employee => Instance of 'Employee'

  // ********************************* operators ************************************
  final v = Vector(2, 3);
  final w = Vector(2, 2);
  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}

// ********************************* unnamed no-argument superclass constructor ************************************
class Person {
  String? firstName;
  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor; so you must call super.fromJson().
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');
  }
}

// ********************************* Forward parameters ************************************
class Vector2d {
  final double x;
  final double y;
  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;
  // Forward the x and y parameters to the default super constructor like:
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);
}

// ********************************* operator declaration ************************************
class Vector {
  final int x, y;
  Vector(this.x, this.y);

  // An operator declaration is identified using the built-in identifier operator. The following
  // example defines vector addition (+), subtraction (-), and equality (==):
  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  @override
  bool operator ==(Object other) => other is Vector && x == other.x && y == other.y;
  @override
  int get hashCode => Object.hash(x, y);
}
