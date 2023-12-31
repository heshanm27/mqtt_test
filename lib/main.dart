import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


void main() {
  // final WebSocketLink webSocketLink = WebSocketLink(
  //   'ws://localhost:8080/graphql',
  // );
  //
  // ValueNotifier<GraphQLClient> client = ValueNotifier(
  //   GraphQLClient(
  //     link: webSocketLink,
  //     // The default store is the InMemoryStore, which does NOT persist to disk
  //     cache: GraphQLCache(store: HiveStore()),
  //   ),
  // );
  //
  //
  //
  // // Register a listener for WebSocket messages
  // webSocketLink.stream.listen((message) {
  //   // Handle the incoming message
  //   print('Received WebSocket message: $message');
  // });
  listenToMessage();
  runApp(MyApp());
}

Future<void> listenToMessage() async {
  /// Create the WebSocket channel
  ///
     final jsonData = {
       "host": "wujlhsdysnhlziirgt4cxnxzwe.appsync-api.us-east-1.amazonaws.com",
       "Authorization": "16op3cla8snjg19acd4r477krk54tsvf28c46sok63riso9pmlvv"
    };

    final jsonString = json.encode(jsonData);
    final base64String = base64.encode(utf8.encode(jsonString));
    final payload = {};
    final payloadString = json.encode(payload);
    final payloadBase64 = base64.encode(utf8.encode(payloadString));
  final channel =  WebSocketChannel.connect(
    Uri.parse('wss://wujlhsdysnhlziirgt4cxnxzwe.appsync-realtime-api.us-east-1.amazonaws.com/graphql?header=${base64String}&payload=${payloadBase64}'),
    protocols: ['graphql-ws'],
  );

  channel.sink.add(
    jsonEncode(
        {
          "id": "key-cf23-4cb8-9fcb-152ae4fd1e69",
          "payload": {
            "data": "{\"query\":\"subscription SubscribeToData {\\n  subscribe(name: \\\"channel\\\") {\\n    name\\n    data\\n  }\\n}\",\"variables\":{}}",
            "extensions": {
              "authorization": {
                "x-api-key": "da2-zf2obptsifhvhcbscu6cc5tzwa",
                "host": "wujlhsdysnhlziirgt4cxnxzwe.appsync-api.us-east-1.amazonaws.com"
              }
            }
          },
          "type": "start"
        }
    ),
  );
  //    channel.stream.first.then((_) {
  //      print('WebSocket connected');
  //    });
  /// Listen for all incoming data
  channel.stream.listen(
        (data) {
      print(data);

    },
    onError: (error) => print(error),
  );
}

class MyApp extends StatelessWidget {
  // final ValueNotifier<GraphQLClient>? client;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
