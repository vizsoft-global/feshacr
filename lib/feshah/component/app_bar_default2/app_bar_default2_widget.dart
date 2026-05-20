import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'app_bar_default2_model.dart';
export 'app_bar_default2_model.dart';

class AppBarDefault2Widget extends StatefulWidget {
  const AppBarDefault2Widget({
    super.key,
    String? exitButtonStatus,
    required this.pageTitle,
    required this.notificationNavStatus,
    required this.backNavStatus,
  }) : this.exitButtonStatus = exitButtonStatus ?? 'show';

  final String exitButtonStatus;
  final String? pageTitle;
  final bool? notificationNavStatus;
  final bool? backNavStatus;

  @override
  State<AppBarDefault2Widget> createState() => _AppBarDefault2WidgetState();
}

class _AppBarDefault2WidgetState extends State<AppBarDefault2Widget> {
  late AppBarDefault2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppBarDefault2Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.safePop();
              },
              child: Icon(
                Icons.chevron_left_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget!.pageTitle,
                      'pageTitle',
                    ),
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
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
            ),
            Icon(
              Icons.keyboard_control,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
          ].divide(SizedBox(width: 12.0)),
        ),
      ],
    );
  }
}
