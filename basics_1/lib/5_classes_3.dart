// Note: Although there is no named top type in Dart, since all non-nullable Dart types derive from
// the Object type and Object itself is a subtype of the nullable Object? type, Object?
// can be considered in practice to be the root of the type system.

enum Grade { A, B, C, D, F }

class Person {
  Person(this.givenName, this.surname);
  String givenName;
  String surname;
  String get fullName => '$givenName $surname';
  @override
  String toString() => fullName;
}

class Student extends Person {
  Student(String givenName, String surname) : super(givenName, surname);
  var grades = <Grade>[];

  @override //Overriding parent method
  String get fullName => '$surname, $givenName';
}

// Calling super from an overridden method
// sometimes you override methods of the parent class because you want to add functionality, rather than replace it
class SomeParent {
  void doSomeWork() {
    print('parent working');
  }
}

class SomeChild extends SomeParent {
  @override
  void doSomeWork() {
    super.doSomeWork();
    print('child doing some other work');
  }
}

// Sibling classes
class SchoolBandMember extends Student {
  SchoolBandMember(String givenName, String surname) : super(givenName, surname);
  static const minimumPracticeTime = 2;
}

class StudentAthlete extends Student {
  StudentAthlete(String givenName, String surname) : super(givenName, surname);
  bool get isEligible => grades.every((grade) => grade != Grade.F);
}

// composition
abstract class Animal {
  bool isAlive = true;
  void eat();
  void move();
  @override
  String toString() => "I'm a $runtimeType";
}

class Platypus extends Animal {
  @override
  void eat() {
    print('Munch munch');
  }

  @override
  void move() {
    print('Glide glide');
  }

  void layEggs() {
    print('Plop plop');
  }
}

abstract class DataRepository {
  factory DataRepository() => FakeWebServer();
  double? fetchTemperature(String city);
}

class FakeWebServer implements DataRepository {
  @override
  double? fetchTemperature(String city) {
    return 42.0;
  }
}

// *********************************  mixins
abstract class Bird {
  void fly();
  void layEggs();
}

mixin EggLayer {
  void layEggs() {
    print('Plop plop');
  }
}

mixin Flyer {
  void fly() {
    print('Swoosh swoosh');
  }
}

class Robin extends Bird with EggLayer, Flyer {}

class Platypus1 extends Animal with EggLayer {
  @override
  void eat() {
    print('Munch munch');
  }

  @override
  void move() {
    print('Glide glide');
  }
}

// *********************************  extensions *********************************
extension on String {
  String get encoded {
    return _code(1);
  }

  String get decoded {
    return _code(-1);
  }

  String _code(int step) {
    final output = StringBuffer();
    for (final codePoint in runes) {
      output.writeCharCode(codePoint + step);
    }
    return output.toString();
  }
}

enum ProgrammingLanguage { dart, swift, javaScript }

extension on ProgrammingLanguage {
  bool get isStronglyTyped {
    switch (this) {
      case ProgrammingLanguage.dart:
      case ProgrammingLanguage.swift:
        return true;
      case ProgrammingLanguage.javaScript:
        return false;
      default:
        throw Exception('Unknown Programming Language $this');
    }
  }
}

void main() {
  final jon = Person('Jon', 'Snow');
  final jane = Student('Jane', 'Snow');
  print(jon.fullName);
  print(jane.fullName);
  jane.grades.add(Grade.B);

  final child = SomeChild();
  child.doSomeWork(); // parent working \n child doing some other work

  final jessie = SchoolBandMember('Jessie', 'Jones');
  final marty = StudentAthlete('Marty', 'McFly');
  final students = [jane, jessie, marty]; // Dart has inferred the type of the list to be List<Student>.

  // composition
  // final platypus = Platypus();
  Animal platypus = Platypus();
  print(platypus); // I'am a Platypus
  // So at compile time, Dart treats platypus like an Animal even though at runtime Dart knows it’s a Platypus.
  // This is useful when you don’t care about about the concrete implementation of an abstract class, but you
  // only care that it’s an Animal with Animal characteristics.

  print(platypus.isAlive);
  platypus.eat();
  platypus.move();
  // platypus.layEggs();

  final repository = DataRepository();
  final temperature = repository.fetchTemperature('Manila');

  // mixins
  final platypus1 = Platypus();
  final robin = Robin();
  platypus1.layEggs();
  robin.layEggs();

  // extensions
  final original = 'I like extensions!';
  final secret = original.encoded;
  final revealed = secret.decoded;
  print(secret); // J!mjlf!fyufotjpot"
  print(revealed); // I like extensions!

  final language = ProgrammingLanguage.dart;
  print(language.isStronglyTyped);
}

// ********************************************      ********************************************

// calling super()  (with no params passed to it) is actually unnecessary, because Dart always calls
// the default constructor for the super class if there are no arguments to pass. The reason that you or Dart
// always need to make the super call is to ensure that all of the field values have finished initializing

// While using @override is technically optional in Dart, it does help in that the compiler will give you
// an error if you think you’re overriding something that doesn’t actually exist in the parent class

// **********************  Prefer composition over inheritance **********************
// The phrase means that, when appropriate, you should add behavior to a
// class rather than share behavior with an ancestor.
// You may have already noticed this fact in the code above. For example, when you’re overriding a method,
// do you need to call super? And if you do, should you call super at the beginning of the method,
// or at the end? Often the only way to know is to check the source code of the parent class.
// Jumping back and forth between levels of the hierarchy can make coding difficult
// Another problem with hierarchies is that they’re tightly bound together.
// Changes to a parent class can break a child class

// There’s no interface keyword in Dart. Instead, you can use any class as an interface. Since only
//the field and method names are important,most interfaces are made from abstract classes that contain no logic

// great advantage of using an interface is that you can create mock implementations to temporarily replace
// real implementations. In the FakeWebServer class, you are simply returning a random number instead of going
// to all the work of contacting a real server. This allows you to have a “working” app until you
// can get around to writing the code to contact the web server.

// *********************************  extensions *********************************
// Dart has a feature called extension methods that allow you to add functionality to existing classes. Even though
// they’re called extension methods, you can also add other members like getters, setters or even operators


// Having an object be able to take multiple forms is known as polymorphism
// Interfaces define a protocol for code communication.
// Use the implements keyword to create an interface.
// Dart only allows single inheritance on its classes
// in initializer list, the call to super always goes last, that is, after assert statements and initializers
// Mixins allow you to share code between classes
// Extension methods allow you to give additional functionality to classes that are not your own.
