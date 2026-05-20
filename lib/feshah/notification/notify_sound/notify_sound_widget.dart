import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'notify_sound_model.dart';
export 'notify_sound_model.dart';

class NotifySoundWidget extends StatefulWidget {
  const NotifySoundWidget({super.key});

  @override
  State<NotifySoundWidget> createState() => _NotifySoundWidgetState();
}

class _NotifySoundWidgetState extends State<NotifySoundWidget> {
  late NotifySoundModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotifySoundModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (currentUserDocument?.userSetting?.isSoundstatus != true) {
        return;
      }
      _model.soundPlayer ??= AudioPlayer();
      if (_model.soundPlayer!.playing) {
        await _model.soundPlayer!.stop();
      }
      _model.soundPlayer!.setVolume(0.2);
      _model.soundPlayer!
          .setAsset('assets/audios/New_Notification.mp3')
          .then((_) => _model.soundPlayer!.play());
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
    return Container();
  }
}
