import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/feshah/onboard/walkthrough/walkthrough1/walkthrough1_widget.dart';
import '/feshah/onboard/walkthrough/walkthrough2/walkthrough2_widget.dart';
import '/feshah/onboard/walkthrough/walkthrough3/walkthrough3_widget.dart';
import '/feshah/onboard/walkthrough/walkthrough4/walkthrough4_widget.dart';
import '/feshah/onboard/walkthrough/walkthrough5/walkthrough5_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

// Focus widget keys for this walkthrough
final rowGaqv5mr1 = GlobalKey();
final buttonOw6ykdi0 = GlobalKey();
final containerY7guhce8 = GlobalKey();
final containerTdx40i2i = GlobalKey();
final container7a7xiv8s = GlobalKey();

/// Home
///
///
List<TargetFocus> createWalkthroughTargets(BuildContext context) => [
      /// Gamegrid
      TargetFocus(
        keyTarget: rowGaqv5mr1,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => Walkthrough1Widget(),
          ),
        ],
      ),

      /// Room
      TargetFocus(
        keyTarget: buttonOw6ykdi0,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => Walkthrough2Widget(),
          ),
        ],
      ),

      /// Coins
      TargetFocus(
        keyTarget: containerY7guhce8,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => Walkthrough3Widget(),
          ),
        ],
      ),

      /// QR
      TargetFocus(
        keyTarget: containerTdx40i2i,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => Walkthrough4Widget(),
          ),
        ],
      ),

      /// Navbar
      TargetFocus(
        keyTarget: container7a7xiv8s,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => Walkthrough5Widget(),
          ),
        ],
      ),
    ];
