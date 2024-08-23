import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:info_91_proj/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}
