import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_sponsor_model.dart';
export 'home_sponsor_model.dart';

class HomeSponsorWidget extends StatefulWidget {
  const HomeSponsorWidget({super.key});

  @override
  State<HomeSponsorWidget> createState() => _HomeSponsorWidgetState();
}

class _HomeSponsorWidgetState extends State<HomeSponsorWidget> {
  late HomeSponsorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeSponsorModel());

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
          height: 90.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Builder(
            builder: (context) {
              final sponsorList =
                  containerSettingsRecord?.settingsSponsorInfo?.toList() ?? [];

              return ListView.separated(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: sponsorList.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.0),
                itemBuilder: (context, sponsorListIndex) {
                  final sponsorListItem = sponsorList[sponsorListIndex];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.91,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: AlignmentDirectional(0.0, 0.0),
                          image: Image.network(
                            sponsorListItem.image,
                          ).image,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: AutoSizeText(
                                FFLocalizations.of(context).getVariableText(
                                  enText: () {
                                    if (sponsorListItem.mainInfoManualTranslate
                                                .name.en !=
                                            null &&
                                        sponsorListItem.mainInfoManualTranslate
                                                .name.en !=
                                            '') {
                                      return sponsorListItem
                                          .mainInfoManualTranslate.name.en;
                                    } else if (sponsorListItem
                                                .mainInfoTranslate.name.en !=
                                            null &&
                                        sponsorListItem
                                                .mainInfoTranslate.name.en !=
                                            '') {
                                      return sponsorListItem
                                          .mainInfoTranslate.name.en;
                                    } else {
                                      return sponsorListItem.name;
                                    }
                                  }(),
                                  arText: () {
                                    if (sponsorListItem.mainInfoManualTranslate
                                                .name.ar !=
                                            null &&
                                        sponsorListItem.mainInfoManualTranslate
                                                .name.ar !=
                                            '') {
                                      return sponsorListItem
                                          .mainInfoManualTranslate.name.ar;
                                    } else if (sponsorListItem
                                                .mainInfoTranslate.name.ar !=
                                            null &&
                                        sponsorListItem
                                                .mainInfoTranslate.name.ar !=
                                            '') {
                                      return sponsorListItem
                                          .mainInfoTranslate.name.ar;
                                    } else {
                                      return sponsorListItem.name;
                                    }
                                  }(),
                                ),
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
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
