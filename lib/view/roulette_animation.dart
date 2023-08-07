import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions_roulette.dart';

class RouletteAnimation extends StatelessWidget {
  const RouletteAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> flickerTitle = context.watch<FunctionsRoulette>().randomIndexList;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color.fromARGB(255, 175, 164, 164)),
            ),
            child: Text(
              flickerTitle[0],
              style: const TextStyle(fontSize: 36),
            ),
          ),
        ),
      ),
    );
  }
}
