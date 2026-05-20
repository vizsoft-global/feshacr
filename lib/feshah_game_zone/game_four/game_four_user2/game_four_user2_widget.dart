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
import 'game_four_user2_model.dart';
export 'game_four_user2_model.dart';

class GameFourUser2Widget extends StatefulWidget {
  const GameFourUser2Widget({
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
  State<GameFourUser2Widget> createState() => _GameFourUser2WidgetState();
}

class _GameFourUser2WidgetState extends State<GameFourUser2Widget> {
  late GameFourUser2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFourUser2Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: () {
          if (widget!.index == 0) {
            return (widget!.presentTeamID == widget!.teamInfo?.teamID
                ? FlutterFlowTheme.of(context).tertiary
                : Color(0x5567B5B0));
          } else if (widget!.index == 1) {
            return (widget!.presentTeamID == widget!.teamInfo?.teamID
                ? FlutterFlowTheme.of(context).secondary
                : Color(0x533696D0));
          } else {
            return (widget!.presentTeamID == widget!.teamInfo?.teamID
                ? FlutterFlowTheme.of(context).primary
                : Color(0x51EC4D41));
          }
        }(),
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
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                          fontStyle:
                              FlutterFlowTheme.of(context).labelSmall.fontStyle,
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
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : FlutterFlowTheme.of(context).primaryText)
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
                        fontWeight:
                            FlutterFlowTheme.of(context).labelSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelSmall.fontStyle,
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : FlutterFlowTheme.of(context).primaryText)
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
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ].divide(SizedBox(height: 2.0)),
            ),
            Container(
              height: 40.0,
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
                        'd7pb2lrw' /* Score */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                    : FlutterFlowTheme.of(context).primaryText)
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
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.length;
                                  _model.selectedTeamList = _model
                                      .selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)!
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
                                          widget!.teamInfo!.totalResult - 1;
                                      _model.updateSelectedGameListAtIndex(
                                        (_model.countGame!) - 1,
                                        (e) => e
                                          ..updateTeamInfo(
                                            (e) => e[(_model.countTeam!) - 1]
                                              ..totalResult = _model.point,
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
                                    _model.countTeam = (_model.countTeam!) - 1;
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
                                    : FlutterFlowTheme.of(context).primaryText)
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
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                        ),
                                  fontSize: 18.0,
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
                                      .elementAtOrNull((_model.countGame!) - 1)
                                      ?.teamInfo
                                      ?.length;
                                  _model.selectedTeamList = _model
                                      .selectedGameList
                                      .elementAtOrNull((_model.countGame!) - 1)!
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
                                          widget!.teamInfo!.totalResult + 1;
                                      _model.updateSelectedGameListAtIndex(
                                        (_model.countGame!) - 1,
                                        (e) => e
                                          ..updateTeamInfo(
                                            (e) => e[(_model.countTeam!) - 1]
                                              ..totalResult = _model.point,
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
                                    _model.countTeam = (_model.countTeam!) - 1;
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
                                    : FlutterFlowTheme.of(context).primaryText)
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
          ].divide(SizedBox(height: 8.0)),
        ),
      ),
    );
  }
}
