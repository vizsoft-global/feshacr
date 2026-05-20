import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah_game_zone/game/game_exit/game_exit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'app_bar_game_model.dart';
export 'app_bar_game_model.dart';

class AppBarGameWidget extends StatefulWidget {
  const AppBarGameWidget({
    super.key,
    this.room,
    this.backButtonStatus,
    this.topicButtonStatus,
    this.exitButtonStatus,
    int? selectedGameID,
    this.pageTitle,
    bool? presentTeamInfoStatus,
    this.presentTeamID,
    this.teamInfo,
    String? backButtonFrom,
    String? backButtonText,
    this.topicsQuestions,
  })  : this.selectedGameID = selectedGameID ?? 0,
        this.presentTeamInfoStatus = presentTeamInfoStatus ?? false,
        this.backButtonFrom = backButtonFrom ?? 'default',
        this.backButtonText = backButtonText ?? 'Back';

  final DocumentReference? room;
  final bool? backButtonStatus;
  final bool? topicButtonStatus;
  final bool? exitButtonStatus;
  final int selectedGameID;
  final String? pageTitle;
  final bool presentTeamInfoStatus;
  final int? presentTeamID;
  final List<TeamInfoStruct>? teamInfo;
  final String backButtonFrom;
  final String backButtonText;
  final String? topicsQuestions;

  @override
  State<AppBarGameWidget> createState() => _AppBarGameWidgetState();
}

