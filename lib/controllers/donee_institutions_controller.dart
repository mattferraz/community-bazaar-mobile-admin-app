import 'package:bazaar_adm/models/donee_institution.dart';
import 'package:bazaar_adm/services/donee_institution_service.dart';
import 'package:get/state_manager.dart';

class DoneeInstitutionController extends GetxController {

  final DoneeInstitutionService _doneeInstitutionService = DoneeInstitutionService();
  RxList<DoneeInstitution> doneeInstitutions = <DoneeInstitution>[].obs;
  RxList<DoneeInstitution> selectedDoneeInstitutions = <DoneeInstitution>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    findAllDoneeInstitutions();
  }

  void findAllDoneeInstitutions() async {
    isLoading(true);
    doneeInstitutions.value = List.from(await _doneeInstitutionService.findAllDoneeInstitutions());
    isLoading(false);
  }

  Future<DoneeInstitution> createDoneeInstitution(String name, String address, String phoneNumber, String? description) async {
    isLoading(true);
    DoneeInstitution doneeInstitution = DoneeInstitution(name: name, address: address, phoneNumber: phoneNumber, description: description);
    DoneeInstitution createdDoneeInstitution = await _doneeInstitutionService.createDoneeInstitution(doneeInstitution);
    doneeInstitutions.add(createdDoneeInstitution);
    isLoading(false);
    return createdDoneeInstitution;
  }

  void updateDoneeInstitution(DoneeInstitution doneeInstitution) async {
    isLoading(true);
    _doneeInstitutionService.updateDoneeInstitution(doneeInstitution);
    int doneeInstitutionIndex = doneeInstitutions.indexWhere((element) => element.id == doneeInstitution.id);
    doneeInstitutions[doneeInstitutionIndex] = doneeInstitution;
    isLoading(false);
  }

  void deleteDoneeInstitution(int doneeInstitutionId, int doneeInstitutionIndex) {
    isLoading(true);
    _doneeInstitutionService.deleteDoneeInstitutionById(doneeInstitutionId);
    doneeInstitutions.removeAt(doneeInstitutionIndex);
    isLoading(false);
  }

  void deleteMultipleDoneeInstitutions(List<DoneeInstitution> doneeInstitutionsToBeDeleted) async {
    isLoading(true);
    for (DoneeInstitution doneeInstitution in doneeInstitutionsToBeDeleted) {
      await _doneeInstitutionService.deleteDoneeInstitutionById(doneeInstitution.id!);
    }
    doneeInstitutionsToBeDeleted.clear();
    findAllDoneeInstitutions();
    isLoading(false);
  }
  
}