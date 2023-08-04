import 'package:flutter/material.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';

SizedBox ranndomButton(Functions functionProvider, BuildContext context) {
  return SizedBox(
    width: 130,
    child: FilledButton(
      onPressed: () {
        functionProvider.roulette(context);
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
