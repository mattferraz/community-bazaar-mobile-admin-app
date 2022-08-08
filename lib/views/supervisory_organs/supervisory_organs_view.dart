import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/controllers/supervisory_organs_controller.dart';
import 'package:bazaar_adm/models/supervisory_organ.dart';
import 'package:bazaar_adm/views/supervisory_organs/supervisory_organ_detail.dart';
import 'package:bazaar_adm/views/supervisory_organs/supervisory_organ_form.dart';
import 'package:bazaar_adm/widgets/empty_list_view_illustrator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/style_constants.dart';
import '../../widgets/floating_action_button.dart';

class SupervisoryOrgansView extends StatelessWidget {
  SupervisoryOrgansView({Key? key}) : super(key: key);
  final SupervisoryOrgansController _controller = Get.put(SupervisoryOrgansController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Fiscalizadores"),
        actions: [
          Obx(() {
            if(_controller.selectedSupervisoryOrgans.isNotEmpty) {
              return IconButton(
                onPressed: () => _controller.deleteMultipleSupervisoryOrgans(_controller.selectedSupervisoryOrgans),
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
          child: Obx(() => _controller.supervisoryOrgans.isEmpty 
          ? const Padding(
            padding: EdgeInsets.all(SizeConfig.kdefaultPadding),
            child: EmptyListViewIllustrator(
              message: "Você ainda não cadastrou nenhum orgão supervisor. Clique no botão abaixo para cadastrar um novo.", 
              imagePath: "assets/images/Problem solving-pana.png"
            ),
          ) 
          : _controller.isLoading.value 
          ? const Center(child: CircularProgressIndicator(color: StyleConstants.primaryColor)) 
          : ListView.separated(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
            itemCount: _controller.supervisoryOrgans.length,
            itemBuilder: (context, index) {
              SupervisoryOrgan currentSupervisoryOrgan = _controller.supervisoryOrgans[index];
              return Obx(() => ListTile(
              leading: Text(currentSupervisoryOrgan.id.toString()),
              title: Text(currentSupervisoryOrgan.name),
              subtitle: Text(currentSupervisoryOrgan.description),
              selectedTileColor: const Color(0xFF90CAF9),
              selectedColor: const Color(0xFF90CAF9),
              selected: _controller.selectedSupervisoryOrgans.contains(currentSupervisoryOrgan),
              onLongPress: () {
                _controller.selectedSupervisoryOrgans.contains(currentSupervisoryOrgan)
                  ? _controller.selectedSupervisoryOrgans.remove(currentSupervisoryOrgan)
                  : _controller.selectedSupervisoryOrgans.add(currentSupervisoryOrgan);
              },
              onTap: () {
                _controller.selectedSupervisoryOrgans.isEmpty 
                ? Navigator.push(context, MaterialPageRoute(builder: (context) => SupervisoryOrganDetail(supervisoryOrgan: currentSupervisoryOrgan)))
                : _controller.selectedSupervisoryOrgans.contains(currentSupervisoryOrgan)
                ? _controller.selectedSupervisoryOrgans.remove(currentSupervisoryOrgan)
                : _controller.selectedSupervisoryOrgans.add(currentSupervisoryOrgan);
              },
            ));
            } 
          ),
        )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          final List<String>? fields = await Navigator.push(context, MaterialPageRoute(builder: (context) => SupervisoryOrganForm()));
          if (fields != null) {
            _controller.createSupervisoryOrgan(fields[0], fields[1]);
          }
        },
      ),
    );
  }
}