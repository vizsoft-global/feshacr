import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'address_popup_widget.dart' show AddressPopupWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddressPopupModel extends FlutterFlowModel<AddressPopupWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for street widget.
  FocusNode? streetFocusNode;
  TextEditingController? streetTextController;
  String? Function(BuildContext, String?)? streetTextControllerValidator;
  String? _streetTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'bysymna7' /* Street name is required */,
      );
    }

    if (val.length < 3) {
      return FFLocalizations.of(context).getText(
        '5qz8pa3q' /* Minimum 2 charcters are requir... */,
      );
    }
    if (val.length > 30) {
      return FFLocalizations.of(context).getText(
        'kcojrv62' /* Maximum 30 charcters are requi... */,
      );
    }
    if (!RegExp('^[A-Za-z0-9\\s,.-]{2,30}\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        '4le64np2' /* Please enter a valid street na... */,
      );
    }
    return null;
  }

  // State field(s) for building widget.
  FocusNode? buildingFocusNode;
  TextEditingController? buildingTextController;
  String? Function(BuildContext, String?)? buildingTextControllerValidator;
  String? _buildingTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'nu68rbjx' /* Building number is required */,
      );
    }

    if (!RegExp('^[0-9A-Za-z\\-]{1,10}\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'g27julso' /* Please enter a valid building ... */,
      );
    }
    return null;
  }

  // State field(s) for area widget.
  FocusNode? areaFocusNode;
  TextEditingController? areaTextController;
  String? Function(BuildContext, String?)? areaTextControllerValidator;
  String? _areaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'u4c2d65e' /* Area is required */,
      );
    }

    if (val.length < 2) {
      return FFLocalizations.of(context).getText(
        'uaibvg1l' /* Minimum 2 charcters are requir... */,
      );
    }
    if (val.length > 20) {
      return FFLocalizations.of(context).getText(
        'udjfpozg' /* Maximum 20 charcters are requi... */,
      );
    }
    if (!RegExp('^[A-Za-z\\s]{2,20}\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'e2aqh058' /* Please enter a valid area name... */,
      );
    }
    return null;
  }

  // State field(s) for city widget.
  FocusNode? cityFocusNode;
  TextEditingController? cityTextController;
  String? Function(BuildContext, String?)? cityTextControllerValidator;
  String? _cityTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'xc5fkfrd' /* City is required */,
      );
    }

    if (val.length < 2) {
      return FFLocalizations.of(context).getText(
        'zckie9gj' /* Minimum 2 charcters are requir... */,
      );
    }
    if (val.length > 20) {
      return FFLocalizations.of(context).getText(
        'rb3txu99' /* Maximum 2 charcters are requir... */,
      );
    }
    if (!RegExp('^[A-Za-z\\s]{2,20}\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'g0358rb8' /* Please enter a valid city name... */,
      );
    }
    return null;
  }

  // State field(s) for country widget.
  FocusNode? countryFocusNode;
  TextEditingController? countryTextController;
  String? Function(BuildContext, String?)? countryTextControllerValidator;
  String? _countryTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'z91nohtc' /* Country is required */,
      );
    }

    if (val.length < 2) {
      return FFLocalizations.of(context).getText(
        'ebj11s65' /* Minimum 2 charcters are requir... */,
      );
    }
    if (val.length > 20) {
      return FFLocalizations.of(context).getText(
        'spak6la1' /* Maximum 2 charcters are requir... */,
      );
    }
    if (!RegExp('^[A-Za-z\\s]{2,20}\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'jryizibj' /* Please enter a valid country n... */,
      );
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    streetTextControllerValidator = _streetTextControllerValidator;
    buildingTextControllerValidator = _buildingTextControllerValidator;
    areaTextControllerValidator = _areaTextControllerValidator;
    cityTextControllerValidator = _cityTextControllerValidator;
    countryTextControllerValidator = _countryTextControllerValidator;
  }

  @override
  void dispose() {
    streetFocusNode?.dispose();
    streetTextController?.dispose();

    buildingFocusNode?.dispose();
    buildingTextController?.dispose();

    areaFocusNode?.dispose();
    areaTextController?.dispose();

    cityFocusNode?.dispose();
    cityTextController?.dispose();

    countryFocusNode?.dispose();
    countryTextController?.dispose();
  }
}
