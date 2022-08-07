import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/controllers/donee_institutions_controller.dart';
import 'package:bazaar_adm/controllers/supervisory_organs_controller.dart';
import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:bazaar_adm/models/supervisory_organ.dart';
import 'package:bazaar_adm/widgets/button.dart';
import 'package:bazaar_adm/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/style_constants.dart';

class ProductsBatchForm extends StatefulWidget {

  const ProductsBatchForm({Key? key}) : super(key: key);

  @override
  State<ProductsBatchForm> createState() => _ProductsBatchFormState();
}

class _ProductsBatchFormState extends State<ProductsBatchForm> {
  final TextEditingController noteController = TextEditingController();

  final SupervisoryOrgansController _supervisoryOrgansController = Get.put(SupervisoryOrgansController());

  final DoneeInstitutionController _doneeInstitutionController = Get.put(DoneeInstitutionController());

  DoneeInstitution? doneeInstitution;

  SupervisoryOrgan? supervisoryOrgan;

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
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Cadastrar Lote de Produtos",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40,),
                  CustomTextFormField(fieldLabel: "Observação", controller: noteController),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<dynamic>(
                    items: List<DropdownMenuItem>.from(_doneeInstitutionController.doneeInstitutions.map((element) => DropdownMenuItem(value: element, child: Text(element.name)))),
                    value: doneeInstitution,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: Colors.grey.shade400)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1.5, color: StyleConstants.primaryColor)
                      ),
                      label: const Text("Instituição Donatária"),
                      fillColor: Colors.white
                    ),
                    onChanged: (value) {
                      if (value is DoneeInstitution) {
                        setState(() {
                          doneeInstitution = value;
                        });
                      }
                    }
                  ),
                  const SizedBox(height: 20,),
                  DropdownButtonFormField<dynamic>(
                    items: List<DropdownMenuItem>.from(_supervisoryOrgansController.supervisoryOrgans.map((element) => DropdownMenuItem(value: element, child: Text(element.name)))),
                    value: supervisoryOrgan,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: Colors.grey.shade400)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1.5, color: StyleConstants.primaryColor)
                      ),
                      label: const Text("Orgão Supervisor"),
                      fillColor: Colors.white
                    ),
                    onChanged: (value) {
                      if (value is SupervisoryOrgan) {
                        setState(() {
                          supervisoryOrgan = value;
                        });
                      }
                    }
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Continuar", 
                    onPressed: () => Navigator.pop(context, [noteController.text, DateTime.now().toLocal(), supervisoryOrgan, doneeInstitution])
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