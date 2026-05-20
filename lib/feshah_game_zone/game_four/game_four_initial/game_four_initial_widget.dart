import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_four_initial_model.dart';
export 'game_four_initial_model.dart';

class GameFourInitialWidget extends StatefulWidget {
  const GameFourInitialWidget({
    super.key,
    required this.room,
  });

  final DocumentReference? room;

  @override
  State<GameFourInitialWidget> createState() => _GameFourInitialWidgetState();
}

class _GameFourInitialWidgetState extends State<GameFourInitialWidget> {
  late GameFourInitialModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFourInitialModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.presentRoomResult =
          await RoomRecord.getDocumentOnce(widget!.room!);
      if ((_model.presentRoomResult?.selectedGameList
                  ?.where((e) =>
                      currentUserDocument
                          ?.presentRoomGameInfo?.roomSelectedGameID ==
                      e.selectedGameID)
                  .toList()
                  ?.firstOrNull
                  ?.gameResult
                  ?.status ==
              'win') ||
          (_model.presentRoomResult?.selectedGameList
                  ?.where((e) =>
                      currentUserDocument
                          ?.presentRoomGameInfo?.roomSelectedGameID ==
                      e.selectedGameID)
                  .toList()
                  ?.firstOrNull
                  ?.gameResult
                  ?.status ==
              'tie')) {
        context.goNamed(
          GameFourS3Widget.routeName,
          queryParameters: {
            'room': serializeParam(
              widget!.room,
              ParamType.DocumentReference,
            ),
          }.withoutNulls,
        );
      } else {
        await Future.delayed(
          Duration(
            milliseconds: 5000,
          ),
        );
        safeSetState(() {});
      }
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
