import 'package:flutter/material.dart';

import '../barbershop_icons.dart';
import '../constants.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 102,
      width: 102,
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.avatar),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: ColorsConstants.brow,
                  width: 4,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                BarbershopIcons.addEmployee,
                color: ColorsConstants.brow,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
