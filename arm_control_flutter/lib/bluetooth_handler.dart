import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:arm_control_flutter/globals.dart';
import 'dart:convert';
import 'package:arm_control_flutter/constants.dart';
import 'dart:io' show Platform;

class BLEHandler {
  late StreamSubscription notificationSubscription;
  late StreamSubscription connectionStateSubscription;
  List<BluetoothService> services = [];
  Function setState;
  BluetoothDevice? connectedDevice;

  // Constructor
  BLEHandler(this.setState);

  Future<void> connect(BluetoothDevice device) async {
    try {
      await device.connect();
    } on PlatformException catch(e) {
      if (e.code == 'already_connected') {
        // We really shouldn't end up here
        return;
      } else {
        rethrow;
      }
    }

    // Listen for (externally initiated) device disconnect and update UI accordingly
    connectionStateSubscription = device.state.listen((s) {
      if(s == BluetoothDeviceState.disconnected) {
        // Accessing the deviceScreenHandler here is a little awkward, but it gets the job done
        // Equivalent to disconnectDevice in homepage.dart
        disconnect(); // Cancel subscription streams
        setState(); // Update UI
      }
    });

    connectedDevice = device;
    setState();

    services = await device.discoverServices();

  }



  void bluetoothWrite(sliderVal, sliderNum) async {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == Constants.uuid) {
          // Format data
          String data = "#" + sliderNum.toString() + "|" + sliderVal.toString();

          if (Platform.isAndroid)
          {
            await characteristic.write(utf8.encode(data), withoutResponse: true);
          }
          else if (Platform.isIOS)
          {
            await characteristic.write(utf8.encode(data));
          }
          return;
        }
      }
    }
  }

  void disconnect() {
    notificationSubscription.cancel();
    connectionStateSubscription.cancel();
    if(connectedDevice != null) {
      connectedDevice!.disconnect();
      connectedDevice = null;
    }
  }
}