import 'package:crud_api/router/router.dart';
import 'package:crud_api/themes/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Crud Api',
      debugShowCheckedModeBanner: false,
      theme: theme
    );
  }
}