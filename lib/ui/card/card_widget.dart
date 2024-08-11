import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/assets.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  offset: Offset(4,8),
                  color: Colors.grey
              ),
            ]
        ),
        child: Image.asset(Assets.card),
      ),
    );
  }
}