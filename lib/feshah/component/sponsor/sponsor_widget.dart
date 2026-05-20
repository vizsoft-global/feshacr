import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sponsor_model.dart';
export 'sponsor_model.dart';

class SponsorWidget extends StatefulWidget {
  const SponsorWidget({super.key});

  @override
  State<SponsorWidget> createState() => _SponsorWidgetState();
}

class _SponsorWidgetState extends State<SponsorWidget>
    with TickerProviderStateMixin {
  late SponsorModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SponsorModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        applyInitialState: true,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(
                FFLocalizations.of(context).languageCode == 'en' ? -100.0 : 0.0,
                0.0),
            end: Offset(
                FFLocalizations.of(context).languageCode == 'en' ? 0.0 : 0.0,
                0.0),
          ),
        ],
      ),
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(-100.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SettingsRecord>>(
      stream: querySettingsRecord(
        queryBuilder: (settingsRecord) => settingsRecord.where(
          'type',
          isEqualTo: 'Company',
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
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0x00EC4D41),
                ),
              ),
            ),
          );
        }
        List<SettingsRecord> containerSettingsRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final containerSettingsRecord = containerSettingsRecordList.isNotEmpty
            ? containerSettingsRecordList.first
            : null;

        return Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(valueOrDefault<double>(
                FFLocalizations.of(context).languageCode != 'en' ? 16.0 : 0.0,
                0.0,
              )),
              topRight: Radius.circular(valueOrDefault<double>(
                FFLocalizations.of(context).languageCode == 'en' ? 16.0 : 0.0,
                0.0,
              )),
              bottomLeft: Radius.circular(valueOrDefault<double>(
                FFLocalizations.of(context).languageCode != 'en' ? 16.0 : 0.0,
                0.0,
              )),
              bottomRight: Radius.circular(valueOrDefault<double>(
                FFLocalizations.of(context).languageCode == 'en' ? 16.0 : 0.0,
                0.0,
              )),
            ),
            border: Border.all(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      height: 85.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF3C827F), Color(0xFFA5D7D4)],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(1.0, -0.98),
                          end: AlignmentDirectional(-1.0, 0.98),
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: AutoSizeText(
                                containerSettingsRecord!
                                    .settingsSponsorInfo.firstOrNull!.name,
                                minFontSize: 14.0,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.almarai(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.network(
                              valueOrDefault<String>(
                                containerSettingsRecord?.settingsSponsorInfo
                                    ?.firstOrNull?.mainImage,
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feshah-n9q4qd/assets/8ob912runztq/Frame_2087324878.png',
                              ),
                              fit: BoxFit.contain,
                              alignment: Alignment(1.0, 0.0),
                            ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    if (FFLocalizations.of(context).languageCode == 'en')
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_double_arrow_left_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 48.0,
                        ),
                      ),
                    if (FFLocalizations.of(context).languageCode != 'en')
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_double_arrow_right_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 48.0,
                        ),
                      ),
                  ],
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
          ),
        )
            .animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!)
            .animateOnActionTrigger(
              animationsMap['containerOnActionTriggerAnimation']!,
            );
      },
    );
  }
}
