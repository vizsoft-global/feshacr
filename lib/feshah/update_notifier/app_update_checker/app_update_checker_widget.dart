import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/feshah/update_notifier/app_updater_popup_android/app_updater_popup_android_widget.dart';
import '/feshah/update_notifier/app_updater_popup_i_o_s/app_updater_popup_i_o_s_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'app_update_checker_model.dart';
export 'app_update_checker_model.dart';

class AppUpdateCheckerWidget extends StatefulWidget {
  const AppUpdateCheckerWidget({super.key});

  @override
  State<AppUpdateCheckerWidget> createState() => _AppUpdateCheckerWidgetState();
}

class _AppUpdateCheckerWidgetState extends State<AppUpdateCheckerWidget> {
  late AppUpdateCheckerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppUpdateCheckerModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (isAndroid) {
        _model.appVersionResultAndroid = await querySettingsRecordOnce(
          queryBuilder: (settingsRecord) => settingsRecord.where(
            'type',
            isEqualTo: 'Company',
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        if (_model.appVersionResultAndroid!.settingsAppVersionInfo
                .androidVersionInt <
            _model.appVersionResultAndroid!.settingsAppVersionInfo
                .androidVersionInt) {
          await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (dialogContext) {
              return Dialog(
                elevation: 0,
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                alignment: AlignmentDirectional(0.0, 0.0)
                    .resolve(Directionality.of(context)),
                child: WebViewAware(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    child: AppUpdaterPopupAndroidWidget(),
                  ),
                ),
              );
            },
          );

          return;
        } else {
          return;
        }
      } else {
        if (isiOS) {
          _model.appVersionResultIOS = await querySettingsRecordOnce(
            queryBuilder: (settingsRecord) => settingsRecord.where(
              'type',
              isEqualTo: 'Company',
            ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          if (_model.appVersionResultIOS!.settingsAppVersionInfo.iosVersionInt <
              _model
                  .appVersionResultIOS!.settingsAppVersionInfo.iosVersionInt) {
            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (dialogContext) {
                return Dialog(
                  elevation: 0,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alignment: AlignmentDirectional(0.0, 0.0)
                      .resolve(Directionality.of(context)),
                  child: WebViewAware(
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.95,
                      child: AppUpdaterPopupIOSWidget(),
                    ),
                  ),
                );
              },
            );

            return;
          } else {
            return;
          }
        } else {
          return;
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
    return Builder(
      builder: (context) => Container(),
    );
  }
}
