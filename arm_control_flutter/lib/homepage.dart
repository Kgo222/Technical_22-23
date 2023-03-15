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

  double _currentSliderValue1 = 20;
  double _currentSliderValue2 = 150;
  double _currentSliderValue3 = 90;
  double _currentSliderValue4 = 180;
  double _currentSliderValue5 = 85;
  double _currentSliderValue6 = 80;
  //Tracks if a slider is being updated (1-in use, 0-otherwise)
  int oneInAction = 0;
  int twoInAction = 0;
  int threeInAction = 0;
  int fourInAction = 0;
  int fiveInAction = 0;
  int sixInAction = 0;

  @override
  void initState() {
    super.initState();
    bleHandler = BLEHandler(setStateCallback);
    //TODO run at startup
  }

  void setStateCallback() {
    setState(() {});
  }



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
                    max: 50,
                    divisions: 50,
                    label: _currentSliderValue1.round().toString(),
                    activeColor: AppColors.purple,
                    inactiveColor: AppColors.cream,
                    onChanged: (double value) {
                      if(twoInAction == 0 && threeInAction == 0 && fourInAction == 0 && fiveInAction == 0 && sixInAction==0){
                        setState(() {
                          _currentSliderValue1 = value;
                          oneInAction = 1;
                        });
                      }
                    },
                    onChangeEnd: (double value){
                      bleHandler.bluetoothWrite(value.round(), "#1");
                      oneInAction = 0;
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
                      max: 180,
                      divisions: 180,
                      label: _currentSliderValue2.round().toString(),
                      activeColor: AppColors.purple,
                      inactiveColor: AppColors.cream,
                      onChanged: (double value) {
                        if(oneInAction == 0 && threeInAction == 0 && fourInAction == 0 && fiveInAction == 0 && sixInAction==0){
                          setState(() {
                            _currentSliderValue2 = value;
                            twoInAction = 1;
                          });
                        }
                      },
                      onChangeEnd: (double value){
                        bleHandler.bluetoothWrite(value.round(), "#2");
                        twoInAction = 0;
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
                      max: 180,
                      divisions: 180,
                      label: _currentSliderValue3.round().toString(),
                      activeColor: AppColors.purple,
                      inactiveColor: AppColors.cream,
                      onChanged: (double value) {
                        if(oneInAction == 0 && twoInAction == 0 && fourInAction == 0 && fiveInAction == 0 && sixInAction==0){
                          setState(() {
                            _currentSliderValue3 = value;
                            threeInAction = 1;
                          });
                        }
                      },
                      onChangeEnd: (double value){
                        bleHandler.bluetoothWrite(value.round(), "#3");
                        threeInAction = 0;
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
                      max: 180,
                      divisions: 180,
                      label: _currentSliderValue4.round().toString(),
                      activeColor: AppColors.purple,
                      inactiveColor: AppColors.cream,
                      onChanged: (double value) {
                        if(oneInAction == 0 && twoInAction == 0 && threeInAction == 0 && fiveInAction == 0 && sixInAction==0){
                          setState(() {
                            _currentSliderValue4 = value;
                            fourInAction = 1;
                          });
                        }
                      },
                      onChangeEnd: (double value){
                        bleHandler.bluetoothWrite(value.round(), "#4");
                        fourInAction = 0;
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
                      max: 180,
                      divisions: 180,
                      label: _currentSliderValue5.round().toString(),
                      activeColor: AppColors.purple,
                      inactiveColor: AppColors.cream,
                      onChanged: (double value) {
                        if(oneInAction == 0 && twoInAction == 0 && threeInAction == 0 && fourInAction == 0 && sixInAction==0){
                          setState(() {
                            _currentSliderValue5 = value;
                            fiveInAction = 1;
                          });
                        }
                      },
                      onChangeEnd: (double value){
                        bleHandler.bluetoothWrite(value.round(), "#5");
                        fiveInAction = 0;
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
                    child: Slider(//Slider 6
                      value: _currentSliderValue6,
                      max: 90,
                      divisions: 90,
                      label: _currentSliderValue6.round().toString(),
                      activeColor: AppColors.purple,
                      inactiveColor: AppColors.cream,
                      onChanged: (double value) {
                        if(oneInAction == 0 && twoInAction == 0 && threeInAction == 0 && fourInAction == 0 && fiveInAction==0){
                          setState(() {
                            _currentSliderValue6 = value;
                            sixInAction = 1;
                          });
                        }
                      },
                      onChangeEnd: (double value){
                        bleHandler.bluetoothWrite(value.round(), "#6");
                        sixInAction = 0;
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
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Please Wait',
                                style: TextStyle(color: Color.fromARGB(255, 4, 6, 4)),),
                            content: const Text('Resetting the Robot takes 20-30 seconds. '
                                'Let it complete its changes before clicking more options',
                              style: TextStyle(color: Color.fromARGB(255, 4, 6, 4)),),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        if(oneInAction==0 && twoInAction==0 && threeInAction==0 && fourInAction==0 && fiveInAction==0 && sixInAction==0){
                          bleHandler.bluetoothWrite("!", "RESET");
                           _currentSliderValue1 = 20;
                           _currentSliderValue2 = 150;
                           _currentSliderValue3 = 90;
                           _currentSliderValue4 = 180;
                           _currentSliderValue5 = 85;
                           _currentSliderValue6 = 80;
                        }
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



