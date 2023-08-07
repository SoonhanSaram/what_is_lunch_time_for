import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class KakaoMaps extends StatelessWidget {
  const KakaoMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: KakaoMap());
  }
}
