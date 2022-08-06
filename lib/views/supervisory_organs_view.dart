import 'package:bazaar_adm/controllers/supervisory_organs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/style_constants.dart';
import '../widgets/floating_action_button.dart';

class SupervisoryOrgansView extends StatelessWidget {
  SupervisoryOrgansView({Key? key}) : super(key: key);
  final SupervisoryOrgansController supervisoryOrgansController = Get.put(SupervisoryOrgansController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Supervisors"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
        itemCount: supervisoryOrgansController.supervisoryOrgans.length,
        itemBuilder: (context, index) => ListTile(
          leading: Text(supervisoryOrgansController.supervisoryOrgans.elementAt(index).id.toString()),
          title: Text(supervisoryOrgansController.supervisoryOrgans.elementAt(index).name),
          subtitle: Text(supervisoryOrgansController.supervisoryOrgans.elementAt(index).description),
        ), 
      ),
      floatingActionButton: const CustomFloatingActionButton(),
    );
  }
}