import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/controllers/donee_institutions_controller.dart';
import 'package:bazaar_adm/views/donee_institutions/donee_institutions_transition.dart';
import 'package:bazaar_adm/widgets/button.dart';
import 'package:bazaar_adm/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../models/donee_institution.dart';


class DoneeInstitutionForm extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController? descriptionController = TextEditingController();

  final DoneeInstitutionController _controller = Get.put(DoneeInstitutionController());

  final DoneeInstitution? doneeInstitution;

  DoneeInstitutionForm({
    this.doneeInstitution,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (doneeInstitution != null) {
      nameController.text = doneeInstitution!.name;
      phoneNumberController.text = doneeInstitution!.phoneNumber;
      addressController.text = doneeInstitution!.address;
      descriptionController?.text = doneeInstitution!.description ?? "";
    }
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
                      icon: const Icon(Icons.close)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  doneeInstitution == null 
                  ? const Text(
                    "Cadastrar Instituição Donatária",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                  : const Text(
                    "Editar Instituição Donatária",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40,),
                  CustomTextFormField(fieldLabel: "Nome", controller: nameController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Endereço", controller: addressController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Telefone", controller: phoneNumberController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Descrição", controller: descriptionController),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: doneeInstitution == null ? "Continuar" : "Editar", 
                    onPressed: doneeInstitution == null ? () {
                      _controller.createDoneeInstitution(
                        nameController.text, 
                        addressController.text, 
                        phoneNumberController.text, 
                        descriptionController?.text
                      ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DoneeInstitutionCreatedTransition(doneeInstitution: value))));                      
                    } : () {
                      doneeInstitution?.name = nameController.text;
                      doneeInstitution?.address = addressController.text;
                      doneeInstitution?.phoneNumber = phoneNumberController.text;
                      doneeInstitution?.description = descriptionController?.text;
                      _controller.updateDoneeInstitution(doneeInstitution!);
                      Navigator.pop(context);
                    }
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