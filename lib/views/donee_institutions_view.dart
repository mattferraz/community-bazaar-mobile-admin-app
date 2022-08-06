import 'package:bazaar_adm/controllers/donee_institutions_controller.dart';
import 'package:bazaar_adm/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../constants/style_constants.dart';

class DoneeInstitutionsView extends StatelessWidget {
  DoneeInstitutionsView({Key? key}) : super(key: key);
  final DoneeInstitutionController _doneeInstitutionController = Get.put(DoneeInstitutionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Donors"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
        itemCount: _doneeInstitutionController.doneeInstitutions.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_doneeInstitutionController.doneeInstitutions.elementAt(index).name),
          subtitle: Text(_doneeInstitutionController.doneeInstitutions.elementAt(index).address),
        ), 
      ),
      floatingActionButton: const CustomFloatingActionButton(),
    );
  }
}