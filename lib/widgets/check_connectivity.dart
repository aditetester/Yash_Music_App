import 'dart:async';
import '/utils/routes/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

class CheckConnectivity {
  static Future<void> connection(BuildContext context) async {
    // ConnectivityResult _connectionStatus = ConnectivityResult.none;

    print('Internet Connection Function Called');

    final Connectivity _connectivity = Connectivity();
    late StreamSubscription<ConnectivityResult> _connectivitySubscription;

    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
       List<ConnectivityResult> results = await _connectivity.checkConnectivity();
      result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    print('Internet Connection: ${result}');

    if(result == ConnectivityResult.none) {
      final snackBar = SnackBar(
        content: Text('No Internet Connection!'),
        backgroundColor: Colors.red,
        action: SnackBarAction(label: 'Downloads', textColor: Colors.white, onPressed: () {
        
        },),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