class _AppBarGameWidgetState extends State<AppBarGameWidget> {
  late AppBarGameModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppBarGameModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      if ((widget!.backButtonText ==
                              FFLocalizations.of(context).getVariableText(
                                enText: 'Back',
                                arText: 'خلف',
                              )) &&
                          (widget!.backButtonStatus == true))
                        FFButtonWidget(
                          onPressed: () async {
                            if (widget!.backButtonFrom == '2') {
                              FFAppState().gameZoneSteps = 1;
                              FFAppState().update(() {});
                            } else {
                              context.pop();
                            }
                          },
                          text: FFLocalizations.of(context).getText(
                            'wr50ze25' /* Back */,
                          ),
                          icon: Icon(
                            Icons.chevron_left_rounded,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: 30.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            iconAlignment: IconAlignment.start,
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondary,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      if ((widget!.backButtonText !=
                              FFLocalizations.of(context).getVariableText(
                                enText: 'Back',
                                arText: 'خلف',
                              )) &&
                          (widget!.backButtonStatus == true))
                        FFButtonWidget(
                          onPressed: () async {
                            _model.presentRoomResult =
                                await RoomRecord.getDocumentOnce(widget!.room!);
                            if (_model.presentRoomResult?.selectedGameList
                                    ?.where((e) =>
                                        e.selectedGameID ==
                                        widget!.selectedGameID)
                                    .toList()
                                    ?.firstOrNull
                                    ?.gameId ==
                                1001) {
                              context.goNamed(
                                GameOneS1Widget.routeName,
                                queryParameters: {
                                  'room': serializeParam(
                                    widget!.room,
                                    ParamType.DocumentReference,
                                  ),
                                }.withoutNulls,
                              );
                            } else {
                              if (_model.presentRoomResult?.selectedGameList
                                      ?.where((e) =>
                                          e.selectedGameID ==
                                          widget!.selectedGameID)
                                      .toList()
                                      ?.firstOrNull
                                      ?.gameId ==
                                  1003) {
                                context.goNamed(
                                  GameFourS1Widget.routeName,
                                  queryParameters: {
                                    'room': serializeParam(
                                      widget!.room,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );
                              }
                            }

                            safeSetState(() {});
                          },
                          text: widget!.topicsQuestions!,
                          options: FFButtonOptions(
                            height: 30.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            iconAlignment: IconAlignment.start,
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFFF18D73),
                            textStyle:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                    ],
                  ),
                  if ((widget!.backButtonStatus == true) &&
                      (widget!.pageTitle == 'GameOne-S1'))
                    FFButtonWidget(
                      onPressed: () async {
                        context.safePop();
                      },
                      text: FFLocalizations.of(context).getText(
                        '298i7q6b' /* Back */,
                      ),
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        height: 30.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        iconAlignment: IconAlignment.start,
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondary,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyLarge.override(
                                  font: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  if ((widget!.backButtonStatus == true) &&
                      (widget!.pageTitle == 'GameOne-S2'))
                    FFButtonWidget(
                      onPressed: () async {
                        context.safePop();
                      },
                      text: FFLocalizations.of(context).getText(
                        'p8b5o3y1' /* Back */,
                      ),
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        height: 30.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        iconAlignment: IconAlignment.start,
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondary,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyLarge.override(
                                  font: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  if ((widget!.backButtonStatus == true) &&
                      (widget!.pageTitle == 'GameOne-S3'))
                    FFButtonWidget(
                      onPressed: () async {
                        context.safePop();
                      },
                      text: FFLocalizations.of(context).getText(
                        '8bvqvhib' /* Back */,
                      ),
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        height: 30.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        iconAlignment: IconAlignment.start,
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondary,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyLarge.override(
                                  font: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  if ((widget!.backButtonStatus == true) &&
                      (widget!.pageTitle == 'Game Two'))
                    FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed(
                          RoomSpaceWidget.routeName,
                          queryParameters: {
                            'room': serializeParam(
                              widget!.room,
                              ParamType.DocumentReference,
                            ),
                          }.withoutNulls,
                        );
                      },
                      text: FFLocalizations.of(context).getText(
                        'z33lbpp4' /* Back */,
                      ),
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        height: 30.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        iconAlignment: IconAlignment.start,
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondary,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyLarge.override(
                                  font: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  if (widget!.presentTeamInfoStatus == true)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 0.5,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 8.0, 12.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                widget!.teamInfo
                                    ?.where((e) =>
                                        e.teamID == widget!.presentTeamID)
                                    .toList()
                                    ?.firstOrNull
                                    ?.teamInfo
                                    ?.name,
                                '???',
                              ).maybeHandleOverflow(
                                maxChars: 8,
                                replacement: '…',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: FFLocalizations.of(context).getText(
                                      '9srytt6t' /* 's */,
                                    ),
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: FFLocalizations.of(context).getText(
                                      'iruzyday' /*  turn */,
                                    ),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  )
                                ],
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
            Expanded(
              child: AuthUserStreamWidget(
                builder: (context) => Text(
                  widget!.pageTitle == ''
                      ? currentUserDisplayName
                      : widget!.pageTitle!,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.almarai(
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(1.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget!.exitButtonStatus == true)
                      Builder(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
                            var _shouldSetState = false;
                            _model.roomResult1 =
                                await RoomRecord.getDocumentOnce(widget!.room!);
                            _shouldSetState = true;
                            if ((_model.roomResult1?.roomCreatedUserRef ==
                                    currentUserReference) ||
                                (_model.roomResult1?.selectedGameList
                                        ?.where((e) =>
                                            e.selectedGameID ==
                                            currentUserDocument
                                                ?.presentRoomGameInfo
                                                ?.roomSelectedGameID)
                                        .toList()
                                        ?.firstOrNull
                                        ?.gameSAUStarterUserref ==
                                    currentUserReference)) {
                              await showDialog(
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
                                        child: GameExitWidget(
                                          room: widget!.room!,
                                          selectedGameID:
                                              widget!.selectedGameID,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              if (_model.roomResult1?.selectedGameList
                                      ?.where((e) =>
                                          e.selectedGameID ==
                                          widget!.selectedGameID)
                                      .toList()
                                      ?.firstOrNull
                                      ?.gameId ==
                                  1001) {
                                var confirmDialogResponse = await showDialog<
                                        bool>(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return WebViewAware(
                                          child: AlertDialog(
                                            title: Text(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              enText: 'Are you sure?',
                                              arText: 'هل أنت متأكد؟',
                                            )),
                                            content: Text(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              enText:
                                                  'are you sure you want to cancel the game?',
                                              arText:
                                                  'هل أنت متأكد أنك تريد إلغاء اللعبة؟',
                                            )),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text(
                                                    FFLocalizations.of(context)
                                                        .getVariableText(
                                                  enText: 'Cancel',
                                                  arText: 'يلغي',
                                                )),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text(
                                                    FFLocalizations.of(context)
                                                        .getVariableText(
                                                  enText: 'Confirm',
                                                  arText: 'يتأكد',
                                                )),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ) ??
                                    false;
                                if (confirmDialogResponse) {
                                  _model.countGameList = _model
                                      .roomResult1?.selectedGameList?.length;
                                  _model.selectedGameList = _model
                                      .roomResult1!.selectedGameList
                                      .toList()
                                      .cast<SelectedGameListStruct>();
                                  while (_model.countGameList! > 0) {
                                    if (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGameList!) - 1)
                                            ?.selectedGameID ==
                                        widget!.selectedGameID) {
                                      _model.countUserList = _model
                                          .selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGameList!) - 1)
                                          ?.selectedGameUserList
                                          ?.length;
                                      _model.selectedUserList = _model
                                          .selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGameList!) - 1)!
                                          .selectedGameUserList
                                          .toList()
                                          .cast<RoomUserListStruct>();
                                      while (_model.countUserList! > 0) {
                                        if (_model.selectedUserList
                                                .elementAtOrNull(
                                                    (_model.countUserList!) - 1)
                                                ?.roomUserRef ==
                                            currentUserReference) {
                                          _model.updateSelectedGameListAtIndex(
                                            (_model.countGameList!) - 1,
                                            (e) => e
                                              ..updateSelectedGameUserList(
                                                (e) => e[
                                                    (_model.countUserList!) - 1]
                                                  ..roomUserUpdatedTime =
                                                      getCurrentTimestamp
                                                  ..roomUserOnlineStatus =
                                                      'deactive',
                                              ),
                                          );
                                          break;
                                        }
                                        _model.countUserList =
                                            (_model.countUserList!) - 1;
                                      }
                                      break;
                                    }
                                    _model.countGameList =
                                        (_model.countGameList!) - 1;
                                  }

                                  await widget!.room!.update({
                                    ...mapToFirestore(
                                      {
                                        'selected_game_list':
                                            getSelectedGameListListFirestoreData(
                                          _model.selectedGameList,
                                        ),
                                      },
                                    ),
                                  });

                                  await FFAppState()
                                      .currentUserRef!
                                      .update(createUsersRecordData(
                                        presentRoomGameInfo:
                                            createPresentRoomGameInfoStruct(
                                                delete: true),
                                      ));

                                  context.goNamed(HomeWidget.routeName);
                                } else {
                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                }
                              } else {
                                if (_model.roomResult1?.selectedGameList
                                        ?.where((e) =>
                                            e.selectedGameID ==
                                            widget!.selectedGameID)
                                        .toList()
                                        ?.firstOrNull
                                        ?.gameId ==
                                    1002) {
                                  var confirmDialogResponse = await showDialog<
                                          bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return WebViewAware(
                                            child: AlertDialog(
                                              title: Text(
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                enText: 'Are you sure?',
                                                arText: 'هل أنت متأكد؟',
                                              )),
                                              content: Text(
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                enText:
                                                    'are you sure you want to cancel the game?',
                                                arText:
                                                    'هل أنت متأكد أنك تريد إلغاء اللعبة؟',
                                              )),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          false),
                                                  child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                    enText: 'Cancel',
                                                    arText: 'يلغي',
                                                  )),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          true),
                                                  child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                    enText: 'Confirm',
                                                    arText: 'يتأكد',
                                                  )),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ) ??
                                      false;
                                  if (confirmDialogResponse) {
                                    _model.countGameList = _model
                                        .roomResult1?.selectedGameList?.length;
                                    _model.selectedGameList = _model
                                        .roomResult1!.selectedGameList
                                        .toList()
                                        .cast<SelectedGameListStruct>();
                                    while (_model.countGameList! > 0) {
                                      if (_model.selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGameList!) - 1)
                                              ?.selectedGameID ==
                                          widget!.selectedGameID) {
                                        _model.countUserList = _model
                                            .selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGameList!) - 1)
                                            ?.selectedGameUserList
                                            ?.length;
                                        _model.selectedUserList = _model
                                            .selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGameList!) - 1)!
                                            .selectedGameUserList
                                            .toList()
                                            .cast<RoomUserListStruct>();
                                        if (_model.roomResult1
                                                ?.roomCreatedUserRef !=
                                            currentUserReference) {
                                          while (_model.countUserList! > 0) {
                                            if (_model.selectedUserList
                                                    .elementAtOrNull((_model
                                                            .countUserList!) -
                                                        1)
                                                    ?.roomUserRef ==
                                                currentUserReference) {
                                              _model
                                                  .updateSelectedGameListAtIndex(
                                                (_model.countGameList!) - 1,
                                                (e) => e
                                                  ..updateSelectedGameUserList(
                                                    (e) => e[(_model
                                                            .countUserList!) -
                                                        1]
                                                      ..roomUserUpdatedTime =
                                                          getCurrentTimestamp
                                                      ..roomUserOnlineStatus =
                                                          'deactive',
                                                  ),
                                              );
                                              break;
                                            }
                                            _model.countUserList =
                                                (_model.countUserList!) - 1;
                                          }
                                          break;
                                        } else {
                                          _model.selectedUserList = [];
                                          break;
                                        }
                                      }
                                      _model.countGameList =
                                          (_model.countGameList!) - 1;
                                    }

                                    await widget!.room!.update({
                                      ...mapToFirestore(
                                        {
                                          'selected_game_list':
                                              getSelectedGameListListFirestoreData(
                                            _model.selectedGameList,
                                          ),
                                        },
                                      ),
                                    });

                                    await FFAppState()
                                        .currentUserRef!
                                        .update(createUsersRecordData(
                                          presentRoomGameInfo:
                                              createPresentRoomGameInfoStruct(
                                                  delete: true),
                                        ));

                                    context.goNamed(HomeWidget.routeName);
                                  } else {
                                    if (_shouldSetState) safeSetState(() {});
                                    return;
                                  }
                                } else {
                                  if (_model.roomResult1?.selectedGameList
                                          ?.where((e) =>
                                              e.selectedGameID ==
                                              widget!.selectedGameID)
                                          .toList()
                                          ?.firstOrNull
                                          ?.gameId ==
                                      1003) {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return WebViewAware(
                                                  child: AlertDialog(
                                                    title: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                      enText: 'Are you sure?',
                                                      arText: 'هل أنت متأكد؟',
                                                    )),
                                                    content: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                      enText:
                                                          'are you sure you want to cancel the game?',
                                                      arText:
                                                          'هل أنت متأكد أنك تريد إلغاء اللعبة؟',
                                                    )),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getVariableText(
                                                          enText: 'Cancel',
                                                          arText: 'يلغي',
                                                        )),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getVariableText(
                                                          enText: 'Confirm',
                                                          arText: 'يتأكد',
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (confirmDialogResponse) {
                                      _model.countGameList = _model.roomResult1
                                          ?.selectedGameList?.length;
                                      _model.selectedGameList = _model
                                          .roomResult1!.selectedGameList
                                          .toList()
                                          .cast<SelectedGameListStruct>();
                                      while (_model.countGameList! > 0) {
                                        if (_model.selectedGameList
                                                .elementAtOrNull(
                                                    (_model.countGameList!) - 1)
                                                ?.selectedGameID ==
                                            widget!.selectedGameID) {
                                          _model.countUserList = _model
                                              .selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGameList!) - 1)
                                              ?.selectedGameUserList
                                              ?.length;
                                          _model.selectedUserList = _model
                                              .selectedGameList
                                              .elementAtOrNull(
                                                  (_model.countGameList!) - 1)!
                                              .selectedGameUserList
                                              .toList()
                                              .cast<RoomUserListStruct>();
                                          while (_model.countUserList! > 0) {
                                            if (_model.selectedUserList
                                                    .elementAtOrNull((_model
                                                            .countUserList!) -
                                                        1)
                                                    ?.roomUserRef ==
                                                currentUserReference) {
                                              _model
                                                  .updateSelectedGameListAtIndex(
                                                (_model.countGameList!) - 1,
                                                (e) => e
                                                  ..updateSelectedGameUserList(
                                                    (e) => e[(_model
                                                            .countUserList!) -
                                                        1]
                                                      ..roomUserUpdatedTime =
                                                          getCurrentTimestamp
                                                      ..roomUserOnlineStatus =
                                                          'deactive',
                                                  ),
                                              );
                                              break;
                                            }
                                            _model.countUserList =
                                                (_model.countUserList!) - 1;
                                          }
                                          break;
                                        }
                                        _model.countGameList =
                                            (_model.countGameList!) - 1;
                                      }

                                      await widget!.room!.update({
                                        ...mapToFirestore(
                                          {
                                            'selected_game_list':
                                                getSelectedGameListListFirestoreData(
                                              _model.selectedGameList,
                                            ),
                                          },
                                        ),
                                      });

                                      await FFAppState()
                                          .currentUserRef!
                                          .update(createUsersRecordData(
                                            presentRoomGameInfo:
                                                createPresentRoomGameInfoStruct(
                                                    delete: true),
                                          ));

                                      context.goNamed(HomeWidget.routeName);
                                    } else {
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }
                                  } else {
                                    if (_model.roomResult1?.selectedGameList
                                            ?.where((e) =>
                                                e.selectedGameID ==
                                                widget!.selectedGameID)
                                            .toList()
                                            ?.firstOrNull
                                            ?.gameId ==
                                        1004) {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return WebViewAware(
                                                    child: AlertDialog(
                                                      title: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getVariableText(
                                                        enText: 'Are you sure?',
                                                        arText: 'هل أنت متأكد؟',
                                                      )),
                                                      content: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getVariableText(
                                                        enText:
                                                            'are you sure you want to cancel the game?',
                                                        arText:
                                                            'هل أنت متأكد أنك تريد إلغاء اللعبة؟',
                                                      )),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  false),
                                                          child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getVariableText(
                                                            enText: 'Cancel',
                                                            arText: 'يلغي',
                                                          )),
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  true),
                                                          child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getVariableText(
                                                            enText: 'Confirm',
                                                            arText: 'يتأكد',
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ) ??
                                              false;
                                      if (confirmDialogResponse) {
                                        await FFAppState()
                                            .currentUserRef!
                                            .update(createUsersRecordData(
                                              presentRoomGameInfo:
                                                  createPresentRoomGameInfoStruct(
                                                      delete: true),
                                            ));

                                        context.goNamed(HomeWidget.routeName);
                                      } else {
                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      }
                                    }
                                  }
                                }
                              }
                            }

                            if (_shouldSetState) safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'uodcig6l' /* Exit Game */,
                          ),
                          icon: Icon(
                            FFIcons.kfi8,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: 30.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            iconAlignment: IconAlignment.end,
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ].divide(SizedBox(width: 8.0)),
        ),
      ],
    );
  }
}
