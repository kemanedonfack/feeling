import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


  Future<bool> tryConnection() async {
    try {
      final response = await InternetAddress.lookup('console.firebase.google.com');
          
        if (kDebugMode) {
          print("reponse $response");
        }
      return true;
    } on SocketException {   
      return false;
    }
  }

  final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 7),
    )
  );

  extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
  }

  // String readTimestamp(int timestamp) {
  //   var now =  DateTime.now();
  //   var format =  DateFormat('HH:mm a');
  //   var date =  DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  //   var diff = date.difference(now);
  //   var time = '';

  //   if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
  //     time = format.format(date);
  //   } else {
  //     if (diff.inDays == 1) {
  //       time = diff.inDays.toString() + 'DAY AGO';
  //     } else {
  //       time = diff.inDays.toString() + 'DAYS AGO';
  //     }
  //   }

  //   return time;
  // }

  String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    if (diff.inHours > 0) {
      time = diff.inHours.toString() + 'h ago';
    }else if (diff.inMinutes > 0) {
      time = diff.inMinutes.toString() + 'm ago';
    }else if (diff.inSeconds > 0) {
      time = 'now';
    }else if (diff.inMilliseconds > 0) {
      time = 'now';
    }else if (diff.inMicroseconds > 0) {
      time = 'now';
    }else {
      time = 'now';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() + 'd ago';
  } else if (diff.inDays > 6){
      time = (diff.inDays / 7).floor().toString() + 'w ago';
  }else if (diff.inDays > 29) {
      time = (diff.inDays / 30).floor().toString() + 'm ago';
  }else if (diff.inDays > 365) {
    time = '${date.month}-${date.day}-${date.year}';
  }
  return time;
}

