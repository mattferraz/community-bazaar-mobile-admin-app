import 'package:bazaar_adm/controllers/donee_institutions_controller.dart';
import 'package:bazaar_adm/views/donee_institutions_form.dart';
import 'package:bazaar_adm/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../constants/size_config.dart';
import '../constants/style_constants.dart';

class DoneeInstitutionsView extends StatelessWidget {
  DoneeInstitutionsView({Key? key}) : super(key: key);
  final DoneeInstitutionController _controller = Get.put(DoneeInstitutionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Supervisors"),
        actions: [
          Obx(() {
            if(_controller.selectedDoneeInstitutions.isNotEmpty) {
              return IconButton(
                onPressed: () => _controller.deleteMultipleDoneeInstitutions(_controller.selectedDoneeInstitutions),
                icon: const Icon(Icons.delete_rounded)
              );
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
      body: SizedBox(
        width: SizeConfig.kDeviceWidth,
        height: SizeConfig.kDeviceHeight,
        child: SafeArea(
          child: Obx(() => ListView.separated(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
            itemCount: _controller.doneeInstitutions.length,
            itemBuilder: (context, index) => Obx(() => ListTile(
              leading: Text(_controller.doneeInstitutions[index].id.toString()),
              title: Text(_controller.doneeInstitutions[index].name),
              subtitle: Text(_controller.doneeInstitutions[index].address),
              selectedTileColor: const Color(0xFF90CAF9),
              selectedColor: const Color(0xFF90CAF9),
              selected: _controller.selectedDoneeInstitutions.contains(_controller.doneeInstitutions[index]),
              onLongPress: () {
                _controller.selectedDoneeInstitutions.contains(_controller.doneeInstitutions[index])
                  ? _controller.selectedDoneeInstitutions.remove(_controller.doneeInstitutions[index])
                  : _controller.selectedDoneeInstitutions.add(_controller.doneeInstitutions[index]);
              },
            )) 
          ),
        )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          final List<String?> fields = await Navigator.push(context, MaterialPageRoute(builder: (context) => DoneeInstitutionForm()));
          _controller.createDoneeInstitution(fields[0]!, fields[1]!, fields[2]!, fields[3]);
        },
      ),
    );
  }
}