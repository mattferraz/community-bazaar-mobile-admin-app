import 'package:bazaar_adm/controllers/donee_institutions_controller.dart';
import 'package:bazaar_adm/views/donee_institutions/donee_institutions_details.dart';
import 'package:bazaar_adm/views/donee_institutions/donee_institutions_form.dart';
import 'package:bazaar_adm/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../constants/size_config.dart';
import '../../constants/style_constants.dart';
import '../../models/donee_institution.dart';
import '../../widgets/empty_list_view_illustrator.dart';

class DoneeInstitutionsView extends StatelessWidget {
  DoneeInstitutionsView({Key? key}) : super(key: key);
  final DoneeInstitutionController _controller = Get.put(DoneeInstitutionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Doadores"),
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
          child: Obx(() => _controller.doneeInstitutions.isEmpty 
          ? const Padding(
            padding: EdgeInsets.all(SizeConfig.kdefaultPadding),
            child: EmptyListViewIllustrator(
              message: "Você ainda não cadastrou nenhuma instituição donatária. Clique no botão abaixo para cadastrar uma nova.", 
              imagePath: "assets/images/Problem solving-pana.png"
            ),
          ) 
          : ListView.separated(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
            itemCount: _controller.doneeInstitutions.length,
            itemBuilder: (context, index) {
              DoneeInstitution currentDoneeInstitution = _controller.doneeInstitutions[index];
              return Obx(() => ListTile(
              leading: Text(currentDoneeInstitution.id.toString()),
              title: Text(currentDoneeInstitution.name),
              subtitle: Text(currentDoneeInstitution.address),
              selectedTileColor: const Color(0xFF90CAF9),
              selectedColor: const Color(0xFF90CAF9),
              selected: _controller.selectedDoneeInstitutions.contains(currentDoneeInstitution),
              onLongPress: () {
                _controller.selectedDoneeInstitutions.contains(currentDoneeInstitution)
                  ? _controller.selectedDoneeInstitutions.remove(currentDoneeInstitution)
                  : _controller.selectedDoneeInstitutions.add(currentDoneeInstitution);
              },
              onTap: () {
                _controller.selectedDoneeInstitutions.isEmpty 
                ? Navigator.push(context, MaterialPageRoute(builder: (context) => DoneeInstitutionDetails(doneeInstitution: currentDoneeInstitution)))
                : _controller.selectedDoneeInstitutions.contains(currentDoneeInstitution)
                ? _controller.selectedDoneeInstitutions.remove(currentDoneeInstitution)
                : _controller.selectedDoneeInstitutions.add(currentDoneeInstitution);
              },
            ));
            } 
          ),
        )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DoneeInstitutionForm())),
      ),
    );
  }
}