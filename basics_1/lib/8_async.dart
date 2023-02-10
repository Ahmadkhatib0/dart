import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:http/http.dart' as http;

Future<void> main() async {
  // try {
  //   final url = 'https://jsonplaceholder.typicode.com/todos/1';
  //   final parsedUrl = Uri.parse(url);
  //   final response = await http.get(parsedUrl);
  //   final statusCode = response.statusCode;
  //   if (statusCode == 200) {
  //     final rawJsonString = response.body;
  //     final jsonMap = jsonDecode(rawJsonString);
  //     final todo = Todo.fromJson(jsonMap);
  //     print(todo);
  //   } else {
  //     throw HttpException('$statusCode');
  //   }
  // } on SocketException catch (error) {
  //   print(error);
  // } on HttpException catch (error) {
  //   print(error);
  // } on FormatException catch (error) {
  //   print(error);
  // }

  // final smallFile = File('assets/text.txt');
  // final contents = await smallFile.readAsString();
  // print(contents);

  // try {
  //   final bigFile1 = File('assets/text_long.txt');
  //   final stream1 = bigFile1.openRead();
  //   await for (var data in stream1) {
  //     print(data.length);
  //   }
  // } on Exception catch (error) {
  //   print(error);
  // } finally {
  //   print('All finished');
  // }

  // final bigFile2 = File('assets/text_long.txt');
  // final stream2 = bigFile2.openRead();
  // stream2.listen((data) => print(data.length));
  // await for (var data in stream2) {
  //   print(data.length);
  // }
  // stream2.listen(
  //   (data) => print(data.length),
  //   onError: (error) => print(error),
  //   onDone: () => print('All finished'),
  // );

  // Cancelling a stream
  // final bigFile3 = File('assets/text_long.txt');
  // final stream3 = bigFile3.openRead();
  // StreamSubscription<List<int>>? subscription;
  // subscription = stream3.listen(
  //   cancelOnError: true,
  //   onDone: () => print('All finished'),
  //   (data) {
  //     print(data.length);
  //     subscription?.cancel();
  //   },
  // );
  // Keeping a reference to that in the subscription variable allows you to cancel the subscription
  // whenever you want. In this case, you cancel it after the first data event.

  final smallFile2 = File('assets/text.txt');
  final stream = smallFile2.openRead();
  await for (var data in stream.transform(utf8.decoder)) {
    print(data);
  }
  stream.listen((data) => print(data));

  // Spawning an isolate
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(playHideAndSeekTheLongVersion, receivePort.sendPort); // 2

  receivePort.listen((message) {
    print(message);
    receivePort.cast();
    isolate.kill(); // to free up the memory
  });
}
// you spawned a new isolate and gave it two arguments. The first argument is the function that you
// want the isolate to execute. That function must be a top-level or static function. It must also take a single
// parameter. The second argument of spawn will be passed as the argument to playHideAndSeekTheLongVersion
// The second parameter of spawn isn’t actually required to be a SendPort object, but its a signature to
// communicate. If you want to pass additional parameters to the function, you can make the second
// parameter of spawn be a list or a map in which one of the elements is a SendPort and the
// other elements are additional arguments
// Note: The Flutter framework has a highly simplified way to start a new isolate, perform some work,
// and then return the result using a function called compute. Rather than passing the function a send port,
// you just pass it any values that are needed. In this case, you could just pass it the number to count to:
// await compute(playHideAndSeekTheLongVersion, 10000000000);

class Todo {
  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });
  factory Todo.fromJson(Map<String, Object?> jsonMap) {
    return Todo(
      userId: jsonMap['userId'] as int,
      id: jsonMap['id'] as int,
      title: jsonMap['title'] as String,
      completed: jsonMap['completed'] as bool,
    );
  }
  final int userId;
  final int id;
  final String title;
  final bool completed;
  @override
  String toString() => 'userId: $userId\n' 'id: $id\n' 'title: $title\n' 'completed: $completed';
}

void playHideAndSeekTheLongVersion(SendPort sendPort) {
  var counting = 0;
  for (var i = 1; i <= 1000000000; i++) {
    counting = i;
  }
  sendPort.send('$counting! Ready or not, here I come!');
}

// Tasks that take a long time generally fall into two categories:
// I/O tasks, and computationally intensive tasks. I/O, or input-output, includes things like reading and writing
// files, accessing a database, or downloading content from the internet. These all happen outside the CPU, so the
// CPU has to wait for them to complete. Computationally intensive tasks, on the other hand, happen inside the CPU.
// These tasks may include things like decrypting data, performing a mathematical calculation, or parsing JSON

// A thread is a sequence of commands that a computer executes. Some programming languages
//support multithreading, which is running multiple threads at the same time, while others
//do not. Dart, in particular, is a single-threaded language.

// Parallelism vs. concurrency
// Parallelism is when multiple tasks run at the same time on multiple processors or CPU cores.
// Concurrency, on the other hand, is when multiple tasks take turns running on a single CPU core.
// When a restaurant has a single person alternately taking orders and clearing tables, that’s concurrency. But a
// restaurant that has one person taking orders and a different person clearing tables, that’s parallelism

// A problem with parallelism
// in parallel threads that have access to the same memory. One thread saves a value in memory and expects the value
// to be the same when the thread checks the value later. However, if a second thread modifies the value, the first
// thread gets confused. It can be a major headache to track down those kinds of bugs because they come from a source
// completely separated from the code that reports the error. A language that supports multithreading needs to set up
// a system of locks so that values won’t be changed at the wrong time. The cognitive load of designing, implementing,
// and debugging a system with multiple threads can be heavy, to say the least So the problem isn’t so much with
//parallelism itself, but rather with multiple threads having access to the same state in memory.

