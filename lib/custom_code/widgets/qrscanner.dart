// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

import 'package:mobile_scanner/mobile_scanner.dart';

class Qrscanner extends StatefulWidget {
  const Qrscanner({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<Qrscanner> createState() => _QrscannerState();
}

class _QrscannerState extends State<Qrscanner> with WidgetsBindingObserver {
  MobileScannerController controller = MobileScannerController();
  StreamSubscription<Object?>? _subscription;
  String?
      _lastScannedCode; // Variable para llevar registro del último código de barras escaneado.
  DateTime?
      _lastScanTime; // Variable para llevar registro del tiempo del último escaneo.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription = controller.barcodes.listen(_handleBarcode);
    controller.start();
  }

  void _handleBarcode(BarcodeCapture capture) {
    final barcode = capture.barcodes.first;
    final barcodeValue = barcode.rawValue;

    // Evitar mostrar el Snackbar si el código de barras es el mismo que se escaneó recientemente.
    if (barcodeValue != null &&
        (barcodeValue != _lastScannedCode ||
            DateTime.now()
                    .difference(_lastScanTime ?? DateTime.now())
                    .inSeconds >
                5)) {
      // Actualizar el último código escaneado y el tiempo del último escaneo.
      _lastScannedCode = barcodeValue;
      _lastScanTime = DateTime.now();
/*     FFAppState().QRvalue = barcodeValue.toString();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Card found: $barcodeValue'),
          duration: Duration(seconds: 1),
        ),
      );
*/
      FFAppState().QRvalue = barcodeValue.toString();
      print('Barcode found: $barcodeValue');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!controller.value.isInitialized) return;
    switch (state) {
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);
        controller.start();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _subscription?.cancel();
        _subscription = null;
        controller.stop();
        break;
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: MobileScanner(
        controller: controller,
        overlayBuilder: (context, constraints) {
          return Container(
            alignment: Alignment.center,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.red,
                  width: 3,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
