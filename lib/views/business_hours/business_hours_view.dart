import 'package:bazaar_adm/controllers/business_hours_controller.dart';
import 'package:bazaar_adm/models/business_hour.dart';
import 'package:bazaar_adm/utils/date_time_formatter.dart';
import 'package:bazaar_adm/views/business_hours/business_hour_detail.dart';
import 'package:bazaar_adm/views/business_hours/business_hours_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../constants/size_config.dart';
import '../../constants/style_constants.dart';
import '../../models/donee_institution.dart';
import '../../widgets/empty_list_view_illustrator.dart';
import '../../widgets/floating_action_button.dart';

class BusinessHourView extends StatelessWidget {
  final BusinessHoursController _controller = Get.put(BusinessHoursController());
  final DoneeInstitution doneeInstitution;

  static const Map<int, String> weekdays = {
    1: "Domingo",
    2: "Segunda",
    3: "Terça",
    4: "Quarta",
    5: "Quinta",
    6: "Sexta",
    7: "Sábado"
  };

  BusinessHourView({
    required this.doneeInstitution,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.findAllBusinessHourFromDoneeInstitution(doneeInstitution.id!);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.primaryColor,
        title: const Text("Horários de Funcionamento"),
        actions: [
          Obx(() {
            if(_controller.selectedBusinessHours.isNotEmpty) {
              return IconButton(
                onPressed: () => _controller.deleteMultipleBusinessHours(doneeInstitution.id!, _controller.selectedBusinessHours),
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
          child: Obx(() => _controller.businessHours.isEmpty 
          ? const Padding(
            padding: EdgeInsets.all(SizeConfig.kdefaultPadding),
            child: EmptyListViewIllustrator(
              message: "Você ainda não cadastrou nenhum horário de funcionamento. Clique no botão abaixo para cadastrar um novo.", 
              imagePath: "assets/images/Waiting-bro.png"
            ),
          ) 
          : _controller.isLoading.value 
          ? const Center(child: CircularProgressIndicator(color: StyleConstants.primaryColor)) 
          : ListView.separated(
            padding: const EdgeInsets.all(SizeConfig.kdefaultPadding),
            separatorBuilder: (context, index) => const Divider(color: StyleConstants.primaryColor), 
            itemCount: _controller.businessHours.length,
            itemBuilder: (context, index) {
              BusinessHour currentBusinessHour = _controller.businessHours[index];
              return Obx(() => ListTile(
              leading: Text(currentBusinessHour.id.toString()),
              title: Text(weekdays.values.elementAt(currentBusinessHour.weekday - 1)),
              subtitle: Text("${DateTimeFormatter.timeToJson(currentBusinessHour.openTime)} - ${DateTimeFormatter.timeToJson(currentBusinessHour.closeTime)}"),
              selectedTileColor: const Color(0xFF90CAF9),
              selectedColor: const Color(0xFF90CAF9),
              selected: _controller.selectedBusinessHours.contains(currentBusinessHour),
              onLongPress: () {
                _controller.selectedBusinessHours.contains(currentBusinessHour)
                  ? _controller.selectedBusinessHours.remove(currentBusinessHour)
                  : _controller.selectedBusinessHours.add(currentBusinessHour);
              },
              onTap: () {
                _controller.selectedBusinessHours.isEmpty 
                ? Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessHourDetail(businessHour: currentBusinessHour, doneeInstitution: doneeInstitution, weekdays: weekdays)))
                : _controller.selectedBusinessHours.contains(currentBusinessHour)
                ? _controller.selectedBusinessHours.remove(currentBusinessHour)
                : _controller.selectedBusinessHours.add(currentBusinessHour);
              },
            ));
            } 
          ),
        )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessHoursForm(doneeInstitution: doneeInstitution, weekdays: weekdays))),
      ),
    );
  }
}