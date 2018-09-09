/*
    Created by Tim Theisinger on 09.09.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:url_launcher/url_launcher.dart';

class URLUtil {
  static void launchURL() async {
    const url = 'https://erasmusplus.de';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
