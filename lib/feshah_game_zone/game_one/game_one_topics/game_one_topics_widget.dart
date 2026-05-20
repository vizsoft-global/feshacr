import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_one_topics_model.dart';
export 'game_one_topics_model.dart';

class GameOneTopicsWidget extends StatefulWidget {
  const GameOneTopicsWidget({
    super.key,
    this.selectedGameID,
    this.room,
    required this.gameID,
    required this.topicID,
  });

  final int? selectedGameID;
  final RoomRecord? room;
  final int? gameID;
  final int? topicID;

  @override
  State<GameOneTopicsWidget> createState() => _GameOneTopicsWidgetState();
}

class _GameOneTopicsWidgetState extends State<GameOneTopicsWidget> {
  late GameOneTopicsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameOneTopicsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: StreamBuilder<List<TopicQuestionRecord>>(
                stream: queryTopicQuestionRecord(
                  queryBuilder: (topicQuestionRecord) => topicQuestionRecord
                      .where(
                        'topic_id',
                        isEqualTo: widget!.topicID,
                      )
                      .where(
                        'question_status',
                        isEqualTo: 'active',
                      ),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 2.0,
                        height: 2.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0x00EC4D41),
                          ),
                        ),
                      ),
                    );
                  }
                  List<TopicQuestionRecord> containerTopicQuestionRecordList =
                      snapshot.data!;

                  return Container(
                    decoration: BoxDecoration(),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: Stack(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          final quetion400A = containerTopicQuestionRecordList
                                              .where((e) =>
                                                  (e.questionPoint == 200) &&
                                                  ((widget!.room?.roomAttendedQuestionList?.contains(e.questionID) ==
                                                          false) ||
                                                      (widget!.room?.selectedGameList?.where((e) => e.selectedGameID == widget!.selectedGameID).toList()?.firstOrNull?.selectedQuestionIDList?.contains(
                                                              e.questionID) ==
                                                          true)))
                                              .toList()
                                              .sortedList(
                                                  keyOf: (e) => e.questionID,
                                                  desc: false)
                                              .take(widget!.room?.selectedGameList
                                                          ?.where((e) =>
                                                              e.selectedGameID ==
                                                              widget!.selectedGameID)
                                                          .toList()
                                                          ?.firstOrNull
                                                          ?.selectedTopicIDList
                                                          ?.length ==
                                                      3
                                                  ? 2
                                                  : 1)
                                              .toList();

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                quetion400A.length,
                                                (quetion400AIndex) {
                                              final quetion400AItem =
                                                  quetion400A[quetion400AIndex];
                                              return Expanded(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.countGameList = null;
                                                    _model.selectedGameList =
                                                        [];
                                                    _model.questionStatus =
                                                        null;
                                                    _model.countTopicList =
                                                        null;
                                                    _model.selectedTopicList =
                                                        [];
                                                    _model.countQuestionList =
                                                        null;
                                                    _model.selectedQuestionList =
                                                        [];
                                                    _model.countGameList =
                                                        widget!
                                                            .room
                                                            ?.selectedGameList
                                                            ?.length;
                                                    _model.selectedGameList =
                                                        widget!.room!
                                                            .selectedGameList
                                                            .toList()
                                                            .cast<
                                                                SelectedGameListStruct>();
                                                    _model.questionStatus =
                                                        'notFound';
                                                    while (
                                                        _model.countGameList! >
                                                            0) {
                                                      if (_model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGameList!) -
                                                                      1)
                                                              ?.selectedGameID ==
                                                          widget!
                                                              .selectedGameID) {
                                                        _model.countQuestionList = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGameList!) -
                                                                    1)
                                                            ?.selectedQuestionList
                                                            ?.length;
                                                        _model.selectedQuestionList = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGameList!) -
                                                                    1)!
                                                            .selectedQuestionList
                                                            .toList()
                                                            .cast<
                                                                SelectedQuestionListStruct>();
                                                        while (_model
                                                                .countQuestionList! >
                                                            0) {
                                                          if (_model
                                                                  .selectedQuestionList
                                                                  .elementAtOrNull(
                                                                      (_model.countQuestionList!) -
                                                                          1)
                                                                  ?.questionID ==
                                                              quetion400AItem
                                                                  .questionID) {
                                                            if (_model
                                                                    .selectedQuestionList
                                                                    .elementAtOrNull(
                                                                        (_model.countQuestionList!) -
                                                                            1)
                                                                    ?.questionAnswerStatus ==
                                                                'hide') {
                                                              _model
                                                                  .updateSelectedGameListAtIndex(
                                                                (_model.countGameList!) -
                                                                    1,
                                                                (e) => e
                                                                  ..updateSelectedQuestionList(
                                                                    (e) => e.removeAt(
                                                                        (_model.countQuestionList!) -
                                                                            1),
                                                                  ),
                                                              );
                                                              _model
                                                                  .updateSelectedGameListAtIndex(
                                                                (_model.countGameList!) -
                                                                    1,
                                                                (e) => e
                                                                  ..updateSelectedQuestionList(
                                                                    (e) => e.add(
                                                                        SelectedQuestionListStruct(
                                                                      questionID:
                                                                          quetion400AItem
                                                                              .questionID,
                                                                      questionAnswerStatus:
                                                                          'hide',
                                                                    )),
                                                                  ),
                                                              );
                                                              FFAppState()
                                                                      .helpLineStatus =
                                                                  true;
                                                              unawaited(
                                                                () async {
                                                                  await widget!
                                                                      .room!
                                                                      .reference
                                                                      .update({
                                                                    ...mapToFirestore(
                                                                      {
                                                                        'selected_game_list':
                                                                            getSelectedGameListListFirestoreData(
                                                                          _model
                                                                              .selectedGameList,
                                                                        ),
                                                                      },
                                                                    ),
                                                                  });
                                                                }(),
                                                              );

                                                              context.pushNamed(
                                                                GameOneS2Widget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'room':
                                                                      serializeParam(
                                                                    widget!.room
                                                                        ?.reference,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );

                                                              return;
                                                            }
                                                            _model.questionStatus =
                                                                'found';
                                                            break;
                                                          }
                                                          _model.countQuestionList =
                                                              (_model.countQuestionList!) -
                                                                  1;
                                                        }
                                                        break;
                                                      }
                                                      _model
                                                          .countGameList = (_model
                                                              .countGameList!) -
                                                          1;
                                                    }
                                                    if (_model.questionStatus ==
                                                        'notFound') {
                                                      _model
                                                          .updateSelectedGameListAtIndex(
                                                        (_model.countGameList!) -
                                                            1,
                                                        (e) => e
                                                          ..updateSelectedQuestionList(
                                                            (e) => e.add(
                                                                SelectedQuestionListStruct(
                                                              questionID:
                                                                  quetion400AItem
                                                                      .questionID,
                                                              questionAnswerStatus:
                                                                  'hide',
                                                            )),
                                                          ),
                                                      );
                                                    } else {
                                                      return;
                                                    }

                                                    FFAppState()
                                                        .helpLineStatus = true;

                                                    await widget!
                                                        .room!.reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'selected_game_list':
                                                              getSelectedGameListListFirestoreData(
                                                            _model
                                                                .selectedGameList,
                                                          ),
                                                        },
                                                      ),
                                                    });

                                                    context.pushNamed(
                                                      GameOneS2Widget.routeName,
                                                      queryParameters: {
                                                        'room': serializeParam(
                                                          widget!
                                                              .room?.reference,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 22.0,
                                                    decoration: BoxDecoration(
                                                      color: widget!.room
                                                                  ?.selectedGameList
                                                                  ?.where((e) =>
                                                                      widget!
                                                                          .selectedGameID ==
                                                                      e
                                                                          .selectedGameID)
                                                                  .toList()
                                                                  ?.firstOrNull
                                                                  ?.selectedQuestionIDList
                                                                  ?.contains(quetion400AItem
                                                                      .questionID) ==
                                                              true
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                        topRight:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                        bottomRight:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                      ),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              quetion400AItem
                                                                  .questionPoint
                                                                  .toString(),
                                                              '0',
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .almarai(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 16.0)),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).divide(SizedBox(height: 4.0)),
                                          );
                                        },
                                      ),
                                      Builder(
                                        builder: (context) {
                                          final quetion400A = containerTopicQuestionRecordList
                                              .where((e) =>
                                                  (e.questionPoint == 400) &&
                                                  ((widget!.room?.roomAttendedQuestionList?.contains(e.questionID) ==
                                                          false) ||
                                                      (widget!.room?.selectedGameList?.where((e) => e.selectedGameID == widget!.selectedGameID).toList()?.firstOrNull?.selectedQuestionIDList?.contains(
                                                              e.questionID) ==
                                                          true)))
                                              .toList()
                                              .sortedList(
                                                  keyOf: (e) => e.questionID,
                                                  desc: false)
                                              .take(widget!.room?.selectedGameList
                                                          ?.where((e) =>
                                                              e.selectedGameID ==
                                                              widget!.selectedGameID)
                                                          .toList()
                                                          ?.firstOrNull
                                                          ?.selectedTopicIDList
                                                          ?.length ==
                                                      3
                                                  ? 2
                                                  : 1)
                                              .toList();

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                quetion400A.length,
                                                (quetion400AIndex) {
                                              final quetion400AItem =
                                                  quetion400A[quetion400AIndex];
                                              return Expanded(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.countGameList = null;
                                                    _model.selectedGameList =
                                                        [];
                                                    _model.questionStatus =
                                                        null;
                                                    _model.countTopicList =
                                                        null;
                                                    _model.selectedTopicList =
                                                        [];
                                                    _model.countQuestionList =
                                                        null;
                                                    _model.selectedQuestionList =
                                                        [];
                                                    _model.countGameList =
                                                        widget!
                                                            .room
                                                            ?.selectedGameList
                                                            ?.length;
                                                    _model.selectedGameList =
                                                        widget!.room!
                                                            .selectedGameList
                                                            .toList()
                                                            .cast<
                                                                SelectedGameListStruct>();
                                                    _model.questionStatus =
                                                        'notFound';
                                                    while (
                                                        _model.countGameList! >
                                                            0) {
                                                      if (_model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGameList!) -
                                                                      1)
                                                              ?.selectedGameID ==
                                                          widget!
                                                              .selectedGameID) {
                                                        _model.countQuestionList = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGameList!) -
                                                                    1)
                                                            ?.selectedQuestionList
                                                            ?.length;
                                                        _model.selectedQuestionList = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGameList!) -
                                                                    1)!
                                                            .selectedQuestionList
                                                            .toList()
                                                            .cast<
                                                                SelectedQuestionListStruct>();
                                                        while (_model
                                                                .countQuestionList! >
                                                            0) {
                                                          if (_model
                                                                  .selectedQuestionList
                                                                  .elementAtOrNull(
                                                                      (_model.countQuestionList!) -
                                                                          1)
                                                                  ?.questionID ==
                                                              quetion400AItem
                                                                  .questionID) {
                                                            if (_model
                                                                    .selectedQuestionList
                                                                    .elementAtOrNull(
                                                                        (_model.countQuestionList!) -
                                                                            1)
                                                                    ?.questionAnswerStatus ==
                                                                'hide') {
                                                              _model
                                                                  .updateSelectedGameListAtIndex(
                                                                (_model.countGameList!) -
                                                                    1,
                                                                (e) => e
                                                                  ..updateSelectedQuestionList(
                                                                    (e) => e.removeAt(
                                                                        (_model.countQuestionList!) -
                                                                            1),
                                                                  ),
                                                              );
                                                              _model
                                                                  .updateSelectedGameListAtIndex(
                                                                (_model.countGameList!) -
                                                                    1,
                                                                (e) => e
                                                                  ..updateSelectedQuestionList(
                                                                    (e) => e.add(
                                                                        SelectedQuestionListStruct(
                                                                      questionID:
                                                                          quetion400AItem
                                                                              .questionID,
                                                                      questionAnswerStatus:
                                                                          'hide',
                                                                    )),
                                                                  ),
                                                              );
                                                              FFAppState()
                                                                      .helpLineStatus =
                                                                  true;
                                                              unawaited(
                                                                () async {
                                                                  await widget!
                                                                      .room!
                                                                      .reference
                                                                      .update({
                                                                    ...mapToFirestore(
                                                                      {
                                                                        'selected_game_list':
                                                                            getSelectedGameListListFirestoreData(
                                                                          _model
                                                                              .selectedGameList,
                                                                        ),
                                                                      },
                                                                    ),
                                                                  });
                                                                }(),
                                                              );

                                                              context.pushNamed(
                                                                GameOneS2Widget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'room':
                                                                      serializeParam(
                                                                    widget!.room
                                                                        ?.reference,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );

                                                              return;
                                                            }
                                                            _model.questionStatus =
                                                                'found';
                                                            break;
                                                          }
                                                          _model.countQuestionList =
                                                              (_model.countQuestionList!) -
                                                                  1;
                                                        }
                                                        break;
                                                      }
                                                      _model
                                                          .countGameList = (_model
                                                              .countGameList!) -
                                                          1;
                                                    }
                                                    if (_model.questionStatus ==
                                                        'notFound') {
                                                      _model
                                                          .updateSelectedGameListAtIndex(
                                                        (_model.countGameList!) -
                                                            1,
                                                        (e) => e
                                                          ..updateSelectedQuestionList(
                                                            (e) => e.add(
                                                                SelectedQuestionListStruct(
                                                              questionID:
                                                                  quetion400AItem
                                                                      .questionID,
                                                              questionAnswerStatus:
                                                                  'hide',
                                                            )),
                                                          ),
                                                      );
                                                    } else {
                                                      return;
                                                    }

                                                    FFAppState()
                                                        .helpLineStatus = true;

                                                    await widget!
                                                        .room!.reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'selected_game_list':
                                                              getSelectedGameListListFirestoreData(
                                                            _model
                                                                .selectedGameList,
                                                          ),
                                                        },
                                                      ),
                                                    });

                                                    context.pushNamed(
                                                      GameOneS2Widget.routeName,
                                                      queryParameters: {
                                                        'room': serializeParam(
                                                          widget!
                                                              .room?.reference,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 22.0,
                                                    decoration: BoxDecoration(
                                                      color: widget!.room
                                                                  ?.selectedGameList
                                                                  ?.where((e) =>
                                                                      widget!
                                                                          .selectedGameID ==
                                                                      e
                                                                          .selectedGameID)
                                                                  .toList()
                                                                  ?.firstOrNull
                                                                  ?.selectedQuestionIDList
                                                                  ?.contains(quetion400AItem
                                                                      .questionID) ==
                                                              true
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                        topRight:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                        bottomRight:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                      ),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              quetion400AItem
                                                                  .questionPoint
                                                                  .toString(),
                                                              '0',
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .almarai(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 16.0)),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).divide(SizedBox(height: 4.0)),
                                          );
                                        },
                                      ),
                                      Builder(
                                        builder: (context) {
                                          final quetion400A = containerTopicQuestionRecordList
                                              .where((e) =>
                                                  (e.questionPoint == 600) &&
                                                  ((widget!.room?.roomAttendedQuestionList?.contains(e.questionID) ==
                                                          false) ||
                                                      (widget!.room?.selectedGameList?.where((e) => e.selectedGameID == widget!.selectedGameID).toList()?.firstOrNull?.selectedQuestionIDList?.contains(
                                                              e.questionID) ==
                                                          true)))
                                              .toList()
                                              .sortedList(
                                                  keyOf: (e) => e.questionID,
                                                  desc: false)
                                              .take(widget!.room?.selectedGameList
                                                          ?.where((e) =>
                                                              e.selectedGameID ==
                                                              widget!.selectedGameID)
                                                          .toList()
                                                          ?.firstOrNull
                                                          ?.selectedTopicIDList
                                                          ?.length ==
                                                      3
                                                  ? 2
                                                  : 1)
                                              .toList();

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                quetion400A.length,
                                                (quetion400AIndex) {
                                              final quetion400AItem =
                                                  quetion400A[quetion400AIndex];
                                              return Expanded(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.countGameList = null;
                                                    _model.selectedGameList =
                                                        [];
                                                    _model.questionStatus =
                                                        null;
                                                    _model.countTopicList =
                                                        null;
                                                    _model.selectedTopicList =
                                                        [];
                                                    _model.countQuestionList =
                                                        null;
                                                    _model.selectedQuestionList =
                                                        [];
                                                    _model.countGameList =
                                                        widget!
                                                            .room
                                                            ?.selectedGameList
                                                            ?.length;
                                                    _model.selectedGameList =
                                                        widget!.room!
                                                            .selectedGameList
                                                            .toList()
                                                            .cast<
                                                                SelectedGameListStruct>();
                                                    _model.questionStatus =
                                                        'notFound';
                                                    while (
                                                        _model.countGameList! >
                                                            0) {
                                                      if (_model
                                                              .selectedGameList
                                                              .elementAtOrNull(
                                                                  (_model.countGameList!) -
                                                                      1)
                                                              ?.selectedGameID ==
                                                          widget!
                                                              .selectedGameID) {
                                                        _model.countQuestionList = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGameList!) -
                                                                    1)
                                                            ?.selectedQuestionList
                                                            ?.length;
                                                        _model.selectedQuestionList = _model
                                                            .selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGameList!) -
                                                                    1)!
                                                            .selectedQuestionList
                                                            .toList()
                                                            .cast<
                                                                SelectedQuestionListStruct>();
                                                        while (_model
                                                                .countQuestionList! >
                                                            0) {
                                                          if (_model
                                                                  .selectedQuestionList
                                                                  .elementAtOrNull(
                                                                      (_model.countQuestionList!) -
                                                                          1)
                                                                  ?.questionID ==
                                                              quetion400AItem
                                                                  .questionID) {
                                                            if (_model
                                                                    .selectedQuestionList
                                                                    .elementAtOrNull(
                                                                        (_model.countQuestionList!) -
                                                                            1)
                                                                    ?.questionAnswerStatus ==
                                                                'hide') {
                                                              _model
                                                                  .updateSelectedGameListAtIndex(
                                                                (_model.countGameList!) -
                                                                    1,
                                                                (e) => e
                                                                  ..updateSelectedQuestionList(
                                                                    (e) => e.removeAt(
                                                                        (_model.countQuestionList!) -
                                                                            1),
                                                                  ),
                                                              );
                                                              _model
                                                                  .updateSelectedGameListAtIndex(
                                                                (_model.countGameList!) -
                                                                    1,
                                                                (e) => e
                                                                  ..updateSelectedQuestionList(
                                                                    (e) => e.add(
                                                                        SelectedQuestionListStruct(
                                                                      questionID:
                                                                          quetion400AItem
                                                                              .questionID,
                                                                      questionAnswerStatus:
                                                                          'hide',
                                                                    )),
                                                                  ),
                                                              );
                                                              FFAppState()
                                                                      .helpLineStatus =
                                                                  true;
                                                              unawaited(
                                                                () async {
                                                                  await widget!
                                                                      .room!
                                                                      .reference
                                                                      .update({
                                                                    ...mapToFirestore(
                                                                      {
                                                                        'selected_game_list':
                                                                            getSelectedGameListListFirestoreData(
                                                                          _model
                                                                              .selectedGameList,
                                                                        ),
                                                                      },
                                                                    ),
                                                                  });
                                                                }(),
                                                              );

                                                              context.pushNamed(
                                                                GameOneS2Widget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'room':
                                                                      serializeParam(
                                                                    widget!.room
                                                                        ?.reference,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );

                                                              return;
                                                            }
                                                            _model.questionStatus =
                                                                'found';
                                                            break;
                                                          }
                                                          _model.countQuestionList =
                                                              (_model.countQuestionList!) -
                                                                  1;
                                                        }
                                                        break;
                                                      }
                                                      _model
                                                          .countGameList = (_model
                                                              .countGameList!) -
                                                          1;
                                                    }
                                                    if (_model.questionStatus ==
                                                        'notFound') {
                                                      _model
                                                          .updateSelectedGameListAtIndex(
                                                        (_model.countGameList!) -
                                                            1,
                                                        (e) => e
                                                          ..updateSelectedQuestionList(
                                                            (e) => e.add(
                                                                SelectedQuestionListStruct(
                                                              questionID:
                                                                  quetion400AItem
                                                                      .questionID,
                                                              questionAnswerStatus:
                                                                  'hide',
                                                            )),
                                                          ),
                                                      );
                                                    } else {
                                                      return;
                                                    }

                                                    FFAppState()
                                                        .helpLineStatus = true;

                                                    await widget!
                                                        .room!.reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'selected_game_list':
                                                              getSelectedGameListListFirestoreData(
                                                            _model
                                                                .selectedGameList,
                                                          ),
                                                        },
                                                      ),
                                                    });

                                                    context.pushNamed(
                                                      GameOneS2Widget.routeName,
                                                      queryParameters: {
                                                        'room': serializeParam(
                                                          widget!
                                                              .room?.reference,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 22.0,
                                                    decoration: BoxDecoration(
                                                      color: widget!.room
                                                                  ?.selectedGameList
                                                                  ?.where((e) =>
                                                                      widget!
                                                                          .selectedGameID ==
                                                                      e
                                                                          .selectedGameID)
                                                                  .toList()
                                                                  ?.firstOrNull
                                                                  ?.selectedQuestionIDList
                                                                  ?.contains(quetion400AItem
                                                                      .questionID) ==
                                                              true
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                        topRight:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                        bottomRight:
                                                            Radius.circular(
                                                                valueOrDefault<
                                                                    double>(
                                                          FFLocalizations.of(
                                                                          context)
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? 8.0
                                                              : 0.0,
                                                          0.0,
                                                        )),
                                                      ),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              quetion400AItem
                                                                  .questionPoint
                                                                  .toString(),
                                                              '0',
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .almarai(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 16.0)),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).divide(SizedBox(height: 4.0)),
                                          );
                                        },
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          final question400B = containerTopicQuestionRecordList
                                              .where((e) =>
                                                  (e.questionPoint == 200) &&
                                                  ((widget!.room?.roomAttendedQuestionList?.contains(e.questionID) ==
                                                          false) ||
                                                      (widget!.room?.selectedGameList?.where((e) => e.selectedGameID == widget!.selectedGameID).toList()?.firstOrNull?.selectedQuestionIDList?.contains(
                                                              e.questionID) ==
                                                          true)))
                                              .toList()
                                              .sortedList(
                                                  keyOf: (e) => e.questionID,
                                                  desc: true)
                                              .take(widget!.room?.selectedGameList
                                                          ?.where((e) =>
                                                              e.selectedGameID ==
                                                              widget!.selectedGameID)
                                                          .toList()
                                                          ?.firstOrNull
                                                          ?.selectedTopicIDList
                                                          ?.length ==
                                                      3
                                                  ? 2
                                                  : 1)
                                              .toList();

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                question400B.length,
                                                (question400BIndex) {
                                              final question400BItem =
                                                  question400B[
                                                      question400BIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.countGameList = null;
                                                  _model.selectedGameList = [];
                                                  _model.questionStatus = null;
                                                  _model.countTopicList = null;
                                                  _model.selectedTopicList = [];
                                                  _model.countQuestionList =
                                                      null;
                                                  _model.selectedQuestionList =
                                                      [];
                                                  _model.countGameList = widget!
                                                      .room
                                                      ?.selectedGameList
                                                      ?.length;
                                                  _model.selectedGameList = widget!
                                                      .room!.selectedGameList
                                                      .toList()
                                                      .cast<
                                                          SelectedGameListStruct>();
                                                  _model.questionStatus =
                                                      'notFound';
                                                  while (_model.countGameList! >
                                                      0) {
                                                    if (_model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGameList!) -
                                                                    1)
                                                            ?.selectedGameID ==
                                                        widget!
                                                            .selectedGameID) {
                                                      _model.countQuestionList = _model
                                                          .selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGameList!) -
                                                              1)
                                                          ?.selectedQuestionList
                                                          ?.length;
                                                      _model.selectedQuestionList = _model
                                                          .selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGameList!) -
                                                              1)!
                                                          .selectedQuestionList
                                                          .toList()
                                                          .cast<
                                                              SelectedQuestionListStruct>();
                                                      while (_model
                                                              .countQuestionList! >
                                                          0) {
                                                        if (_model
                                                                .selectedQuestionList
                                                                .elementAtOrNull(
                                                                    (_model.countQuestionList!) -
                                                                        1)
                                                                ?.questionID ==
                                                            question400BItem
                                                                .questionID) {
                                                          if (_model
                                                                  .selectedQuestionList
                                                                  .elementAtOrNull(
                                                                      (_model.countQuestionList!) -
                                                                          1)
                                                                  ?.questionAnswerStatus ==
                                                              'hide') {
                                                            _model
                                                                .updateSelectedGameListAtIndex(
                                                              (_model.countGameList!) -
                                                                  1,
                                                              (e) => e
                                                                ..updateSelectedQuestionList(
                                                                  (e) => e.removeAt(
                                                                      (_model.countQuestionList!) -
                                                                          1),
                                                                ),
                                                            );
                                                            _model
                                                                .updateSelectedGameListAtIndex(
                                                              (_model.countGameList!) -
                                                                  1,
                                                              (e) => e
                                                                ..updateSelectedQuestionList(
                                                                  (e) => e.add(
                                                                      SelectedQuestionListStruct(
                                                                    questionID:
                                                                        question400BItem
                                                                            .questionID,
                                                                    questionAnswerStatus:
                                                                        'hide',
                                                                  )),
                                                                ),
                                                            );
                                                            FFAppState()
                                                                    .helpLineStatus =
                                                                true;

                                                            await widget!
                                                                .room!.reference
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'selected_game_list':
                                                                      getSelectedGameListListFirestoreData(
                                                                    _model
                                                                        .selectedGameList,
                                                                  ),
                                                                },
                                                              ),
                                                            });

                                                            context.pushNamed(
                                                              GameOneS2Widget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'room':
                                                                    serializeParam(
                                                                  widget!.room
                                                                      ?.reference,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );

                                                            return;
                                                          }
                                                          _model.questionStatus =
                                                              'found';
                                                          break;
                                                        }
                                                        _model.countQuestionList =
                                                            (_model.countQuestionList!) -
                                                                1;
                                                      }
                                                      break;
                                                    }
                                                    _model
                                                        .countGameList = (_model
                                                            .countGameList!) -
                                                        1;
                                                  }
                                                  if (_model.questionStatus ==
                                                      'notFound') {
                                                    _model
                                                        .updateSelectedGameListAtIndex(
                                                      (_model.countGameList!) -
                                                          1,
                                                      (e) => e
                                                        ..updateSelectedQuestionList(
                                                          (e) => e.add(
                                                              SelectedQuestionListStruct(
                                                            questionID:
                                                                question400BItem
                                                                    .questionID,
                                                            questionAnswerStatus:
                                                                'hide',
                                                          )),
                                                        ),
                                                    );
                                                  } else {
                                                    return;
                                                  }

                                                  FFAppState().helpLineStatus =
                                                      true;

                                                  await widget!.room!.reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'selected_game_list':
                                                            getSelectedGameListListFirestoreData(
                                                          _model
                                                              .selectedGameList,
                                                        ),
                                                      },
                                                    ),
                                                  });

                                                  context.pushNamed(
                                                    GameOneS2Widget.routeName,
                                                    queryParameters: {
                                                      'room': serializeParam(
                                                        widget!.room?.reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: Container(
                                                  height: 22.0,
                                                  decoration: BoxDecoration(
                                                    color: widget!.room
                                                                ?.selectedGameList
                                                                ?.where((e) =>
                                                                    widget!
                                                                        .selectedGameID ==
                                                                    e
                                                                        .selectedGameID)
                                                                .toList()
                                                                ?.firstOrNull
                                                                ?.selectedQuestionIDList
                                                                ?.contains(question400BItem
                                                                    .questionID) ==
                                                            true
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .alternate
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          valueOrDefault<
                                                              double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'ar'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                      topRight: Radius.circular(
                                                          valueOrDefault<
                                                              double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'en'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                      bottomLeft:
                                                          Radius.circular(
                                                              valueOrDefault<
                                                                  double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'ar'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                      bottomRight:
                                                          Radius.circular(
                                                              valueOrDefault<
                                                                  double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'en'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                    ),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    12.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            question400BItem
                                                                .questionPoint
                                                                .toString(),
                                                            '0',
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font: GoogleFonts
                                                                    .almarai(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ),
                                              );
                                            }).divide(SizedBox(height: 4.0)),
                                          );
                                        },
                                      ),
                                      Builder(
                                        builder: (context) {
                                          final question400B = containerTopicQuestionRecordList
                                              .where((e) =>
                                                  (e.questionPoint == 400) &&
                                                  ((widget!.room?.roomAttendedQuestionList?.contains(e.questionID) ==
                                                          false) ||
                                                      (widget!.room?.selectedGameList?.where((e) => e.selectedGameID == widget!.selectedGameID).toList()?.firstOrNull?.selectedQuestionIDList?.contains(
                                                              e.questionID) ==
                                                          true)))
                                              .toList()
                                              .sortedList(
                                                  keyOf: (e) => e.questionID,
                                                  desc: true)
                                              .take(widget!.room?.selectedGameList
                                                          ?.where((e) =>
                                                              e.selectedGameID ==
                                                              widget!.selectedGameID)
                                                          .toList()
                                                          ?.firstOrNull
                                                          ?.selectedTopicIDList
                                                          ?.length ==
                                                      3
                                                  ? 2
                                                  : 1)
                                              .toList();

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                question400B.length,
                                                (question400BIndex) {
                                              final question400BItem =
                                                  question400B[
                                                      question400BIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.countGameList = null;
                                                  _model.selectedGameList = [];
                                                  _model.questionStatus = null;
                                                  _model.countTopicList = null;
                                                  _model.selectedTopicList = [];
                                                  _model.countQuestionList =
                                                      null;
                                                  _model.selectedQuestionList =
                                                      [];
                                                  _model.countGameList = widget!
                                                      .room
                                                      ?.selectedGameList
                                                      ?.length;
                                                  _model.selectedGameList = widget!
                                                      .room!.selectedGameList
                                                      .toList()
                                                      .cast<
                                                          SelectedGameListStruct>();
                                                  _model.questionStatus =
                                                      'notFound';
                                                  while (_model.countGameList! >
                                                      0) {
                                                    if (_model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGameList!) -
                                                                    1)
                                                            ?.selectedGameID ==
                                                        widget!
                                                            .selectedGameID) {
                                                      _model.countQuestionList = _model
                                                          .selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGameList!) -
                                                              1)
                                                          ?.selectedQuestionList
                                                          ?.length;
                                                      _model.selectedQuestionList = _model
                                                          .selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGameList!) -
                                                              1)!
                                                          .selectedQuestionList
                                                          .toList()
                                                          .cast<
                                                              SelectedQuestionListStruct>();
                                                      while (_model
                                                              .countQuestionList! >
                                                          0) {
                                                        if (_model
                                                                .selectedQuestionList
                                                                .elementAtOrNull(
                                                                    (_model.countQuestionList!) -
                                                                        1)
                                                                ?.questionID ==
                                                            question400BItem
                                                                .questionID) {
                                                          if (_model
                                                                  .selectedQuestionList
                                                                  .elementAtOrNull(
                                                                      (_model.countQuestionList!) -
                                                                          1)
                                                                  ?.questionAnswerStatus ==
                                                              'hide') {
                                                            _model
                                                                .updateSelectedGameListAtIndex(
                                                              (_model.countGameList!) -
                                                                  1,
                                                              (e) => e
                                                                ..updateSelectedQuestionList(
                                                                  (e) => e.removeAt(
                                                                      (_model.countQuestionList!) -
                                                                          1),
                                                                ),
                                                            );
                                                            _model
                                                                .updateSelectedGameListAtIndex(
                                                              (_model.countGameList!) -
                                                                  1,
                                                              (e) => e
                                                                ..updateSelectedQuestionList(
                                                                  (e) => e.add(
                                                                      SelectedQuestionListStruct(
                                                                    questionID:
                                                                        question400BItem
                                                                            .questionID,
                                                                    questionAnswerStatus:
                                                                        'hide',
                                                                  )),
                                                                ),
                                                            );
                                                            FFAppState()
                                                                    .helpLineStatus =
                                                                true;

                                                            await widget!
                                                                .room!.reference
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'selected_game_list':
                                                                      getSelectedGameListListFirestoreData(
                                                                    _model
                                                                        .selectedGameList,
                                                                  ),
                                                                },
                                                              ),
                                                            });

                                                            context.pushNamed(
                                                              GameOneS2Widget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'room':
                                                                    serializeParam(
                                                                  widget!.room
                                                                      ?.reference,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );

                                                            return;
                                                          }
                                                          _model.questionStatus =
                                                              'found';
                                                          break;
                                                        }
                                                        _model.countQuestionList =
                                                            (_model.countQuestionList!) -
                                                                1;
                                                      }
                                                      break;
                                                    }
                                                    _model
                                                        .countGameList = (_model
                                                            .countGameList!) -
                                                        1;
                                                  }
                                                  if (_model.questionStatus ==
                                                      'notFound') {
                                                    _model
                                                        .updateSelectedGameListAtIndex(
                                                      (_model.countGameList!) -
                                                          1,
                                                      (e) => e
                                                        ..updateSelectedQuestionList(
                                                          (e) => e.add(
                                                              SelectedQuestionListStruct(
                                                            questionID:
                                                                question400BItem
                                                                    .questionID,
                                                            questionAnswerStatus:
                                                                'hide',
                                                          )),
                                                        ),
                                                    );
                                                  } else {
                                                    return;
                                                  }

                                                  FFAppState().helpLineStatus =
                                                      true;

                                                  await widget!.room!.reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'selected_game_list':
                                                            getSelectedGameListListFirestoreData(
                                                          _model
                                                              .selectedGameList,
                                                        ),
                                                      },
                                                    ),
                                                  });

                                                  context.pushNamed(
                                                    GameOneS2Widget.routeName,
                                                    queryParameters: {
                                                      'room': serializeParam(
                                                        widget!.room?.reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: Container(
                                                  height: 22.0,
                                                  decoration: BoxDecoration(
                                                    color: widget!.room
                                                                ?.selectedGameList
                                                                ?.where((e) =>
                                                                    widget!
                                                                        .selectedGameID ==
                                                                    e
                                                                        .selectedGameID)
                                                                .toList()
                                                                ?.firstOrNull
                                                                ?.selectedQuestionIDList
                                                                ?.contains(question400BItem
                                                                    .questionID) ==
                                                            true
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .alternate
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          valueOrDefault<
                                                              double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'ar'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                      topRight: Radius.circular(
                                                          valueOrDefault<
                                                              double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'en'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                      bottomLeft:
                                                          Radius.circular(
                                                              valueOrDefault<
                                                                  double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'ar'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                      bottomRight:
                                                          Radius.circular(
                                                              valueOrDefault<
                                                                  double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'en'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                    ),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    12.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            question400BItem
                                                                .questionPoint
                                                                .toString(),
                                                            '0',
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font: GoogleFonts
                                                                    .almarai(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ),
                                              );
                                            }).divide(SizedBox(height: 4.0)),
                                          );
                                        },
                                      ),
                                      Builder(
                                        builder: (context) {
                                          final question400B = containerTopicQuestionRecordList
                                              .where((e) =>
                                                  (e.questionPoint == 600) &&
                                                  ((widget!.room?.roomAttendedQuestionList?.contains(e.questionID) ==
                                                          false) ||
                                                      (widget!.room?.selectedGameList?.where((e) => e.selectedGameID == widget!.selectedGameID).toList()?.firstOrNull?.selectedQuestionIDList?.contains(
                                                              e.questionID) ==
                                                          true)))
                                              .toList()
                                              .sortedList(
                                                  keyOf: (e) => e.questionID,
                                                  desc: true)
                                              .take(widget!.room?.selectedGameList
                                                          ?.where((e) =>
                                                              e.selectedGameID ==
                                                              widget!.selectedGameID)
                                                          .toList()
                                                          ?.firstOrNull
                                                          ?.selectedTopicIDList
                                                          ?.length ==
                                                      3
                                                  ? 2
                                                  : 1)
                                              .toList();

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                question400B.length,
                                                (question400BIndex) {
                                              final question400BItem =
                                                  question400B[
                                                      question400BIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.countGameList = null;
                                                  _model.selectedGameList = [];
                                                  _model.questionStatus = null;
                                                  _model.countTopicList = null;
                                                  _model.selectedTopicList = [];
                                                  _model.countQuestionList =
                                                      null;
                                                  _model.selectedQuestionList =
                                                      [];
                                                  _model.countGameList = widget!
                                                      .room
                                                      ?.selectedGameList
                                                      ?.length;
                                                  _model.selectedGameList = widget!
                                                      .room!.selectedGameList
                                                      .toList()
                                                      .cast<
                                                          SelectedGameListStruct>();
                                                  _model.questionStatus =
                                                      'notFound';
                                                  while (_model.countGameList! >
                                                      0) {
                                                    if (_model.selectedGameList
                                                            .elementAtOrNull(
                                                                (_model.countGameList!) -
                                                                    1)
                                                            ?.selectedGameID ==
                                                        widget!
                                                            .selectedGameID) {
                                                      _model.countQuestionList = _model
                                                          .selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGameList!) -
                                                              1)
                                                          ?.selectedQuestionList
                                                          ?.length;
                                                      _model.selectedQuestionList = _model
                                                          .selectedGameList
                                                          .elementAtOrNull((_model
                                                                  .countGameList!) -
                                                              1)!
                                                          .selectedQuestionList
                                                          .toList()
                                                          .cast<
                                                              SelectedQuestionListStruct>();
                                                      while (_model
                                                              .countQuestionList! >
                                                          0) {
                                                        if (_model
                                                                .selectedQuestionList
                                                                .elementAtOrNull(
                                                                    (_model.countQuestionList!) -
                                                                        1)
                                                                ?.questionID ==
                                                            question400BItem
                                                                .questionID) {
                                                          if (_model
                                                                  .selectedQuestionList
                                                                  .elementAtOrNull(
                                                                      (_model.countQuestionList!) -
                                                                          1)
                                                                  ?.questionAnswerStatus ==
                                                              'hide') {
                                                            _model
                                                                .updateSelectedGameListAtIndex(
                                                              (_model.countGameList!) -
                                                                  1,
                                                              (e) => e
                                                                ..updateSelectedQuestionList(
                                                                  (e) => e.removeAt(
                                                                      (_model.countQuestionList!) -
                                                                          1),
                                                                ),
                                                            );
                                                            _model
                                                                .updateSelectedGameListAtIndex(
                                                              (_model.countGameList!) -
                                                                  1,
                                                              (e) => e
                                                                ..updateSelectedQuestionList(
                                                                  (e) => e.add(
                                                                      SelectedQuestionListStruct(
                                                                    questionID:
                                                                        question400BItem
                                                                            .questionID,
                                                                    questionAnswerStatus:
                                                                        'hide',
                                                                  )),
                                                                ),
                                                            );
                                                            FFAppState()
                                                                    .helpLineStatus =
                                                                true;

                                                            await widget!
                                                                .room!.reference
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'selected_game_list':
                                                                      getSelectedGameListListFirestoreData(
                                                                    _model
                                                                        .selectedGameList,
                                                                  ),
                                                                },
                                                              ),
                                                            });

                                                            context.pushNamed(
                                                              GameOneS2Widget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'room':
                                                                    serializeParam(
                                                                  widget!.room
                                                                      ?.reference,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );

                                                            return;
                                                          }
                                                          _model.questionStatus =
                                                              'found';
                                                          break;
                                                        }
                                                        _model.countQuestionList =
                                                            (_model.countQuestionList!) -
                                                                1;
                                                      }
                                                      break;
                                                    }
                                                    _model
                                                        .countGameList = (_model
                                                            .countGameList!) -
                                                        1;
                                                  }
                                                  if (_model.questionStatus ==
                                                      'notFound') {
                                                    _model
                                                        .updateSelectedGameListAtIndex(
                                                      (_model.countGameList!) -
                                                          1,
                                                      (e) => e
                                                        ..updateSelectedQuestionList(
                                                          (e) => e.add(
                                                              SelectedQuestionListStruct(
                                                            questionID:
                                                                question400BItem
                                                                    .questionID,
                                                            questionAnswerStatus:
                                                                'hide',
                                                          )),
                                                        ),
                                                    );
                                                  } else {
                                                    return;
                                                  }

                                                  FFAppState().helpLineStatus =
                                                      true;

                                                  await widget!.room!.reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'selected_game_list':
                                                            getSelectedGameListListFirestoreData(
                                                          _model
                                                              .selectedGameList,
                                                        ),
                                                      },
                                                    ),
                                                  });

                                                  context.pushNamed(
                                                    GameOneS2Widget.routeName,
                                                    queryParameters: {
                                                      'room': serializeParam(
                                                        widget!.room?.reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: Container(
                                                  height: 22.0,
                                                  decoration: BoxDecoration(
                                                    color: widget!.room
                                                                ?.selectedGameList
                                                                ?.where((e) =>
                                                                    widget!
                                                                        .selectedGameID ==
                                                                    e
                                                                        .selectedGameID)
                                                                .toList()
                                                                ?.firstOrNull
                                                                ?.selectedQuestionIDList
                                                                ?.contains(question400BItem
                                                                    .questionID) ==
                                                            true
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .alternate
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          valueOrDefault<
                                                              double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'ar'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                      topRight: Radius.circular(
                                                          valueOrDefault<
                                                              double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'en'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                      bottomLeft:
                                                          Radius.circular(
                                                              valueOrDefault<
                                                                  double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'ar'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                      bottomRight:
                                                          Radius.circular(
                                                              valueOrDefault<
                                                                  double>(
                                                        FFLocalizations.of(
                                                                        context)
                                                                    .languageCode ==
                                                                'en'
                                                            ? 8.0
                                                            : 0.0,
                                                        0.0,
                                                      )),
                                                    ),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    12.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            question400BItem
                                                                .questionPoint
                                                                .toString(),
                                                            '0',
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font: GoogleFonts
                                                                    .almarai(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ),
                                              );
                                            }).divide(SizedBox(height: 4.0)),
                                          );
                                        },
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: StreamBuilder<List<TopicRecord>>(
                              stream: queryTopicRecord(
                                queryBuilder: (topicRecord) => topicRecord
                                    .where(
                                      'topic_status',
                                      isEqualTo: 'active',
                                    )
                                    .where(
                                      'topic_ID',
                                      isEqualTo: widget!.topicID,
                                    ),
                                singleRecord: true,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 2.0,
                                      height: 2.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0x00EC4D41),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<TopicRecord> containerTopicRecordList =
                                    snapshot.data!;
                                final containerTopicRecord =
                                    containerTopicRecordList.isNotEmpty
                                        ? containerTopicRecordList.first
                                        : null;

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Container(
                                    width: (widget!.room?.selectedGameList
                                                    ?.where((e) =>
                                                        e.selectedGameID ==
                                                        widget!.selectedGameID)
                                                    .toList()
                                                    ?.firstOrNull
                                                    ?.selectedTopicIDList
                                                    ?.length ==
                                                3
                                            ? 130
                                            : 100)
                                        .toDouble(),
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        image: Image.network(
                                          valueOrDefault<String>(
                                            containerTopicRecord
                                                ?.topicInfo?.mainImage,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/y8i24cl1b5bt/Splash_Screen_(2)-min.jpg',
                                          ),
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
