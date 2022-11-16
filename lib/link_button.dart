import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkButton extends StatelessWidget {
  final FaIcon currentIcon;
  final String url;
  final String name;

  LinkButton({Key? key, required this.currentIcon, required this.url, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "See song in $name",
      child: IconButton(onPressed: _launchUrl, icon: currentIcon, iconSize: 50,)
      );
  }

  Future<void> _launchUrl() async {
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}