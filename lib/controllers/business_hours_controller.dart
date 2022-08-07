import 'package:bazaar_adm/models/business_hour.dart';
import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:bazaar_adm/services/business_hour_service.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class BusinessHoursController extends GetxController {

  final BusinessHourService _businessHourService = BusinessHourService();
  RxList<BusinessHour> businessHours = <BusinessHour>[].obs;
  RxBool isLoading = false.obs;

  void findAllBusinessHourFromDoneeInstitution(int doneeInstitutionId) async {
    isLoading(true);
    businessHours.value = List<BusinessHour>.from(await _businessHourService.findAllBusinessHourFromDoneeInstitution(doneeInstitutionId));
    isLoading(false);
  }

  void createBusinessHour(int weekday, TimeOfDay openTime, TimeOfDay closeTime, DoneeInstitution doneeInstitution) async {
    isLoading(true);
    BusinessHour businessHour = BusinessHour(weekday: weekday, openTime: openTime, closeTime: closeTime, doneeInstitution: doneeInstitution);
    if(doneeInstitution.id != null) {
      BusinessHour createdBusinessHour = await _businessHourService.createBusinessHour(doneeInstitution.id!, businessHour);
      businessHours.add(createdBusinessHour);
    }
    isLoading(false);
  }

  void updateBusinessHour(BusinessHour businessHour, int businessHourIndex) async {
    isLoading(true);
    await _businessHourService.updateBusinessHour(businessHour);
    businessHours[businessHourIndex] = businessHour;
    isLoading(false);
  }

  void deleteBusinessHour(int businessHourId, int doneeInstitutionId, int businessHourIndex) async {
    isLoading(true);
    await _businessHourService.deleteBusinessHourById(doneeInstitutionId, businessHourId);
    businessHours.removeAt(businessHourIndex);
    isLoading(false);
  }
  
}