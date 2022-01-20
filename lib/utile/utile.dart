import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Utile{
 
  static Future<bool> tryConnection() async {
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

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 7),
    )
  );

}



