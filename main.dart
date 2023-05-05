import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final IOWebSocketChannel channel = IOWebSocketChannel.connect('ws://192.168.1.110:3000');
  final _controller = TextEditingController();

  void _send() {
    var text = _controller.text;
    channel.sink.add(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            },
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Input",
                suffixIcon: IconButton(
                    onPressed: () => {
                      _send(),
                      _controller.clear()
                    },
                    icon: const Icon(Icons.send)
                )
            ),
          ),

        ],
      ),
    );
  }
}
