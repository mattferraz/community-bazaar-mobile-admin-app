import 'package:bazaar_adm/controllers/business_hours_controller.dart';
import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:bazaar_adm/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../constants/size_config.dart';
import '../../constants/style_constants.dart';
import '../../models/business_hour.dart';
import '../../models/donee_institution.dart';
import '../../widgets/button.dart';
import '../../widgets/text_form_field.dart';

class BusinessHoursForm extends StatefulWidget {
  final DoneeInstitution doneeInstitution;
  final BusinessHour? businessHour;
  final Map<int, String> weekdays;

  const BusinessHoursForm({
    required this.doneeInstitution,
    this.businessHour,
    required this.weekdays,
    Key? key
  }) : super(key: key);

  @override
  State<BusinessHoursForm> createState() => _BusinessHoursFormState();
}

class _BusinessHoursFormState extends State<BusinessHoursForm> {
  int? weekday;
  TimeOfDay initialTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay finalTime = const TimeOfDay(hour: 22, minute: 0);
  TextEditingController initialController = TextEditingController();
  TextEditingController finalController = TextEditingController();
  final BusinessHoursController _controller = Get.find<BusinessHoursController>();

  @override
  void initState() {
    super.initState();
    if (widget.businessHour != null) {
      initialController.text = DateTimeFormatter.timeToJson(widget.businessHour!.openTime);
      finalController.text = DateTimeFormatter.timeToJson(widget.businessHour!.closeTime);
      initialTime = widget.businessHour!.openTime;
      finalTime = widget.businessHour!.closeTime;
      weekday = widget.businessHour!.weekday;
    } else {
      initialController.text = DateTimeFormatter.timeToJson(initialTime);
      finalController.text = DateTimeFormatter.timeToJson(finalTime);
    }
  }

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
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  widget.businessHour == null ? const Text(
                    "Cadastrar Horário de Funcionamento",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                  : const Text(
                    "Editar Horário de Funcionamento",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),
                  DropdownButtonFormField<dynamic>(
                    items: List<DropdownMenuItem>.from(widget.weekdays.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))),
                    value: weekday,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: Colors.grey.shade400)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1.5, color: StyleConstants.primaryColor)
                      ),
                      label: const Text("Dia da Semana"),
                      fillColor: Colors.white
                    ),
                    onChanged: (value) {
                      if (value is int) {
                        setState(() {
                          weekday = value;
                        });
                      }
                    }
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    fieldLabel: "Horário Inicial", 
                    isReadOnly: true,
                    controller: initialController,
                    onTap: () async {
                      TimeOfDay? iTime = await showTimePicker(
                        context: context, 
                        initialTime: initialTime
                      );
                      if (iTime != null) {
                        setState(() {
                          initialTime = iTime;
                          initialController.text = initialTime.format(context);
                        });
                      } else {
                        return;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    fieldLabel: "Horário Final", 
                    isReadOnly: true,
                    controller: finalController,
                    onTap: () async {
                      TimeOfDay? fTime = await showTimePicker(
                        context: context, 
                        initialTime: finalTime
                      );
                      if (fTime != null) {
                        setState(() {
                          finalTime = fTime;
                          finalController.text = finalTime.format(context);
                        });
                      } else {
                        return;
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Continuar", 
                    onPressed: widget.businessHour == null ? () {
                      _controller.createBusinessHour(weekday!, initialTime, finalTime, widget.doneeInstitution);
                      Navigator.pop(context);
                    }
                    : () {
                      widget.businessHour!.weekday = weekday!;
                      widget.businessHour!.openTime = initialTime;
                      widget.businessHour!.closeTime = finalTime;
                      widget.businessHour!.doneeInstitution = widget.doneeInstitution;
                      _controller.updateBusinessHour(widget.businessHour!);
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