import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'app_language_model.dart';
export 'app_language_model.dart';

class AppLanguageWidget extends StatefulWidget {
  const AppLanguageWidget({super.key});

  @override
  State<AppLanguageWidget> createState() => _AppLanguageWidgetState();
}

class _AppLanguageWidgetState extends State<AppLanguageWidget> {
  late AppLanguageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppLanguageModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().appLang == 'en') {
        FFAppState().appLang = 'en';
        setAppLanguage(context, 'en');
      } else {
        if (FFAppState().appLang == 'ar') {
          FFAppState().appLang = 'ar';
          setAppLanguage(context, 'ar');
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
    context.watch<FFAppState>();

    return Container();
  }
}
