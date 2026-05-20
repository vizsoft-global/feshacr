import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_one_initial_model.dart';
export 'game_one_initial_model.dart';

class GameOneInitialWidget extends StatefulWidget {
  const GameOneInitialWidget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  @override
  State<GameOneInitialWidget> createState() => _GameOneInitialWidgetState();
}

class _GameOneInitialWidgetState extends State<GameOneInitialWidget> {
  late GameOneInitialModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameOneInitialModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (Navigator.of(context).canPop()) {
        context.pop();
      }
      context.pushNamed(
        GameOneS3Widget.routeName,
        queryParameters: {
          'room': serializeParam(
            widget!.room,
            ParamType.DocumentReference,
          ),
        }.withoutNulls,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
