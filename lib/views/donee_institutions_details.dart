import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/controllers/business_hours_controller.dart';
import 'package:bazaar_adm/controllers/donee_institutions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class DoneeInstitutionDetails extends StatelessWidget {
  DoneeInstitutionDetails({Key? key}) : super(key: key);
  final BusinessHoursController _businessHoursController = Get.put(BusinessHoursController());
  final DoneeInstitutionController _doneeInstitutionController = Get.put(DoneeInstitutionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: SizeConfig.kDeviceHeight,
        width: SizeConfig.kDeviceWidth,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ),
      ),
    );
  }
}