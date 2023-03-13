import 'package:flutter/material.dart';
import 'package:arm_control_flutter/bluetooth_handler.dart';
import 'package:arm_control_flutter/theme.dart';
import 'globals.dart';
import 'theme.dart';
import 'bluetooth_handler.dart';
import 'bluetooth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  // This widget is the root of your application.
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    bleHandler = BLEHandler(setStateCallback);
    //TODO run at startup
  }

  void setStateCallback() {
    setState(() {});
  }


  double _currentSliderValue1 = 20;
  double _currentSliderValue2 = 20;
  double _currentSliderValue3 = 20;
  double _currentSliderValue4 = 20;
  double _currentSliderValue5 = 20;
  double _currentSliderValue6 = 20;


  void connectDevicePrompt() {
    // Show prompt for connecting a device
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return const BluetoothConnectScreen();
        });
  }

  void disconnectDevice() {
    setState(() {
      bleHandler.disconnect();
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: [ Column(

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
            Padding(padding: EdgeInsets.only(left:15),
              child: Text(bleHandler.connectedDevice == null
                  ? "Please connect a device"
                  : bleHandler.connectedDevice!.name,
                  style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 4, 6, 4)),),
            ),
            ElevatedButton(
              onPressed: bleHandler.connectedDevice == null
                  ? connectDevicePrompt
                  : disconnectDevice,
              child: Text(bleHandler.connectedDevice == null
                  ? "Connect"
                  : "Disconnect",
                  style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 4, 6, 4)),),
            ),
            if (bleHandler.connectedDevice != null)
              Image.asset(
              'lib/images/HeaderImage.jpg',
              width: 900,
              height: 300,
              fit: BoxFit.contain,
            ),


            if (bleHandler.connectedDevice != null)
              Row( //slider 1
              children:[
                Padding(padding: EdgeInsets.only(left:15),
                  child:Text(// ignore: prefer_const_constructors
                    'Claw',
                    style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 4, 6, 4)),

                  ),
                ),
                Expanded(

                  child: Slider( //Slider 1
                    value: _currentSliderValue1,
                    max: 100,
                    divisions: 100,
                    label: _currentSliderValue1.round().toString(),
                    activeColor: AppColors.purple,
                    inactiveColor: AppColors.cream,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue1 = value;
                        bleHandler.bluetoothWrite(_currentSliderValue1, "1");
                      });
                    },
                  ),


                ),

              ],
            ),
            if (bleHandler.connectedDevice != null)
              Row( // Slider 2
              children:[
                Padding(padding: EdgeInsets.only(left:15),
                  child:Text(// ignore: prefer_const_constructors
                    'Wrist',
                    style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 4, 6, 4)),

                  ),
                ),
                Expanded(
                    child: Slider(
                      value: _currentSliderValue2,
                      max: 100,
                      divisions: 100,
                      label: _currentSliderValue2.round().toString(),
                      activeColor: AppColors.purple,
                      inactiveColor: AppColors.cream,
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue2 = value;
                          bleHandler.bluetoothWrite(_currentSliderValue2, "2");
                        });
                      },
                    )),

              ],
            ),
            if (bleHandler.connectedDevice != null)
              Row( //slider 3
              children:[
                Padding(padding: EdgeInsets.only(left:15),
                  child:Text(// ignore: prefer_const_constructors
                    'Elbow 2',
                    style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 4, 6, 4)),

                  ),
                ),
                Expanded(

                    child: Slider(
                      value: _currentSliderValue3,
                      max: 100,
                      divisions: 100,
                      label: _currentSliderValue3.round().toString(),
                      activeColor: AppColors.purple,
                      inactiveColor: AppColors.cream,
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue3 = value;
                          bleHandler.bluetoothWrite(_currentSliderValue3, "3");
                        });
                      },
                    )),
              ],
            ),
            if (bleHandler.connectedDevice != null)
              Row( //slider 4
              children:[
                Padding(padding: EdgeInsets.only(left:15),
                  child:Text(// ignore: prefer_const_constructors
                    'Elbow 1',
                    style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 4, 6, 4)),

                  ),
                ),
                Expanded(
                    child: Slider(
                      value: _currentSliderValue4,
                      max: 100,
                      divisions: 100,
                      label: _currentSliderValue4.round().toString(),
                      activeColor: AppColors.purple,
                      inactiveColor: AppColors.cream,
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue4 = value;
                          bleHandler.bluetoothWrite(_currentSliderValue4, "4");
                        });
                      },
                    )),
              ],
            ),
            if (bleHandler.connectedDevice != null)
              Row( //Slider 5
              children:[
                Padding(padding: EdgeInsets.only(left:15),
                  child:Text(// ignore: prefer_const_constructors
                    'Shoulder',
                    style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 4, 6, 4)),

                  ),
                ),
                Expanded(
                    child: Slider(
                      value: _currentSliderValue5,
                      max: 100,
                      divisions: 100,
                      label: _currentSliderValue5.round().toString(),
                      activeColor: AppColors.purple,
                      inactiveColor: AppColors.cream,
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue5 = value;
                          bleHandler.bluetoothWrite(_currentSliderValue5, "5");
                        });
                      },
                    )),
              ],
            ),
            if (bleHandler.connectedDevice != null)
              Row( //Slider 6
              children:[
                Padding(padding: EdgeInsets.only(left:15),
                  child:Text(// ignore: prefer_const_constructors
                    'Base',
                    style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 4, 6, 4)),

                  ),
                ),
                Expanded(
                    child: Slider(
                      value: _currentSliderValue6,
                      max: 100,
                      divisions: 100,
                      label: _currentSliderValue6.round().toString(),
                      activeColor: AppColors.purple,
                      inactiveColor: AppColors.cream,
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue6 = value;
                          bleHandler.bluetoothWrite(_currentSliderValue6, "6");
                        });
                      },
                    )),
              ],
            ),
            if (bleHandler.connectedDevice != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Container( //Button 1
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: Text("Reset"),
                      onPressed: () {
                        print('you clicked me');
                        bleHandler.bluetoothWrite("!", "RESET");
                      },
                    ),
                  ),
                  Container( //Button 2
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                      child: Text("click me"),
                      onPressed: () {
                        print('you clicked me');
                      },
                    ),
                  ),
                  Container( //Button 3
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
      ]),
    );
  }
}



