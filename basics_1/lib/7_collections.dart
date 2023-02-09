// A slightly nicer syntax for creating an empty list is to use var
// or final and move the generic type to the right
var snacks = <String>[];

void main1() {
  final desserts = ['cookies', 'cupcakes', 'donuts', 'pie'];
  // desserts = []; // not allowed
  // desserts = ['cake', 'ice cream']; // not allowed
  // desserts = someOtherList; // not allowed      However:
  desserts.remove('cookies'); // OK
  desserts.remove('cupcakes'); // OK
  desserts.add('ice cream'); // OK

  // with a final list. Even though the memory address is constant, the values at that address are mutable
  // Creating deeply immutable lists is done by using const instead of final

  // if you want an immutable list but you won’t know the element values until runtime,
  // then you can create one with the List.unmodifiable named constructor:
  final modifiableList = [DateTime.now(), DateTime.now()];
  final unmodifiableList = List.unmodifiable(modifiableList);

  desserts.forEach((dessert) => print(dessert)); // shorter:
  desserts.forEach(print);
  // TEAR-OFF because you tear off the unnecessary syntax:
}

void spreedOperator(List<String> args) {
  // Spread operator
  const pastries = ['cookies', 'croissants'];
  const candy = ['Junior Mints', 'Twizzlers', 'M&Ms'];
  List<String>? coffees;
  final food = ['donuts', ...pastries, ...candy, ...?coffees]; // NULL SPREAD OPERATOR
}

void collection() {
  //  collection if
  const peanutAllergy = true;
  const candy = ['Junior Mints', 'Twizzlers', if (!peanutAllergy) 'Reeses'];

  //  collection for
  var bigCandy = ['ARABIAN', for (var can in candy) can.toUpperCase()];
}

// ********************************* Sets ( used to create a collection of unique elements )
void sets() {
  // final Set<int> someSet = {}; // or shorter and identical
  final someSet = <int>{};

  final anotherSet = {1, 2, 3, 1};
  print(anotherSet); // {1, 2, 3} there are two 1s there, but  it ends up with only one 1

  // Like Venn diagrams and mathematical sets, you can find the intersection of two sets in Dart
  final setA = {8, 2, 3, 1, 4};
  final setB = {1, 6, 5, 4};
  final intersection = setA.intersection(setB); // {1, 4} , the common elements that occur in both sets

  // union represents all the elements from both sets
  final union = setA.union(setB); // {8, 2, 3, 1, 4, 6, 5}
}

void maps() {
  final emptyMap = <String, int>{}; // A slightly shorter way to create a map
}

void hom() {
  const numbers = [1, 2, 3, 4];
  final squares = numbers.map((number) => number * number).toList();
  // It’s a common mistake to forget that map produces an Iterable rather than a List
  final evens = squares.where((square) => square.isEven);

  // Consolidating a collection
  // Some higher order methods take all the elements of an iterable collection and consolidate
  // them into a single value using the function you provide
  // 1- Using reduce
  const amounts = [199, 299, 299, 199, 499];
  final total1 = amounts.reduce((sum, element) => sum + element);
  // 1- Using reduce
  final total2 = amounts.fold(0, (int sum, element) => sum + element);
}

void sort() {
  // Performing a custom sort
  final desserts = ['cookies', 'pie', 'donuts', 'brownies'];
  desserts.sort((d1, d2) => d1.length.compareTo(d2.length));

  // Combining higher order methods
  final bigTallDesserts = desserts.where((dessert) => dessert.length > 5).map((dessert) => dessert.toUpperCase());
}

// Note: Unfortunately, inadvertently trying to modify an unmodifiable list will cause a runtime error — not a
// compile-time error. So while mutable data can be unsafe, so too can unmodifiable lists. A good practice is
// to write tests to ensure your code works as intended

// Almost everything about lists also applies to sets. Specifically, you can
// perform any of the following operations with sets:
// collection if
// collection for
// for-in loops
// forEach loops
// spread operators

// Higher order methods
// There are a number of collection operations common to many programming languages, including transforming,
// filtering and consolidating the elements of the collection.These operations are known as higher
// order methods, because they take functions as parameters.


// Note: One interesting characteristic of iterables is that they’re lazy. That means they don’t 
// do any work until you ask them to. Since reversed returns an iterable, it doesn’t actually reverse
// the elements of the collection until you try to access those elements, such as by printing the collection
// or converting it to a list using the toList method. Understanding this can help you put off
// work that doesn’t need to be done yet


// 1- Choose lists if order matters. Try to insert at the end of lists wherever possible to keep things 
// running smoothly. And be aware that searching can be slow with big collections.
// 2- Choose sets if you are only concerned with whether something is in the 
// collection or not. This is faster than searching a list.
// 3- Choose maps if you frequently need to search for a value by a key. Searching by key is also fast.

// 1- Lists store an ordered collection of elements.
// 2- Sets store an unordered collection of unique element
// 3- You can iterate over any collection, but for a map you need to iterate over 
// the keys or values if you use a for-in loop