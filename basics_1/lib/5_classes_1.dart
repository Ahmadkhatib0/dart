void main() {
  // Cascade notation
  // allows you to chain together multiple assignments on the same object without having to repeat the object name
  // final user1 = User()
  //   ..name = 'Ray'
  //   ..id = 42;

  final user = User(id: 42, name: 'Ray');
  print(user);

  final anonymousUser = User.anonymous();
  print(anonymousUser);

  // user._name = 'Nefarious Hacker'; // without final keyword on _name
  // using an underscore before a variable or method name makes it library private, not class private
  // you’ll need to make another file so that you aren’t using your class in the same file in which it’s defined
}

class User {
  // int id = 0;
  // String name = '';
  // User();
  // This type of constructor is called a generative constructor because it directly generates an object of the same type

  //This is known as a long-form constructor.
  // User(int id, String name) {
  // this.name refers the object property called name, while name (without this) refers to the constructor
  // parameter. Using the same name for the constructor parameters as the class properties is called shadowing. So
  // the constructor above takes the id and name parameters and uses this to initialize the properties of the object
  //   this.id = id;
  //   this.name = name;
  // }

  // Named constructors
  // instead of repeating it like so:
  // User.anonymous() {
  //   id = 0;
  //   name = 'anonymous';
  // }

  // you should FORWARD CONSTRUCTORS:
  User.anonymous() : this();

  // Making properties immutable (By using immutable properties, you don’t even have to make them private)
  final String _name;
  final int _id;
  User({int id = 0, String name = 'anonymous'}) // Short-form constructor  (unnamed constructor)
      : assert(id > 0),
        assert(name.isNotEmpty),
        _id = id,
        _name = name;
  // The comma-separated list that comes after it is called the initializer list

  @override
  String toString() {
    return 'User(id: $_id, name: $_name)';
  }
}
