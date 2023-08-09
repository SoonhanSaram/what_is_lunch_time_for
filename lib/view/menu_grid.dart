import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_is_lunch_time_for/service/functions.dart';

Expanded menuGrid(BuildContext context) {
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
          transitionBuilder: (Widget child, Animation<double> animation) {
            return wrapAnimatedBuilder(
              child,
              animation,
              functionProvider.showBack[index],
            );
          },
          layoutBuilder: (widget, list) {
            return functionProvider.showBack[index]
                ? Stack(
                    alignment: Alignment.topCenter,
                    children: [widget!],
                  )
                : Stack(
                    alignment: Alignment.topCenter,
                    children: [widget!, ...list],
                  );
          },
          duration: const Duration(milliseconds: 500),
          child: functionProvider.showBack[index]
              ? TextButton(
                  key: ValueKey<int>(index + 1),
                  onPressed: () {
                    functionProvider.showBackSwitch(index);
                  },
                  child: Text(
                    functionProvider.menus[index],
                    style: const TextStyle(fontSize: 36),
                  ),
                )
              : TextButton(
                  key: ValueKey<int>(-index - 1),
                  onPressed: () {
                    functionProvider.showBackSwitch(index);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          textAlign: TextAlign.right,
                          functionProvider.menus[index],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            functionProvider.deleteMenus(functionProvider.menus[index], index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    ),
  );
}

// transitionAnimation 효과
Widget wrapAnimatedBuilder(Widget widget, Animation<double> animation, bool showBack) {
  final rotate = Tween(begin: pi, end: 0.0).animate(animation);

  return AnimatedBuilder(
    animation: rotate,
    child: widget,
    builder: (_, widget) {
      final isBack = showBack ? widget!.key == const ValueKey(false) : widget!.key != const ValueKey(false);

      final value = isBack ? min(rotate.value, pi / 2) : rotate.value;

      return Transform(
        transform: Matrix4.rotationY(value),
        alignment: Alignment.center,
        child: widget,
      );
    },
  );
}
