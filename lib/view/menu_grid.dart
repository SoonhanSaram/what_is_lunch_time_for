import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';
import 'package:what_is_lunch_time_for/service/functions_animation.dart';

Expanded menuGrid(BuildContext context) {
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
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 5000),
          child: functionProvider.showBack[index]
              ? TextButton(
                  onPressed: () {
                    functionProvider.showBackSwitch(index);
                  },
                  child: Text(
                    functionProvider.menus[index],
                    style: const TextStyle(fontSize: 36),
                  ),
                )
              : TextButton(
                  onPressed: () {
                    functionProvider.showBackSwitch(index);
                  },
                  child: Text(
                    "${functionProvider.menus[index]} 삭제",
                    style: const TextStyle(fontSize: 36),
                  )),
        );
      },
    ),
  );
}
