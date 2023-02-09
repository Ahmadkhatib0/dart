void main() {
  const user = User(id: 42, name: 'Ray');
  print(user);

  final anonymousUser = User.anonymous();
  print(anonymousUser);
}

// *********************************  getters and factories
class User {
  const User.anonymous() : this();

  final String _name;
  final int _id;
  const User({int id = 0, String name = 'anonymous'}) // Short-form constructor  (unnamed constructor)
      : assert(id > 0),
        // assert(name.isNotEmpty),// this is a runtime check and not allowed for a compile-time constant
        _id = id,
        _name = name;

  int get id => _id;
  String get name => _name;
  bool get isBigId => _id > 1000; // Calculated properties

  factory User.fromJson(Map<String, Object> json) {
    final userId = json['id'] as int;
    final userName = json['name'] as String;
    return User(id: userId, name: userName);
  }
}

// ********************************* Object reference
class MyClass {
  var myProperty = 1;
}

void main1() {
  final myObject = MyClass();
  final anotherObject = myObject;
  print(myObject.myProperty); // 1
  anotherObject.myProperty = 2;
  print(myObject.myProperty); // 2
  // myObject and anotherObject both reference the same place in memory. Changing myProperty
  // in either object will affect the other, since they both reference the same instance

  // Note: If you want to make an actual copy of the class — not just a copy of its reference in memory
  // but a whole new object with a deep copy of all the data it contains — then you’ll need to implement
  // that mechanism yourself by creating a method in your class that builds up a whole new object.
}

// ********************************* getters and setters
class Email {
  var _address = '';
  String get value => _address;
  set value(String address) => _address = address;
}

void main2(List<String> args) {
  final email = Email();
  email.value = 'ray@example.com';
  final emailString = email.value;
}

class Email1 {
  var value = '';
  // Dart implicitly generates the needed getters and setters for you
  // If you only want a getter but not a setter, then just make the property final, which will also require
  // adding a constructor to initialize the property

  // you can to do what have been done in main2 function
}

// ********************************* static
class SomeClass {
  static int myProperty = 0;
  static void myMethod() {
    print('Hello, Dart!');
  }
}

void main4(List<String> args) {
  final value = SomeClass.myProperty;
  SomeClass.myMethod();
}

// ********************************* statics
class User1 {
  const User1({
    this.id = _anonymousId,
    this.name = _anonymousName,
  }) : assert(id >= 0);
  final String name;
  final int id;

  static const _anonymousId = 0;
  static const _anonymousName = 'anonymous';

  static User fromJson(Map<String, Object> json) {
    final userId = json['id'] as int;
    final userName = json['name'] as String;
    return User(id: userId, name: userName);
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name)';
  }
}

// ********************************* singleton
class MySingleton {
  MySingleton._(); // The MySingleton._() part is a private named constructor

  // the first way to instantiate
  static final MySingleton instance = MySingleton._();
  // The underscore makes it impossible to instantiate the class normally. However, the static property,
  // which is only initialized once, provides a reference to the instantiated object

  // the second way to instantiate
  // The advantage here is that you can hide the fact that it’s a singleton from whoever uses it
  static final MySingleton _instance = MySingleton._();
  factory MySingleton() => _instance;
}

final mySingleton1 = MySingleton.instance;
final mySingleton2 = MySingleton(); 


// In addition to being immutable, another benefit of const variables is that they’re canonical instances,
// which means that no matter how many instances you create, as long as the properties used to create them
// are the same, Dart will only see a single instance. You could instantiate User.anonymous() a thousand
// times across your app without incurring the performance hit of having a thousand different objects

// factory constructors can return existing instances of the class, or even subclasses of it
// This is useful when you want to hide the implementation details of a class from the code that uses it
// the factory constructor body allows you to perform some work before returning the new object, without
// exposing the inner wiring of that instantiation process to whoever is using the class

// Constructors can be:
// 1- Forwarding or non-forwarding
// 2- Named or unnamed
// 3- Generative or factory
// 4- Constant or not constant
// const User(this.id, this.name);  // This is a non-forwarding, unnamed, generative, const constructor.

// Note: Variables are given different names according to where they belong or where they’re located.
// Since static variables belong to the class, they’re called class variables. Non-static member variables
// are called instance variables because they only have a value after an object is instantiated. Variables
// within a method are called local variables, and top-level variables outside of
// a class are called global variables

// setters give you some extra control over what’s assigned to your properties; for instance, you could
// sanitize input, check for properly formatted email addresses, and more

// If you put static in front of a member variable or method, that causes the variable or method to
// belong to the class rather than the instance

// Note: Static fields and top-level variables, that is, global variables outside
// of a class, are lazily initialized. That means Dart doesn’t actually calculate
// and assign their values until you use them the first time.

// when making singleton from factory and using it this looks exactly like a 
// normal object.This gives you the freedom to change it back into a generative 
// constructor later without affecting the code in other parts of your project.


// Comparing static methods with factory constructors
// 1- A factory constructor can only return an instance of the class type or subtype, 
// while a static method can return anything.
// 2- A factory constructor can be unnamed so that, from the caller’s perspective, it looks exactly 
// like calling a generative constructor. The singleton example above is an example of this.
// A static method, on the other hand, must have a name.
// 3- A factory constructor can be const if it’s a forwarding constructor, but a static method can’t.