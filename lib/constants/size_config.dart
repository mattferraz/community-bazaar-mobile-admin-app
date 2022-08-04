import 'package:flutter/cupertino.dart';

class SizeConfig {
    static const double kdefaultPadding = 20;
    static double kDeviceHeight = 0.0;
    static double kDeviceWidth = 0.0;

    void initSizeConfig(BuildContext context) {
        kDeviceWidth = MediaQuery.of(context).size.width;
        kDeviceHeight = MediaQuery.of(context).size.height;
    }
}