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
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
  }



