import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'game_four_questions_model.dart';
export 'game_four_questions_model.dart';

class GameFourQuestionsWidget extends StatefulWidget {
  const GameFourQuestionsWidget({
    super.key,
    this.selectedGameID,
    this.room,
    required this.gameID,
    required this.questionID,
    required this.index,
  });

  final int? selectedGameID;
  final RoomRecord? room;
  final int? gameID;
  final int? questionID;
  final int? index;

  @override
  State<GameFourQuestionsWidget> createState() =>
      _GameFourQuestionsWidgetState();
}

class _GameFourQuestionsWidgetState extends State<GameFourQuestionsWidget> {
  late GameFourQuestionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameFourQuestionsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        _model.countGameList = null;
        _model.selectedGameList = [];
        _model.questionStatus = null;
        _model.countTopicList = null;
        _model.selectedTopicList = [];
        _model.countQuestionList = null;
        _model.selectedQuestionList = [];
        _model.countGameList = widget!.room?.selectedGameList?.length;
        _model.selectedGameList = widget!.room!.selectedGameList
            .toList()
            .cast<SelectedGameListStruct>();
        _model.questionStatus = 'notFound';
        while (_model.countGameList! > 0) {
          if (_model.selectedGameList
                  .elementAtOrNull((_model.countGameList!) - 1)
                  ?.selectedGameID ==
              widget!.selectedGameID) {
            _model.countQuestionList = _model.selectedGameList
                .elementAtOrNull((_model.countGameList!) - 1)
                ?.selectedQuestionList
                ?.length;
            _model.selectedQuestionList = _model.selectedGameList
                .elementAtOrNull((_model.countGameList!) - 1)!
                .selectedQuestionList
                .toList()
                .cast<SelectedQuestionListStruct>();
            while (_model.countQuestionList! > 0) {
              if (_model.selectedQuestionList
                      .elementAtOrNull((_model.countQuestionList!) - 1)
                      ?.questionID ==
                  widget!.questionID) {
                if (_model.selectedQuestionList
                        .elementAtOrNull((_model.countQuestionList!) - 1)
                        ?.questionAnswerStatus ==
                    'hide') {
                  _model.updateSelectedGameListAtIndex(
                    (_model.countGameList!) - 1,
                    (e) => e
                      ..updateSelectedQuestionList(
                        (e) => e.removeAt((_model.countQuestionList!) - 1),
                      ),
                  );
                  _model.updateSelectedGameListAtIndex(
                    (_model.countGameList!) - 1,
                    (e) => e
                      ..updateSelectedQuestionList(
                        (e) => e.add(SelectedQuestionListStruct(
                          questionID: widget!.questionID,
                          questionAnswerStatus: 'hide',
                        )),
                      ),
                  );
                  FFAppState().helpLineStatus = true;

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

                  context.pushNamed(
                    GameFourS2Widget.routeName,
                    queryParameters: {
                      'room': serializeParam(
                        widget!.room?.reference,
                        ParamType.DocumentReference,
                      ),
                      'tieBreakStatus': serializeParam(
                        false,
                        ParamType.bool,
                      ),
                    }.withoutNulls,
                  );

                  return;
                }
                _model.questionStatus = 'found';
                break;
              }
              _model.countQuestionList = (_model.countQuestionList!) - 1;
            }
            break;
          }
          _model.countGameList = (_model.countGameList!) - 1;
        }
        if (_model.questionStatus == 'notFound') {
          _model.updateSelectedGameListAtIndex(
            (_model.countGameList!) - 1,
            (e) => e
              ..updateSelectedQuestionList(
                (e) => e.add(SelectedQuestionListStruct(
                  questionID: widget!.questionID,
                  questionAnswerStatus: 'hide',
                )),
              ),
          );
        } else {
          return;
        }

        FFAppState().helpLineStatus = true;

        await widget!.room!.reference.update({
          ...mapToFirestore(
            {
              'selected_game_list': getSelectedGameListListFirestoreData(
                _model.selectedGameList,
              ),
            },
          ),
        });

        context.pushNamed(
          GameFourS2Widget.routeName,
          queryParameters: {
            'room': serializeParam(
              widget!.room?.reference,
              ParamType.DocumentReference,
            ),
            'tieBreakStatus': serializeParam(
              false,
              ParamType.bool,
            ),
          }.withoutNulls,
        );
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: BoxDecoration(
          color: widget!.room?.selectedGameList
                      ?.where((e) => widget!.selectedGameID == e.selectedGameID)
                      .toList()
                      ?.firstOrNull
                      ?.selectedQuestionIDList
                      ?.contains(widget!.questionID) ==
                  true
              ? Color(0x80FFFFFF)
              : FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: widget!.room?.selectedGameList
                        ?.where(
                            (e) => widget!.selectedGameID == e.selectedGameID)
                        .toList()
                        ?.firstOrNull
                        ?.selectedQuestionIDList
                        ?.contains(widget!.questionID) ==
                    true
                ? Color(0x80000000)
                : FlutterFlowTheme.of(context).primaryText,
            width: 0.5,
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Text(
            valueOrDefault<String>(
              ((widget!.index!) + 1).toString(),
              '*',
            ),
            style: FlutterFlowTheme.of(context).displayLarge.override(
              font: GoogleFonts.almarai(
                fontWeight: FontWeight.w800,
                fontStyle: FlutterFlowTheme.of(context).displayLarge.fontStyle,
              ),
              color: valueOrDefault<Color>(
                widget!.room?.selectedGameList
                            ?.where((e) =>
                                widget!.selectedGameID == e.selectedGameID)
                            .toList()
                            ?.firstOrNull
                            ?.selectedQuestionIDList
                            ?.contains(widget!.questionID) ==
                        true
                    ? Color(0x80EC4D41)
                    : FlutterFlowTheme.of(context).primary,
                FlutterFlowTheme.of(context).primary,
              ),
              letterSpacing: 0.0,
              fontWeight: FontWeight.w800,
              fontStyle: FlutterFlowTheme.of(context).displayLarge.fontStyle,
              shadows: [
                Shadow(
                  color: valueOrDefault<Color>(
                    widget!.room?.selectedGameList
                                ?.where((e) =>
                                    widget!.selectedGameID == e.selectedGameID)
                                .toList()
                                ?.firstOrNull
                                ?.selectedQuestionIDList
                                ?.contains(widget!.questionID) ==
                            true
                        ? Color(0x54000000)
                        : FlutterFlowTheme.of(context).primaryText,
                    FlutterFlowTheme.of(context).primaryText,
                  ),
                  offset: Offset(1.0, 1.0),
                  blurRadius: 0.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
