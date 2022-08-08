import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/controllers/supervisory_organs_controller.dart';
import 'package:bazaar_adm/models/supervisory_organ.dart';
import 'package:bazaar_adm/widgets/button.dart';
import 'package:bazaar_adm/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SupervisoryOrganForm extends StatelessWidget {
  final SupervisoryOrgan? supervisoryOrgan;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final SupervisoryOrgansController _controller = Get.find<SupervisoryOrgansController>();

  SupervisoryOrganForm({
    this.supervisoryOrgan,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (supervisoryOrgan != null) {
      nameController.text = supervisoryOrgan!.name;
      descriptionController.text = supervisoryOrgan!.description;
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
                  supervisoryOrgan == null ? const Text(
                    "Cadastrar Orgão Fiscalizador",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                  :const Text(
                    "Editar Orgão Fiscalizador",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextFormField(fieldLabel: "Nome", controller: nameController),
                  const SizedBox(height: 20),
                  CustomTextFormField(fieldLabel: "Descrição", controller: descriptionController),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Continuar", 
                    onPressed: supervisoryOrgan == null ? () {
                      Navigator.pop(context, [nameController.text, descriptionController.text]);
                    }
                    :() {
                      supervisoryOrgan!.name = nameController.text;
                      supervisoryOrgan!.description = descriptionController.text;
                      _controller.updateSupervisoryOrgan(supervisoryOrgan!);
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