import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? isWeb
          ? Container()
          : Container(
              color: Colors.transparent,
              child: Image.asset(
                'assets/images/FeshahAnimationBestQuality-ezgif.com-optimize.gif',
                fit: BoxFit.cover,
              ),
            )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'Register': ParameterData.none(),
  'Login': ParameterData.none(),
  'Profile': ParameterData.none(),
  'Home': ParameterData.none(),
  'Welcome': ParameterData.none(),
  'RoomCreate-S2': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'EditProfile': ParameterData.none(),
  'RoomCreate-S1': ParameterData.none(),
  'RoomSpace': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'RoomJoin': ParameterData.none(),
  'MyFeshah': ParameterData.none(),
  'Notification': ParameterData.none(),
  'Badges': ParameterData.none(),
  'Settings': ParameterData.none(),
  'GameOne': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'GameOne-S2': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
          'tieBreakStatus': getParameter<bool>(data, 'tieBreakStatus'),
        },
      ),
  'GameOne-S3': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'GameTwo': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'Game3-RoomModeInvite': ParameterData.none(),
  'Game3-AccountModeInvite': ParameterData.none(),
  'Game3-Round1': ParameterData.none(),
  'Game3-BlueThemeforvoting': ParameterData.none(),
  'GameOne-S1': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'Signin-phone': ParameterData.none(),
  'Verify-mobile': ParameterData.none(),
  'Onboard': ParameterData.none(),
  'AccountStats': ParameterData.none(),
  'Payment': ParameterData.none(),
  'verify': ParameterData.none(),
  'Success': ParameterData.none(),
  'Failed': ParameterData.none(),
  'Transaction': ParameterData.none(),
  'TransactionRoom': ParameterData.none(),
  'TermsofService': ParameterData.none(),
  'CompleteProfile': ParameterData.none(),
  'GameFour': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'GameFour-S1': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'GameFour-S3': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'GameFour-S2': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
          'tieBreakStatus': getParameter<bool>(data, 'tieBreakStatus'),
        },
      ),
  'AboutApp': ParameterData.none(),
  'GameOneCopy': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'GameFour-S1Copy': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'GameFive': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
  'GameSix': (data) async => ParameterData(
        allParams: {
          'room': getParameter<DocumentReference>(data, 'room'),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
