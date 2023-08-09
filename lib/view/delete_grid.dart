import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';
import 'package:what_is_lunch_time_for/service/functions_animation.dart';

Expanded deleteGrid(BuildContext context) {
  FunctionsAnimation functionsAnimation = Provider.of<FunctionsAnimation>(context, listen: false);
  Functions functionProvider = Provider.of<Functions>(context, listen: true);
  return Expanded(
    child: GridView.builder(
      itemCount: functionProvider.menus.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 1,
      ),
      itemBuilder: (BuildContext context, index) {
        return TextButton(
          onPressed: () {
            functionsAnimation.showBackSwitch();
          },
          child: Text(
            "${functionProvider.menus[index]} 삭제",
            style: const TextStyle(fontSize: 36),
          ),
        );
      },
    ),
  );
}
