import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/feshah/component/app_language/app_language_widget.dart';
import '/feshah/component/empty_widget_game/empty_widget_game_widget.dart';
import '/feshah/component/empty_widget_room/empty_widget_room_widget.dart';
import '/feshah/component/navbar/navbar_widget.dart';
import '/feshah/component/sponsor/sponsor_widget.dart';
import '/feshah/payment/point_list_private_wallet/point_list_private_wallet_widget.dart';
import '/feshah/users/user_status_checker/user_status_checker_widget.dart';
import '/feshah_game_zone/game/game_grid/game_grid_widget.dart';
import '/feshah_game_zone/game/game_status_checker/game_status_checker_widget.dart';
import '/feshah_game_zone/main/home_q_r/home_q_r_widget.dart';
import '/feshah_game_zone/main/home_roomlist/home_roomlist_widget.dart';
import '/feshah_game_zone/main/home_sponsor/home_sponsor_widget.dart';
import '/feshah_game_zone/main/home_widget1/home_widget1_widget.dart';
import '/feshah_game_zone/main/home_widget2/home_widget2_widget.dart';
import '/feshah_game_zone/main/home_widget2_landscape/home_widget2_landscape_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/walkthroughs/home.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  int? refresh = 1;

  bool walletClickStatus = false;

  ///  State fields for stateful widgets in this page.

  TutorialCoachMark? homeController;
  // Stores action output result for [Backend Call - Read Document] action in Home widget.
  UsersRecord? presentUserAuth;
  // Stores action output result for [Backend Call - Read Document] action in Home widget.
  UsersRecord? presentUserAuthCom;
  // Stores action output result for [Backend Call - Read Document] action in Home widget.
  UsersRecord? presentUserAuthSkip;
  // Model for app_language component.
  late AppLanguageModel appLanguageModel;
  // Model for user_status_checker component.
  late UserStatusCheckerModel userStatusCheckerModel;
  // Model for game_status_checker component.
  late GameStatusCheckerModel gameStatusCheckerModel;
  // Model for home_QR component.
  late HomeQRModel homeQRModel;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<PointRecord>? pointResult;
  // Model for home_sponsor component.
  late HomeSponsorModel homeSponsorModel;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  // Model for CreateaRoom.
  late HomeWidget1Model createaRoomModel;
  // Model for JoinaRoom.
  late HomeWidget1Model joinaRoomModel;
  // Model for Navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    appLanguageModel = createModel(context, () => AppLanguageModel());
    userStatusCheckerModel =
        createModel(context, () => UserStatusCheckerModel());
    gameStatusCheckerModel =
        createModel(context, () => GameStatusCheckerModel());
    homeQRModel = createModel(context, () => HomeQRModel());
    homeSponsorModel = createModel(context, () => HomeSponsorModel());
    createaRoomModel = createModel(context, () => HomeWidget1Model());
    joinaRoomModel = createModel(context, () => HomeWidget1Model());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    homeController?.finish();
    appLanguageModel.dispose();
    userStatusCheckerModel.dispose();
    gameStatusCheckerModel.dispose();
    homeQRModel.dispose();
    homeSponsorModel.dispose();
    createaRoomModel.dispose();
    joinaRoomModel.dispose();
    navbarModel.dispose();
  }
}
