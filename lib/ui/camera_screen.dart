import 'dart:convert';

import 'package:camerakit/CameraKitController.dart';
import 'package:camerakit/CameraKitView.dart';
import 'package:flutter/material.dart';
import 'package:university_project_qr_scanner/bloc/bloc_provider.dart';
import 'package:university_project_qr_scanner/bloc/history_bloc.dart';
import 'package:university_project_qr_scanner/bloc/scan_bloc.dart';
import 'package:university_project_qr_scanner/data/code_scan_result.dart';
import 'package:university_project_qr_scanner/data/qr_code_scan_result.dart';

class CameraScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State {
  final _cameraKitController = CameraKitController();
  var _permissionDenied = false;


  @override
  Widget build(BuildContext context) {
    if (_permissionDenied) {
      return _buildPermissionDeniedView(context);
    }
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        Column(
          children: <Widget>[
            Expanded(
              child: _buildStreamBuilder(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStreamBuilder(BuildContext context) {
    final bloc = BlocProvider.of<ScanBloc>(context);
    return StreamBuilder<CodeScanResult>(
      stream: bloc.resultStream,
      initialData: bloc.scanResult,
      builder: (context, snapshot) {
        final result = snapshot.data;
        if (result != null && result is QRCodeScanResult) {
          final snackBar = SnackBar(
            content: Text("$result"),
            action: SnackBarAction(
              label: "Open",
              onPressed: () {
                final historyBloc = BlocProvider.of<HistoryBloc>(context);
                historyBloc.addResult(result);
                bloc.launchURLForScanResult(result);
              },
            ),
          );
          WidgetsBinding.instance.addPostFrameCallback((_)
          => Scaffold.of(context).showSnackBar(snackBar));
        }

        return _buildCameraView(context);
      },
    );
  }

  Widget _buildCameraView(BuildContext context) {
    return CameraKitView(
      cameraKitController: _cameraKitController,
      hasBarcodeReader: true,
      barcodeFormat: BarcodeFormats.FORMAT_ALL_FORMATS,
      scaleType: ScaleTypeMode.fit,
      previewFlashMode: CameraFlashMode.off,
      useCamera2API: true,
      onPermissionDenied: () {
        setState(() => _permissionDenied = true);
      },
      onBarcodeRead: (code) {
        final data = code as String;
        final result = QRCodeScanResult()
          ..resultTitle = data
          ..data = utf8.encoder.convert(data)
          ..date = DateTime.now();
        BlocProvider.of<ScanBloc>(context).processScanResult(result);
      },
    );
  }

  Widget _buildPermissionDeniedView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Camera permission denied."),
          RaisedButton.icon(
              onPressed: () {
                dispose();
                setState(() {
                  _permissionDenied = false;
                });
              },
              icon: Icon(Icons.refresh),
              label: Text("Retry")
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraKitController.closeCamera();
    super.dispose();
  }
}