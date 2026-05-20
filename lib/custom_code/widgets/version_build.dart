// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// DO NOT REMOVE OR MODIFY THE CODE ABOV

import 'package:package_info_plus/package_info_plus.dart';

class VersionBuild extends StatefulWidget {
  const VersionBuild({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<VersionBuild> createState() => _VersionBuildState();
}

class _VersionBuildState extends State<VersionBuild> {
  String _version = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
      _buildNumber = info.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Version: $_version Build $_buildNumber'),
    );
  }
}
