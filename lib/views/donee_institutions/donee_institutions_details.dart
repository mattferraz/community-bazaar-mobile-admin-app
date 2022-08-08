import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/constants/style_constants.dart';
import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:bazaar_adm/views/donee_institutions/donee_institutions_form.dart';
import 'package:flutter/material.dart';

import '../business_hours/business_hours_view.dart';

class DoneeInstitutionDetails extends StatelessWidget {
  final DoneeInstitution doneeInstitution;
  const DoneeInstitutionDetails({
    required this.doneeInstitution,
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
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DoneeInstitutionForm(doneeInstitution: doneeInstitution))), 
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
                    Text("Nome: ${doneeInstitution.name}"),
                    Text("Endereço: ${doneeInstitution.address}"),
                    Text("Telefone: ${doneeInstitution.phoneNumber}"),
                    Text("Descrição: ${doneeInstitution.description}"),
                  ],
                ),
                const SizedBox(height: 40,),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessHourView(doneeInstitution: doneeInstitution))), 
                  child: const Text("Visualizar horários de trabalho", style: TextStyle(color: StyleConstants.primaryColor)),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}