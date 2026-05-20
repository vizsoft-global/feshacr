import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'game_team_user_model.dart';
export 'game_team_user_model.dart';

class GameTeamUserWidget extends StatefulWidget {
  const GameTeamUserWidget({
    super.key,
    this.teamInfo,
    bool? workStatus,
    this.selectedGameID,
    this.room,
    bool? doubleHelpLineStatus,
    required this.presentTeamID,
    required this.selectedGameIndex,
    bool? helpLineStatus,
    required this.index,
  })  : this.workStatus = workStatus ?? false,
        this.doubleHelpLineStatus = doubleHelpLineStatus ?? false,
        this.helpLineStatus = helpLineStatus ?? false;

  final TeamInfoStruct? teamInfo;
  final bool workStatus;
  final int? selectedGameID;
  final RoomRecord? room;
  final bool doubleHelpLineStatus;
  final int? presentTeamID;
  final int? selectedGameIndex;
  final bool helpLineStatus;
  final int? index;

  @override
  State<GameTeamUserWidget> createState() => _GameTeamUserWidgetState();
}

class _GameTeamUserWidgetState extends State<GameTeamUserWidget> {
  late GameTeamUserModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameTeamUserModel());

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

    return Container(
      decoration: BoxDecoration(
        color: widget!.room!.selectedGameList
                    .elementAtOrNull(widget!.selectedGameIndex!)!
                    .teamInfo
                    .where((e) => e.teamID == 999)
                    .toList()
                    .length >
                0
            ? (widget!.teamInfo?.teamID == 999
                ? FlutterFlowTheme.of(context).primaryText
                : FlutterFlowTheme.of(context).tertiary)
            : valueOrDefault<Color>(
                () {
                  if (widget!.index == 0) {
                    return (widget!.presentTeamID == widget!.teamInfo?.teamID
                        ? FlutterFlowTheme.of(context).primary
                        : Color(0x2EEC4D41));
                  } else if (widget!.index == 1) {
                    return (widget!.presentTeamID == widget!.teamInfo?.teamID
                        ? FlutterFlowTheme.of(context).secondary
                        : Color(0x533696D0));
                  } else {
                    return (widget!.presentTeamID == widget!.teamInfo?.teamID
                        ? FlutterFlowTheme.of(context).tertiary
                        : Color(0x5467B5B0));
                  }
                }(),
                FlutterFlowTheme.of(context).secondary,
              ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primaryText,
          width: widget!.teamInfo?.teamID == 999
              ? 0.5
              : (widget!.presentTeamID == widget!.teamInfo?.teamID
                  ? 1.0
                  : 0.25),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                  tabletLandscape: false,
                  desktop: false,
                ))
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: Color(0x4DFFFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        () {
                          if (widget!.index == 0) {
                            return FFLocalizations.of(context).getVariableText(
                              enText: 'A',
                              arText: 'أ',
                            );
                          } else if (widget!.index == 1) {
                            return FFLocalizations.of(context).getVariableText(
                              enText: 'B',
                              arText: 'ب',
                            );
                          } else {
                            return FFLocalizations.of(context).getVariableText(
                              enText: 'C',
                              arText: 'جأ',
                            );
                          }
                        }(),
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.almarai(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${FFLocalizations.of(context).getVariableText(
                          enText: 'Team',
                          arText: 'فريق',
                        )} ${() {
                          if (widget!.index == 0) {
                            return FFLocalizations.of(context).getVariableText(
                              enText: 'A',
                              arText: 'أ',
                            );
                          } else if (widget!.index == 1) {
                            return FFLocalizations.of(context).getVariableText(
                              enText: 'B',
                              arText: 'ب',
                            );
                          } else {
                            return FFLocalizations.of(context).getVariableText(
                              enText: 'C',
                              arText: 'ج',
                            );
                          }
                        }()}',
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.almarai(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontStyle,
                              ),
                              color: widget!.room!.selectedGameList
                                          .elementAtOrNull(
                                              widget!.selectedGameIndex!)!
                                          .teamInfo
                                          .where((e) => e.teamID == 999)
                                          .toList()
                                          .length >
                                      0
                                  ? (widget!.teamInfo?.teamID == 999
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBackground
                                      : FlutterFlowTheme.of(context)
                                          .primaryText)
                                  : valueOrDefault<Color>(
                                      () {
                                        if (widget!.index == 0) {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        } else if (widget!.index == 1) {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        } else {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        }
                                      }(),
                                      FlutterFlowTheme.of(context).secondary,
                                    ),
                              fontSize: 10.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                      ),
                      Text(
                        widget!.teamInfo!.teamInfo.name.maybeHandleOverflow(
                          maxChars: 8,
                          replacement: '…',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.almarai(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: widget!.room!.selectedGameList
                                          .elementAtOrNull(
                                              widget!.selectedGameIndex!)!
                                          .teamInfo
                                          .where((e) => e.teamID == 999)
                                          .toList()
                                          .length >
                                      0
                                  ? (widget!.teamInfo?.teamID == 999
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBackground
                                      : FlutterFlowTheme.of(context)
                                          .primaryText)
                                  : valueOrDefault<Color>(
                                      () {
                                        if (widget!.index == 0) {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        } else if (widget!.index == 1) {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        } else {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        }
                                      }(),
                                      FlutterFlowTheme.of(context).secondary,
                                    ),
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
                Container(
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: Color(0x4CFFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 2.0, 8.0, 2.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'dtbnq1a0' /* Score */,
                          ),
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
                                color: widget!.room!.selectedGameList
                                            .elementAtOrNull(
                                                widget!.selectedGameIndex!)!
                                            .teamInfo
                                            .where((e) => e.teamID == 999)
                                            .toList()
                                            .length >
                                        0
                                    ? (widget!.teamInfo?.teamID == 999
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryText)
                                    : valueOrDefault<Color>(
                                        () {
                                          if (widget!.index == 0) {
                                            return (widget!.presentTeamID ==
                                                    widget!.teamInfo?.teamID
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryText
                                                : Color(0x7FFFFFFF));
                                          } else if (widget!.index == 1) {
                                            return (widget!.presentTeamID ==
                                                    widget!.teamInfo?.teamID
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryText
                                                : Color(0x7FFFFFFF));
                                          } else {
                                            return (widget!.presentTeamID ==
                                                    widget!.teamInfo?.teamID
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryText
                                                : Color(0x7FFFFFFF));
                                          }
                                        }(),
                                        FlutterFlowTheme.of(context).secondary,
                                      ),
                                fontSize: 10.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (widget!.workStatus == true) {
                                  if (widget!.room?.roomCreatedUserRef !=
                                      currentUserReference) {
                                    return;
                                  }
                                  _model.countGame =
                                      widget!.room?.selectedGameList?.length;
                                  _model.selectedGameList = widget!
                                      .room!.selectedGameList
                                      .toList()
                                      .cast<SelectedGameListStruct>();
                                  while (_model.countGame! > 0) {
                                    if (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.selectedGameID ==
                                        widget!.selectedGameID) {
                                      _model.countTeam = _model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)
                                          ?.teamInfo
                                          ?.length;
                                      _model.selectedTeamList = _model
                                          .selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .teamInfo
                                          .toList()
                                          .cast<TeamInfoStruct>();
                                      while (_model.countTeam! > 0) {
                                        if (_model.selectedTeamList
                                                .elementAtOrNull(
                                                    (_model.countTeam!) - 1)
                                                ?.teamID ==
                                            widget!.teamInfo?.teamID) {
                                          _model.point =
                                              widget!.teamInfo!.totalResult -
                                                  50;
                                          _model.updateSelectedGameListAtIndex(
                                            (_model.countGame!) - 1,
                                            (e) => e
                                              ..updateTeamInfo(
                                                (e) =>
                                                    e[(_model.countTeam!) - 1]
                                                      ..totalResult =
                                                          _model.point,
                                              ),
                                          );

                                          await widget!.room!.reference.update({
                                            ...mapToFirestore(
                                              {
                                                'selected_game_list':
                                                    getSelectedGameListListFirestoreData(
                                                  _model.selectedGameList,
                                                ),
                                              },
                                            ),
                                          });
                                          return;
                                        }
                                        _model.countTeam =
                                            (_model.countTeam!) - 1;
                                      }
                                    }
                                    _model.countGame = (_model.countGame!) - 1;
                                  }
                                }
                              },
                              child: Icon(
                                Icons.remove_rounded,
                                color: widget!.room!.selectedGameList
                                            .elementAtOrNull(
                                                widget!.selectedGameIndex!)!
                                            .teamInfo
                                            .where((e) => e.teamID == 999)
                                            .toList()
                                            .length >
                                        0
                                    ? (widget!.teamInfo?.teamID == 999
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryText)
                                    : valueOrDefault<Color>(
                                        () {
                                          if (widget!.index == 0) {
                                            return (widget!.presentTeamID ==
                                                    widget!.teamInfo?.teamID
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryText
                                                : Color(0x7FFFFFFF));
                                          } else if (widget!.index == 1) {
                                            return (widget!.presentTeamID ==
                                                    widget!.teamInfo?.teamID
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryText
                                                : Color(0x7FFFFFFF));
                                          } else {
                                            return (widget!.presentTeamID ==
                                                    widget!.teamInfo?.teamID
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryText
                                                : Color(0x7FFFFFFF));
                                          }
                                        }(),
                                        FlutterFlowTheme.of(context).secondary,
                                      ),
                                size: 16.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 4.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget!.teamInfo?.totalResult?.toString(),
                                  '0',
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
                                      color: widget!.room!.selectedGameList
                                                  .elementAtOrNull(widget!
                                                      .selectedGameIndex!)!
                                                  .teamInfo
                                                  .where((e) => e.teamID == 999)
                                                  .toList()
                                                  .length >
                                              0
                                          ? (widget!.teamInfo?.teamID == 999
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryBackground
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText)
                                          : valueOrDefault<Color>(
                                              () {
                                                if (widget!.index == 0) {
                                                  return (widget!
                                                              .presentTeamID ==
                                                          widget!
                                                              .teamInfo?.teamID
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText
                                                      : Color(0x7FFFFFFF));
                                                } else if (widget!.index == 1) {
                                                  return (widget!
                                                              .presentTeamID ==
                                                          widget!
                                                              .teamInfo?.teamID
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText
                                                      : Color(0x7FFFFFFF));
                                                } else {
                                                  return (widget!
                                                              .presentTeamID ==
                                                          widget!
                                                              .teamInfo?.teamID
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText
                                                      : Color(0x7FFFFFFF));
                                                }
                                              }(),
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                            ),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (widget!.workStatus == true) {
                                  if (widget!.room?.roomCreatedUserRef !=
                                      currentUserReference) {
                                    return;
                                  }
                                  _model.countGame =
                                      widget!.room?.selectedGameList?.length;
                                  _model.selectedGameList = widget!
                                      .room!.selectedGameList
                                      .toList()
                                      .cast<SelectedGameListStruct>();
                                  while (_model.countGame! > 0) {
                                    if (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.selectedGameID ==
                                        widget!.selectedGameID) {
                                      _model.countTeam = _model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)
                                          ?.teamInfo
                                          ?.length;
                                      _model.selectedTeamList = _model
                                          .selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .teamInfo
                                          .toList()
                                          .cast<TeamInfoStruct>();
                                      while (_model.countTeam! > 0) {
                                        if (_model.selectedTeamList
                                                .elementAtOrNull(
                                                    (_model.countTeam!) - 1)
                                                ?.teamID ==
                                            widget!.teamInfo?.teamID) {
                                          _model.point =
                                              widget!.teamInfo!.totalResult +
                                                  50;
                                          _model.updateSelectedGameListAtIndex(
                                            (_model.countGame!) - 1,
                                            (e) => e
                                              ..updateTeamInfo(
                                                (e) =>
                                                    e[(_model.countTeam!) - 1]
                                                      ..totalResult =
                                                          _model.point,
                                              ),
                                          );

                                          await widget!.room!.reference.update({
                                            ...mapToFirestore(
                                              {
                                                'selected_game_list':
                                                    getSelectedGameListListFirestoreData(
                                                  _model.selectedGameList,
                                                ),
                                              },
                                            ),
                                          });
                                          return;
                                        }
                                        _model.countTeam =
                                            (_model.countTeam!) - 1;
                                      }
                                    }
                                    _model.countGame = (_model.countGame!) - 1;
                                  }
                                }
                              },
                              child: Icon(
                                Icons.add,
                                color: widget!.room!.selectedGameList
                                            .elementAtOrNull(
                                                widget!.selectedGameIndex!)!
                                            .teamInfo
                                            .where((e) => e.teamID == 999)
                                            .toList()
                                            .length >
                                        0
                                    ? (widget!.teamInfo?.teamID == 999
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryText)
                                    : valueOrDefault<Color>(
                                        () {
                                          if (widget!.index == 0) {
                                            return (widget!.presentTeamID ==
                                                    widget!.teamInfo?.teamID
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryText
                                                : Color(0x7FFFFFFF));
                                          } else if (widget!.index == 1) {
                                            return (widget!.presentTeamID ==
                                                    widget!.teamInfo?.teamID
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryText
                                                : Color(0x7FFFFFFF));
                                          } else {
                                            return (widget!.presentTeamID ==
                                                    widget!.teamInfo?.teamID
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryText
                                                : Color(0x7FFFFFFF));
                                          }
                                        }(),
                                        FlutterFlowTheme.of(context).secondary,
                                      ),
                                size: 16.0,
                              ),
                            ),
                          ].divide(SizedBox(width: 16.0)),
                        ),
                      ],
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if ((widget!.helpLineStatus == true) &&
                        (widget!.teamInfo?.teamID != 999))
                      FFButtonWidget(
                        onPressed: () async {
                          if (widget!.room?.roomCreatedUserRef ==
                              currentUserReference) {
                            if (FFAppState().helpLineStatus == true) {
                              if (widget!.workStatus == true) {
                                var confirmDialogResponse = await showDialog<
                                        bool>(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return WebViewAware(
                                          child: AlertDialog(
                                            content: Text(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              enText:
                                                  'Do you want to use this helpline?',
                                              arText:
                                                  'هل تريد استخدام خط المساعدة هذا؟',
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
                                  _model.countGame =
                                      widget!.room?.selectedGameList?.length;
                                  _model.selectedGameList = widget!
                                      .room!.selectedGameList
                                      .toList()
                                      .cast<SelectedGameListStruct>();
                                  while (_model.countGame! > 0) {
                                    if (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.selectedGameID ==
                                        widget!.selectedGameID) {
                                      _model.countTeam = _model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)
                                          ?.teamInfo
                                          ?.length;
                                      _model.selectedTeamList = _model
                                          .selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .teamInfo
                                          .toList()
                                          .cast<TeamInfoStruct>();
                                      while (_model.countTeam! > 0) {
                                        if (_model.selectedTeamList
                                                .elementAtOrNull(
                                                    (_model.countTeam!) - 1)
                                                ?.teamID ==
                                            widget!.teamInfo?.teamID) {
                                          _model.updateSelectedGameListAtIndex(
                                            (_model.countGame!) - 1,
                                            (e) => e
                                              ..updateTeamInfo(
                                                (e) =>
                                                    e[(_model.countTeam!) - 1]
                                                      ..helpLineCall = true,
                                              ),
                                          );

                                          await widget!.room!.reference.update({
                                            ...mapToFirestore(
                                              {
                                                'selected_game_list':
                                                    getSelectedGameListListFirestoreData(
                                                  _model.selectedGameList,
                                                ),
                                              },
                                            ),
                                          });
                                          return;
                                        }
                                        _model.countTeam =
                                            (_model.countTeam!) - 1;
                                      }
                                    }
                                    _model.countGame = (_model.countGame!) - 1;
                                  }
                                } else {
                                  return;
                                }
                              }
                            }
                          } else {
                            return;
                          }
                        },
                        text: FFLocalizations.of(context).getText(
                          '58cn4lxp' /* Call */,
                        ),
                        icon: Icon(
                          FFIcons.kfi30,
                          size: 10.0,
                        ),
                        options: FFButtonOptions(
                          height: 30.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          iconPadding: EdgeInsets.all(0.0),
                          iconColor: !widget!.teamInfo!.helpLineCall
                              ? (widget!.room!.selectedGameList
                                          .elementAtOrNull(
                                              widget!.selectedGameIndex!)!
                                          .teamInfo
                                          .where((e) => e.teamID == 999)
                                          .toList()
                                          .length >
                                      0
                                  ? (widget!.teamInfo?.teamID == 999
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBackground
                                      : FlutterFlowTheme.of(context)
                                          .primaryText)
                                  : valueOrDefault<Color>(
                                      () {
                                        if (widget!.index == 0) {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        } else if (widget!.index == 1) {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        } else {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        }
                                      }(),
                                      FlutterFlowTheme.of(context).secondary,
                                    ))
                              : Color(0x70FFFFFF),
                          color: !widget!.teamInfo!.helpLineCall
                              ? Color(0x5AFFFFFF)
                              : Color(0x40FFFFFF),
                          textStyle: FlutterFlowTheme.of(context)
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
                                color: !widget!.teamInfo!.helpLineCall
                                    ? (widget!.room!.selectedGameList
                                                .elementAtOrNull(
                                                    widget!.selectedGameIndex!)!
                                                .teamInfo
                                                .where((e) => e.teamID == 999)
                                                .toList()
                                                .length >
                                            0
                                        ? (widget!.teamInfo?.teamID == 999
                                            ? FlutterFlowTheme.of(context)
                                                .primaryBackground
                                            : FlutterFlowTheme.of(context)
                                                .primaryText)
                                        : valueOrDefault<Color>(
                                            () {
                                              if (widget!.index == 0) {
                                                return (widget!.presentTeamID ==
                                                        widget!.teamInfo?.teamID
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : Color(0x7FFFFFFF));
                                              } else if (widget!.index == 1) {
                                                return (widget!.presentTeamID ==
                                                        widget!.teamInfo?.teamID
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : Color(0x7FFFFFFF));
                                              } else {
                                                return (widget!.presentTeamID ==
                                                        widget!.teamInfo?.teamID
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : Color(0x7FFFFFFF));
                                              }
                                            }(),
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                          ))
                                    : Color(0x80FFFFFF),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    if ((widget!.doubleHelpLineStatus == true) &&
                        (widget!.teamInfo?.teamID != 999))
                      FFButtonWidget(
                        onPressed: () async {
                          if (widget!.room?.roomCreatedUserRef ==
                              currentUserReference) {
                            if (FFAppState().helpLineStatus == true) {
                              if (widget!.workStatus == true) {
                                var confirmDialogResponse = await showDialog<
                                        bool>(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return WebViewAware(
                                          child: AlertDialog(
                                            content: Text(
                                                FFLocalizations.of(context)
                                                    .getVariableText(
                                              enText:
                                                  'Do you want to use this helpline?',
                                              arText:
                                                  'هل تريد استخدام خط المساعدة هذا؟',
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
                                  _model.countGame =
                                      widget!.room?.selectedGameList?.length;
                                  _model.selectedGameList = widget!
                                      .room!.selectedGameList
                                      .toList()
                                      .cast<SelectedGameListStruct>();
                                  while (_model.countGame! > 0) {
                                    if (_model.selectedGameList
                                            .elementAtOrNull(
                                                (_model.countGame!) - 1)
                                            ?.selectedGameID ==
                                        widget!.selectedGameID) {
                                      _model.countTeam = _model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)
                                          ?.teamInfo
                                          ?.length;
                                      _model.selectedTeamList = _model
                                          .selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)!
                                          .teamInfo
                                          .toList()
                                          .cast<TeamInfoStruct>();
                                      while (_model.countTeam! > 0) {
                                        if (_model.selectedTeamList
                                                .elementAtOrNull(
                                                    (_model.countTeam!) - 1)
                                                ?.teamID ==
                                            widget!.teamInfo?.teamID) {
                                          _model.updateSelectedGameListAtIndex(
                                            (_model.countGame!) - 1,
                                            (e) => e
                                              ..updateTeamInfo(
                                                (e) =>
                                                    e[(_model.countTeam!) - 1]
                                                      ..helpLineDouble = true,
                                              ),
                                          );

                                          await widget!.room!.reference.update({
                                            ...mapToFirestore(
                                              {
                                                'selected_game_list':
                                                    getSelectedGameListListFirestoreData(
                                                  _model.selectedGameList,
                                                ),
                                              },
                                            ),
                                          });
                                          return;
                                        }
                                        _model.countTeam =
                                            (_model.countTeam!) - 1;
                                      }
                                    }
                                    _model.countGame = (_model.countGame!) - 1;
                                  }
                                } else {
                                  return;
                                }
                              }
                            }
                          } else {
                            return;
                          }
                        },
                        text: FFLocalizations.of(context).getText(
                          '9wzpdl4v' /* Double */,
                        ),
                        icon: Icon(
                          FFIcons.kfi5,
                          size: 10.0,
                        ),
                        options: FFButtonOptions(
                          height: 30.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 4.0, 0.0),
                          iconColor: !widget!.teamInfo!.helpLineDouble
                              ? (widget!.room!.selectedGameList
                                          .elementAtOrNull(
                                              widget!.selectedGameIndex!)!
                                          .teamInfo
                                          .where((e) => e.teamID == 999)
                                          .toList()
                                          .length >
                                      0
                                  ? (widget!.teamInfo?.teamID == 999
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBackground
                                      : FlutterFlowTheme.of(context)
                                          .primaryText)
                                  : valueOrDefault<Color>(
                                      () {
                                        if (widget!.index == 0) {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        } else if (widget!.index == 1) {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        } else {
                                          return (widget!.presentTeamID ==
                                                  widget!.teamInfo?.teamID
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : Color(0x7FFFFFFF));
                                        }
                                      }(),
                                      FlutterFlowTheme.of(context).secondary,
                                    ))
                              : Color(0x6FFFFFFF),
                          color: !widget!.teamInfo!.helpLineDouble
                              ? Color(0x5AFFFFFF)
                              : Color(0x40FFFFFF),
                          textStyle: FlutterFlowTheme.of(context)
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
                                color: !widget!.teamInfo!.helpLineDouble
                                    ? (widget!.room!.selectedGameList
                                                .elementAtOrNull(
                                                    widget!.selectedGameIndex!)!
                                                .teamInfo
                                                .where((e) => e.teamID == 999)
                                                .toList()
                                                .length >
                                            0
                                        ? (widget!.teamInfo?.teamID == 999
                                            ? FlutterFlowTheme.of(context)
                                                .primaryBackground
                                            : FlutterFlowTheme.of(context)
                                                .primaryText)
                                        : valueOrDefault<Color>(
                                            () {
                                              if (widget!.index == 0) {
                                                return (widget!.presentTeamID ==
                                                        widget!.teamInfo?.teamID
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : Color(0x7FFFFFFF));
                                              } else if (widget!.index == 1) {
                                                return (widget!.presentTeamID ==
                                                        widget!.teamInfo?.teamID
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : Color(0x7FFFFFFF));
                                              } else {
                                                return (widget!.presentTeamID ==
                                                        widget!.teamInfo?.teamID
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : Color(0x7FFFFFFF));
                                              }
                                            }(),
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                          ))
                                    : Color(0x7FFFFFFF),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    if ((widget!.helpLineStatus == true) &&
                        responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                      FFButtonWidget(
                        onPressed: () async {
                          if (FFAppState().helpLineStatus == true) {
                            if (widget!.workStatus == true) {
                              if (widget!.room?.roomCreatedUserRef !=
                                  currentUserReference) {
                                return;
                              }
                              var confirmDialogResponse = await showDialog<
                                      bool>(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          content: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                            enText:
                                                'Do you want to use this helpline?',
                                            arText:
                                                'هل تريد استخدام خط المساعدة هذا؟',
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
                                _model.countGame =
                                    widget!.room?.selectedGameList?.length;
                                _model.selectedGameList = widget!
                                    .room!.selectedGameList
                                    .toList()
                                    .cast<SelectedGameListStruct>();
                                while (_model.countGame! > 0) {
                                  if (_model.selectedGameList
                                          .elementAtOrNull(
                                              (_model.countGame!) - 1)
                                          ?.selectedGameID ==
                                      widget!.selectedGameID) {
                                    _model.countTeam = _model.selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)
                                        ?.teamInfo
                                        ?.length;
                                    _model.selectedTeamList = _model
                                        .selectedGameList
                                        .elementAtOrNull(
                                            (_model.countGame!) - 1)!
                                        .teamInfo
                                        .toList()
                                        .cast<TeamInfoStruct>();
                                    while (_model.countTeam! > 0) {
                                      if (_model.selectedTeamList
                                              .elementAtOrNull(
                                                  (_model.countTeam!) - 1)
                                              ?.teamID ==
                                          widget!.teamInfo?.teamID) {
                                        _model.updateSelectedGameListAtIndex(
                                          (_model.countGame!) - 1,
                                          (e) => e
                                            ..updateTeamInfo(
                                              (e) => e[(_model.countTeam!) - 1]
                                                ..helpLineSwap = true,
                                            ),
                                        );

                                        await widget!.room!.reference.update({
                                          ...mapToFirestore(
                                            {
                                              'selected_game_list':
                                                  getSelectedGameListListFirestoreData(
                                                _model.selectedGameList,
                                              ),
                                            },
                                          ),
                                        });
                                        return;
                                      }
                                      _model.countTeam =
                                          (_model.countTeam!) - 1;
                                    }
                                  }
                                  _model.countGame = (_model.countGame!) - 1;
                                }
                              } else {
                                return;
                              }
                            }
                          }
                        },
                        text: FFLocalizations.of(context).getText(
                          'eja4lspy' /* Swap */,
                        ),
                        icon: Icon(
                          FFIcons.kfi7,
                          size: 10.0,
                        ),
                        options: FFButtonOptions(
                          height: 30.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          iconPadding: EdgeInsets.all(0.0),
                          iconColor: !widget!.teamInfo!.helpLineSwap
                              ? FlutterFlowTheme.of(context).primaryBackground
                              : Color(0x33FFFFFF),
                          color: !widget!.teamInfo!.helpLineSwap
                              ? Color(0x58FFFFFF)
                              : Color(0x40FFFFFF),
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.almarai(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: !widget!.teamInfo!.helpLineSwap
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : Color(0x55FFFFFF),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                  ].divide(SizedBox(width: 4.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
