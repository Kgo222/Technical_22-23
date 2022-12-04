import 'package:flutter/material.dart';
import 'package:arm_control_flutter/theme.dart';
import 'theme.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  // This widget is the root of your application.
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

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
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'lib/images/HeaderImage.jpg',
              width: 900,
              height: 300,
              fit: BoxFit.contain,
            ),
            Row(
              children:[
                Slider(
                  value: 0,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  activeColor: Colors.green,
                  inactiveColor: Colors.orange,
                  label: 'Set volume value',
                  onChanged: (double newValue) {
                    setState(() {
                      value = newValue.round();
                    });
                  },
                ),
              ],
            ),
            Row(
              children:[
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: Text("click me"),
                    onPressed: () {
                      print('you clicked me');
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(20),
                  child: ElevatedButton(
                    child: Text("click me"),
                    onPressed: () {
                      print('you clicked me');
                    },
                  ),
                ),
              ] //children
            ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
