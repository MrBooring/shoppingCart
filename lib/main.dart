import 'package:appcart/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/controller_binders/initial_binder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: routes,
      initialRoute: "/home",
      initialBinding: InitialBinding(),
    );
  }
}