// Dart isolates
// Dart’s single thread runs in what it calls an isolate. Each isolate has its own allocated memory area,
// which ensures that no isolate can access any other isolate’s state. That means that there’s no need for a
// complicated locking system.  It also means that sensitive data is much more secure. Such a system greatly
// reduces the cognitive load on a programme

// Flutter needs to update the UI 60 times a second, where each update timeslice is called a frame. That leaves
// about 16 milliseconds to redraw the UI on each frame. It doesn’t take that long, normally, so that gives you
// additional time to perform other work while the thread is idle. As long as that work doesn’t block Flutter
// from updating the UI on the next frame, the user won’t notice any problems. The trick is to schedule tasks
// during the thread’s downtimes.

// Dart uses what it calls an event loop to execute tasks that had previously been postponed
// The event loop has two queues: a microtask queue and an event queue. The microtask queue is mostly used internally
// by Dart. The event queue is for events like a user entering a keystroke or touching the screen, or data coming
// from a database, file, or remote server.

// Synchronous tasks in the main isolate thread are always run immediately. You can’t interrupt them
// If Dart finds any long-running tasks that agree to be postponed, Dart puts them in the event queue

// When Dart is finished running the synchronous tasks, the event loop checks the microtask queue. If the
// microtask queue has any tasks, the event loop puts them on the main thread to execute next. The event loop
// keeps checking the microtask queue until it’s empty.

// If the synchronous tasks and microtask queue are both empty, then the event loop sends the next waiting task
// in the event queue to run in the main thread. Once it gets there, the code is executed synchronously.
// Just like any other synchronous code, nothing can interrupt it after it starts

// If any new microtasks enter the microtask queue, the event loop
// always handles them before the next event in the event queue

// Running code in parallel
// One example of this is when the underlying platform performs some work at the request of Dart. For example,
// when you ask to read a file on the system, that work isn’t happening on the Dart thread. The system is doing the work
// inside its own process. Once the system finishes its work, it passes the result back to Dart, and Dart schedules
// some code to handle the result in the event queue. A lot of the I/O work from the dart:io library happens in this way
// Another way to perform work on other threads is to create a new Dart isolate. The new isolate has its own
// memory and its own thread working in parallel with the main isolate. The two isolates are only able to
// communicate through messages, though. They have no access to each other’s memory state. The idea is similar to
// messaging a friend.  Sending Ray a text message doesn’t give you access to the internal memory of his mobile
// device. He simply checks his messages and replies to you when he feels like it

// Note: Since the largest an int can be on a 64 bit system is 9,223,372,036,854,775,807, or 2^63 − 1,
// it would be better to use BigInt as the return type of countTheAtoms. Although slower, BigInt can handle
// arbitrarily large numbers. When int values are too big at compile time, there’s a compile-time
// error. However, at runtime, they overflow. That is, 9223372036854775807 + 1 == -9223372036854775808.

// *********************************  async code *********************************
// Dart has both an Exception type and an Error type. The words exception and error are often used interchangeably,
// but an Exception is something that you should expect and handle in the catch block.  However, an Error is the
// result of a programming mistake. You should let the error crash your app as a sign that you need
// to fix whatever caused the error

// SocketException: You’ll get this exception if there’s no internet connection. The http.get
// method is the one to throw the exception

// Streams, which are of type Stream, are used extensively in Dart and Dart-based frameworks. Here are some examples
// Reading a large file stored locally where new data from the file comes in chunks.
// Downloading a file from a remote server.
// Listening for requests coming into a server.
// Representing user events such as button clicks.
// Relaying changes in app state to the UI.

// When you read a file as a stream, it reads the file in chunks.The size of the chunks depends on how
// Dart is implemented on the system you’re using, but it’s probably 65,536 bytes per chunk as it was
// on the local machines used when writing this chapter. The text.txt file with Lorem Ipsum that you
// created earlier is only 445 bytes, so that means trying to stream that file would be no different
// than simply reading the whole thing as you did before.

// Note: By default, only a single object can listen to a stream. This is known as a
// single subscription stream. If you want more than one object to be notified of stream
// events, you need to create a broadcast stream, which you could do like so:
// final broadcastStream =
// stream.asBroadcastStream();

// [76, 111, 114, 101, ... ]
// Although different computers encode text files using different encodings, the abbreviated list above is from a
// computer that uses UTF-8 encoding. You may recall that UTF-16 uses 16-bit, or 2-byte, code units to encode
// Unicode text. UTF-8 uses one to four 8-bit units to encode Unicode text. Since for values of 127 and
// below, UTF-8 and Unicode code points are the same, English text only takes one byte per letter. This
// makes file sizes smaller than UTF-16 encoding, which is beneficial when saving to disk or
// sending over a network.

// The term for creating an isolate in Dart is called spawning. Since isolates don’t share any memory with
// each other, they can only communicate by sending messages. When you spawn a new isolate, you give it a
// message communication object called a send port. The new isolate uses the send port to send messages back
// to a receive port, which is listening on the main isolate.

exercise() {
  print('1 synchronous');
  Future(() => print('2 event queue')).then((value) => print('3 synchronous'));
  Future.microtask(() => print('4 microtask queue'));
  Future.microtask(() => print('5 microtask queue'));
  Future.delayed(Duration(seconds: 1), () => print('6 event queue'));
  Future(() => print('7 event queue')).then((value) => Future(() => print('8 event queue')));
  Future(() => print('9 event queue')).then((value) => Future.microtask(() => print('10 microtask queue')));
  print('11 synchronous');

  // 1 synchronous
  // 11 synchronous
  // 4 microtask queue
  // 5 microtask queue
  // 2 event queue
  // 3 synchronous
  // 7 event queue
  // 9 event queue
  // 10 microtask queue
  // 8 event queue
  // 6 event queue
}
