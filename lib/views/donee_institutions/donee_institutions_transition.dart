import 'package:bazaar_adm/views/business_hours/business_hours_view.dart';
import 'package:flutter/material.dart';

import '../../constants/size_config.dart';
import '../../models/donee_institution.dart';
import '../../widgets/button.dart';

class DoneeInstitutionCreatedTransition extends StatelessWidget {
  final DoneeInstitution doneeInstitution;
  const DoneeInstitutionCreatedTransition({
    required this.doneeInstitution,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: SizeConfig.kDeviceHeight,
        width: SizeConfig.kDeviceWidth,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Cadastre os horários de funcionamento da instituição",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image.asset("assets/images/Time management-rafiki(1).png", height: SizeConfig.kDeviceHeight * 0.55),
                  CustomButton(
                    text: "Continuar", 
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BusinessHourView(doneeInstitution: doneeInstitution)))
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}