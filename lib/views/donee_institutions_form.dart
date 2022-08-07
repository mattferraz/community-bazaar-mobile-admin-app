import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/widgets/button.dart';
import 'package:bazaar_adm/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class DoneeInstitutionForm extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController? descriptionController = TextEditingController();

  DoneeInstitutionForm({Key? key}) : super(key: key);

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
                    "Cadastrar Instituição Donatária",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 60,),
                  CustomTextFormField(fieldLabel: "Name", controller: nameController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Address", controller: addressController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Phone Number", controller: phoneNumberController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Description", controller: descriptionController),
                  const SizedBox(height: 60),
                  CustomButton(
                    text: "Continue", 
                    onPressed: () => Navigator.pop(context, [nameController.text, addressController.text, phoneNumberController.text, descriptionController?.text])
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