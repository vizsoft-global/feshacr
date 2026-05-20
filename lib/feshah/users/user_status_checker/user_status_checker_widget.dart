import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah/update_notifier/app_update_checker/app_update_checker_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_status_checker_model.dart';
export 'user_status_checker_model.dart';

class UserStatusCheckerWidget extends StatefulWidget {
  const UserStatusCheckerWidget({super.key});

  @override
  State<UserStatusCheckerWidget> createState() =>
      _UserStatusCheckerWidgetState();
}

class _UserStatusCheckerWidgetState extends State<UserStatusCheckerWidget> {
  late UserStatusCheckerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserStatusCheckerModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (loggedIn) {
        _model.forInappResult1 = await querySettingsRecordOnce(
          queryBuilder: (settingsRecord) => settingsRecord.where(
            'type',
            isEqualTo: 'Company',
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        if (FFAppState().currentUserRef == currentUserReference) {
          if (_model.forInappResult1?.settingsInappPurchaseStatus == true) {
            return;
          }

          if (valueOrDefault<bool>(
                  currentUserDocument?.completeProfileStatus, false) ==
              true) {
            if (valueOrDefault<bool>(
                    currentUserDocument?.isPhoneVerification, false) ==
                true) {
              if (FFAppState().appLang == 'en') {
                FFAppState().appLang = 'en';
                setAppLanguage(context, 'en');
              } else {
                if (FFAppState().appLang == 'ar') {
                  FFAppState().appLang = 'ar';
                  setAppLanguage(context, 'ar');
                }
              }
            } else {
              context.goNamed(CompleteProfileWidget.routeName);

              return;
            }
          } else {
            context.goNamed(CompleteProfileWidget.routeName);

            return;
          }
        } else {
          FFAppState().currentUserRef = currentUserReference;
          safeSetState(() {});
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

    return wrapWithModel(
      model: _model.appUpdateCheckerModel,
      updateCallback: () => safeSetState(() {}),
      child: AppUpdateCheckerWidget(),
    );
  }
}
