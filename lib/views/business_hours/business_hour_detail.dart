import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:bazaar_adm/views/business_hours/business_hours_form.dart';
import 'package:flutter/material.dart';

import '../../constants/size_config.dart';
import '../../models/business_hour.dart';

class BusinessHourDetail extends StatelessWidget {
  final BusinessHour businessHour;
  final DoneeInstitution doneeInstitution;
  final Map<int, String> weekdays;

  const BusinessHourDetail({
    required this.doneeInstitution,
    required this.businessHour,
    required this.weekdays,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: SizeConfig.kDeviceHeight,
        width: SizeConfig.kDeviceWidth,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close)
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BusinessHoursForm(businessHour: businessHour ,doneeInstitution: doneeInstitution, weekdays: weekdays))), 
                      icon: const Icon(Icons.edit_rounded)
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                const Text(
                  "Detalhes",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Instituição Donatária: ${businessHour.doneeInstitution.name}"),
                    Text("Dia da Semana: ${weekdays[businessHour.weekday]}"),
                    Text("Horário Inicial: ${businessHour.openTime.format(context)}"),
                    Text("Horário Final: ${businessHour.closeTime.format(context)}"),
                  ],
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}