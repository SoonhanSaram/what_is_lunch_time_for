import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions_kakao_api.dart';

class KakaoMaps extends StatelessWidget {
  const KakaoMaps({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> positions = context.watch<FunctionsKakaoApi>().positions;
    double latitude = context.watch<FunctionsKakaoApi>().latitude;
    double longitude = context.watch<FunctionsKakaoApi>().longitude;
    return SafeArea(
      child: Scaffold(
        body: KakaoMapView(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          kakaoMapKey: dotenv.env['JAVASCRIPT_KEY'] ?? "",
          lat: latitude,
          lng: longitude,
          showMapTypeControl: true,
          draggableMarker: true,
        ),
      ),
    );
  }
}
