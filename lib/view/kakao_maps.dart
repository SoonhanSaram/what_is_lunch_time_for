import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions_kakao_api.dart';

class KakaoMaps extends StatelessWidget {
  const KakaoMaps({super.key});

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = context.watch<FunctionsKakaoApi>().markers;
    double latitude = context.watch<FunctionsKakaoApi>().latitude;
    double longitude = context.watch<FunctionsKakaoApi>().longitude;
    return SafeArea(
      child: Scaffold(
          body: KakaoMap(
        markers: markers,
        center: LatLng(latitude, longitude),
      )),
    );
  }
}
