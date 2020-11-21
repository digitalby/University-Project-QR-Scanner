import 'package:flutter/material.dart';
import 'package:university_project_qr_scanner/bloc/bloc_provider.dart';
import 'package:university_project_qr_scanner/bloc/history_bloc.dart';
import 'package:university_project_qr_scanner/bloc/scan_bloc.dart';
import 'package:university_project_qr_scanner/data/code_scan_result.dart';

class HistoryDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryDrawerState();
  }
}

class _HistoryDrawerState extends State {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _buildStreamBuilder(context),
    );
  }

  Widget _buildStreamBuilder(BuildContext context) {
    final bloc = BlocProvider.of<HistoryBloc>(context);
    bloc.fetchResults();
    return StreamBuilder(
      stream: bloc.historyStream,
      builder: (context, snapshot) {
        var children = <Widget>[
          _buildHeader(bloc),
        ];

        final List<CodeScanResult> history =
        (snapshot.connectionState == ConnectionState.waiting)
            ? bloc.results
            : snapshot.data;

        for (final scanResult in history.reversed) {
          final tile = ListTile(
            title: Text(scanResult.resultTitle),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                bloc.removeResult(scanResult);
              },
            ),
            onTap: () {
              final scanBloc = BlocProvider.of<ScanBloc>(context);
              scanBloc.launchURLForScanResult(scanResult);
            },
          );
          children.add(
            tile,
          );
        }

        return ListView(
          children: children,
        );
      },
    );
  }

  Widget _buildHeader(HistoryBloc bloc) {
    return DrawerHeader(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Scan History",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  bloc.removeAllResults();
                },
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.amber,
      ),
    );
  }
}