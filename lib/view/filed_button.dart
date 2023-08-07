import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';
import 'package:what_is_lunch_time_for/service/functions_roulette.dart';

SizedBox ranndomButton(Functions functionProvider, BuildContext context) {
  FunctionsRoulette functionsRoulette = Provider.of<FunctionsRoulette>((context), listen: false);
  return SizedBox(
    width: 130,
    child: FilledButton(
      onPressed: () {
        functionsRoulette.flickerAnimation(context, functionProvider.menus);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/roulette.png",
            height: 40,
          ),
          const Text("추첨하기")
        ],
      ),
    ),
  );
}
