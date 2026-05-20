import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah_game_zone/main/home_resume/home_resume_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_status_checker_model.dart';
export 'game_status_checker_model.dart';

class GameStatusCheckerWidget extends StatefulWidget {
  const GameStatusCheckerWidget({super.key});

  @override
  State<GameStatusCheckerWidget> createState() =>
      _GameStatusCheckerWidgetState();
}

class _GameStatusCheckerWidgetState extends State<GameStatusCheckerWidget> {
  late GameStatusCheckerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameStatusCheckerModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!loggedIn) return;
      // Without a current in-progress room reference there's nothing to resume,
      // so skip the lookup entirely. Force-unwrapping previously crashed every
      // Home mount for users with no active match (e.g., right after sign-in).
      final user = currentUserDocument;
      final roomRef = user?.presentRoomGameInfo.roomRef;
      if (user == null || roomRef == null) return;
      _model.presentRoomResult = await RoomRecord.getDocumentOnce(roomRef);
        if ((_model.presentRoomResult?.selectedGameList
                    ?.where((e) =>
                        e.selectedGameID ==
                        currentUserDocument
                            ?.presentRoomGameInfo?.roomSelectedGameID)
                    .toList()
                    ?.firstOrNull
                    ?.gameResult
                    ?.status !=
                'win') ||
            (_model.presentRoomResult?.selectedGameList
                    ?.where((e) =>
                        e.selectedGameID ==
                        currentUserDocument
                            ?.presentRoomGameInfo?.roomSelectedGameID)
                    .toList()
                    ?.firstOrNull
                    ?.gameResult
                    ?.status !=
                'tie')) {
          if ((currentUserDocument?.presentRoomGameInfo?.roomGameId == 1001) ||
              (currentUserDocument?.presentRoomGameInfo?.roomGameId == 1003)) {
            if (_model.presentRoomResult?.roomCreatedUserRef ==
                currentUserReference) {
              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (dialogContext) {
                  return Dialog(
                    elevation: 0,
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    alignment: AlignmentDirectional(0.0, 0.0)
                        .resolve(Directionality.of(context)),
                    child: WebViewAware(
                      child: Container(
                        width: 500.0,
                        child: HomeResumeWidget(
                          room:
                              currentUserDocument!.presentRoomGameInfo.roomRef!,
                          selectedGameID: currentUserDocument!
                              .presentRoomGameInfo.roomSelectedGameID,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            if (currentUserDocument?.presentRoomGameInfo?.roomGameId == 1002) {
              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (dialogContext) {
                  return Dialog(
                    elevation: 0,
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    alignment: AlignmentDirectional(0.0, 0.0)
                        .resolve(Directionality.of(context)),
                    child: WebViewAware(
                      child: Container(
                        width: 500.0,
                        child: HomeResumeWidget(
                          room:
                              currentUserDocument!.presentRoomGameInfo.roomRef!,
                          selectedGameID: currentUserDocument!
                              .presentRoomGameInfo.roomSelectedGameID,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              if (currentUserDocument?.presentRoomGameInfo?.roomGameId ==
                  1004) {
                await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (dialogContext) {
                    return Dialog(
                      elevation: 0,
                      insetPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      alignment: AlignmentDirectional(0.0, 0.0)
                          .resolve(Directionality.of(context)),
                      child: WebViewAware(
                        child: Container(
                          width: 500.0,
                          child: HomeResumeWidget(
                            room: currentUserDocument!
                                .presentRoomGameInfo.roomRef!,
                            selectedGameID: currentUserDocument!
                                .presentRoomGameInfo.roomSelectedGameID,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }
          }
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
    return Builder(
      builder: (context) => Container(),
    );
  }
}
