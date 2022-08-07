import 'package:bazaar_adm/constants/size_config.dart';
import 'package:bazaar_adm/controllers/supervisory_organs_controller.dart';
import 'package:bazaar_adm/views/supervisory_organ_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/style_constants.dart';
import '../widgets/floating_action_button.dart';

class SupervisoryOrgansView extends StatelessWidget {
  SupervisoryOrgansView({Key? key}) : super(key: key);
  final SupervisoryOrgansController _controller = Get.put(SupervisoryOrgansController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Supervisors"),
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
          child: Obx(() => ListView.separated(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
            itemCount: _controller.supervisoryOrgans.length,
            itemBuilder: (context, index) => Obx(() => ListTile(
              leading: Text(_controller.supervisoryOrgans[index].id.toString()),
              title: Text(_controller.supervisoryOrgans[index].name),
              subtitle: Text(_controller.supervisoryOrgans[index].description),
              selectedTileColor: const Color(0xFF90CAF9),
              selectedColor: const Color(0xFF90CAF9),
              selected: _controller.selectedSupervisoryOrgans.contains(_controller.supervisoryOrgans[index]),
              onLongPress: () {
                _controller.selectedSupervisoryOrgans.contains(_controller.supervisoryOrgans[index])
                  ? _controller.selectedSupervisoryOrgans.remove(_controller.supervisoryOrgans[index])
                  : _controller.selectedSupervisoryOrgans.add(_controller.supervisoryOrgans[index]);
              },
            )) 
          ),
        )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          final List<String> fields = await Navigator.push(context, MaterialPageRoute(builder: (context) => SupervisoryOrganForm()));
          _controller.createSupervisoryOrgan(fields[0], fields[1]);
        },
      ),
    );
  }
}