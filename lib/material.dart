import 'package:chat_app/helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper/pages.dart';

class MainMaterial extends StatelessWidget {
  const MainMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      getPages: pageList(),
      initialRoute: '/splash',
    );
  }
}
