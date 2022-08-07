import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/constants/style_constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;

  const CustomButton({
    this.onPressed,
    this.text,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.kDeviceWidth,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: StyleConstants.primaryColor
        ), 
        child: Text(
          text ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}