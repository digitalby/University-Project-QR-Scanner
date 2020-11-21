import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:university_project_qr_scanner/bloc/bloc_provider.dart';
import 'package:university_project_qr_scanner/bloc/history_bloc.dart';
import 'package:university_project_qr_scanner/bloc/scan_bloc.dart';
import 'package:university_project_qr_scanner/ui/camera_screen.dart';
import 'package:university_project_qr_scanner/ui/history_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BlocProvider<HistoryBloc>(
      bloc: HistoryBloc(),
      child: BlocProvider<ScanBloc>(
        bloc: ScanBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: Text('QR Scanner'),
            ),
            body: CameraScreen(),
            drawer: HistoryDrawer(),
          ),
        ),
      ),
    );
  }
}
