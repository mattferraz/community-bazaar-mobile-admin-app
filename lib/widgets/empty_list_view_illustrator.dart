import 'package:flutter/material.dart';

import '../constants/size_config.dart';

class EmptyListViewIllustrator extends StatelessWidget {
  final String message;
  final String imagePath;

  const EmptyListViewIllustrator({
    required this.message,
    required this.imagePath,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: SizeConfig.kDeviceHeight * 0.55),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Color(0xFF616161)),
        )
      ],
    );
  }
}