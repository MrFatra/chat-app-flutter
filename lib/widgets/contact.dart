import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/user.dart';

class ContactWidget extends StatelessWidget {
  final User user;

  const ContactWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              user.fullName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Gender: ${user.gender}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            SvgPicture.string(user.avatar),
          ],
        ),
      ),
    );
  }
}
