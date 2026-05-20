import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah_game_zone/main/home_roomlist/home_roomlist_widget.dart';
import '/feshah_game_zone/main/home_widget1/home_widget1_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_widget2_landscape_model.dart';
export 'home_widget2_landscape_model.dart';

class HomeWidget2LandscapeWidget extends StatefulWidget {
  const HomeWidget2LandscapeWidget({
    super.key,
    required this.gameID,
  });

  final int? gameID;

  @override
  State<HomeWidget2LandscapeWidget> createState() =>
      _HomeWidget2LandscapeWidgetState();
}

class _HomeWidget2LandscapeWidgetState
    extends State<HomeWidget2LandscapeWidget> {
  late HomeWidget2LandscapeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeWidget2LandscapeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        child: Container(
          width: 600.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
            border: Border.all(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        valueOrDefault<double>(
                          functions.isLandscape(
                                  MediaQuery.sizeOf(context).width,
                                  MediaQuery.sizeOf(context).height)!
                              ? 55.0
                              : 16.0,
                          16.0,
                        ),
                        24.0,
                        16.0,
                        0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 24.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StreamBuilder<List<GameRecord>>(
                                    stream: queryGameRecord(
                                      queryBuilder: (gameRecord) =>
                                          gameRecord.where(
                                        'game_ID',
                                        isEqualTo: widget!.gameID,
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
                                      List<GameRecord> textGameRecordList =
                                          snapshot.data!;
                                      // Return an empty Container when the item does not exist.
                                      if (snapshot.data!.isEmpty) {
                                        return Container();
                                      }
                                      final textGameRecord =
                                          textGameRecordList.isNotEmpty
                                              ? textGameRecordList.first
                                              : null;

                                      return Text(
                                        textGameRecord!.gameInfo.name,
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.almarai(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      );
                                    },
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'vqawzta5' /* Please choose an option */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          font: GoogleFonts.almarai(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  've6e3xh6' /* Your Rooms */,
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
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '1pe6mfio' /* View all */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        font: GoogleFonts.almarai(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: StreamBuilder<List<RoomRecord>>(
                                  stream: queryRoomRecord(
                                    queryBuilder: (roomRecord) => roomRecord
                                        .where(
                                          'room_status',
                                          isEqualTo: 'active',
                                        )
                                        .orderBy('room_created_at',
                                            descending: true),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<RoomRecord> containerRoomRecordList =
                                        snapshot.data!;

                                    return Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: BoxDecoration(),
                                      child: Builder(
                                        builder: (context) {
                                          final roomList = containerRoomRecordList
                                              .where((e) =>
                                                  (e.roomUserList
                                                          .where((e) =>
                                                              (e.roomUserRef ==
                                                                  currentUserReference) &&
                                                              (e.roomUserStatus ==
                                                                  'active'))
                                                          .toList()
                                                          .length >
                                                      0) &&
                                                  (e.roomType != 'solo'))
                                              .toList();
                                          if (roomList.isEmpty) {
                                            return EmptyWidgetRoomWidget();
                                          }

                                          return ListView.separated(
                                            padding: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              0,
                                              8.0,
                                            ),
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: roomList.length,
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 8.0),
                                            itemBuilder:
                                                (context, roomListIndex) {
                                              final roomListItem =
                                                  roomList[roomListIndex];
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 8.0, 0.0),
                                                child: HomeRoomlistWidget(
                                                  key: Key(
                                                      'Key2cp_${roomListIndex}_of_${roomList.length}'),
                                                  room: roomListItem,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.createaRoomModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          updateOnChange: true,
                                          child: HomeWidget1Widget(
                                            buttonbackgroundcolor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            buttonicon: Icon(
                                              FFIcons.kfi15,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                            buttontext:
                                                FFLocalizations.of(context)
                                                    .getText(
                                              'pk33ua2b' /* Create a Room */,
                                            ),
                                            type: FFLocalizations.of(context)
                                                .getText(
                                              'shhsk47y' /* create */,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.joinaRoomModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: HomeWidget1Widget(
                                            buttonbackgroundcolor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                            buttonicon: Icon(
                                              FFIcons.kfi16,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                            buttontext:
                                                FFLocalizations.of(context)
                                                    .getText(
                                              'i05l9oqx' /* Join a Room */,
                                            ),
                                            type: FFLocalizations.of(context)
                                                .getText(
                                              'ryex0wfy' /* join */,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
