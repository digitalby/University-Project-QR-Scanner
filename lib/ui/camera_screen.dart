import 'package:camerakit/CameraKitController.dart';
import 'package:camerakit/CameraKitView.dart';
import 'package:flutter/material.dart';
import 'package:university_project_qr_scanner/bloc/bloc_provider.dart';
import 'package:university_project_qr_scanner/bloc/scan_bloc.dart';
import 'package:university_project_qr_scanner/data/code_scan_result.dart';
import 'package:university_project_qr_scanner/data/qr_code_scan_result.dart';

class CameraScreen extends StatelessWidget {
  final _cameraKitController = CameraKitController();

  @override
  Widget build(BuildContext context) {
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
        // final result = snapshot.data;
        // if (result != null && result is QRCodeScanResult) {
        //
        // }

        return _buildCameraView();
      },
    );
  }

  Widget _buildCameraView() {
    return CameraKitView(
      cameraKitController: _cameraKitController,
      hasBarcodeReader: true,
      barcodeFormat: BarcodeFormats.FORMAT_ALL_FORMATS,
      scaleType: ScaleTypeMode.fit,
      previewFlashMode: CameraFlashMode.off,
      useCamera2API: true,
      onPermissionDenied: () {
        print("Camera permission is denied.");
      },
      onBarcodeRead: (code) {
        print("Barcode is read: " + code);
      },
    );
  }
}