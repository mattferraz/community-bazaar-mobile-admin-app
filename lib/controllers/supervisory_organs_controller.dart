import 'package:bazaar_adm/models/supervisory_organ.dart';
import 'package:bazaar_adm/services/supervisory_organ_service.dart';
import 'package:get/state_manager.dart';

class SupervisoryOrgansController extends GetxController {

  final RxList<SupervisoryOrgan> supervisoryOrgans = <SupervisoryOrgan>[].obs;
  final SupervisoryOrganService _supervisoryOrganService = SupervisoryOrganService();
  final RxList<SupervisoryOrgan> selectedSupervisoryOrgans = <SupervisoryOrgan>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    findAllSupervisoryOrgans();
    super.onInit();
  }

  void createSupervisoryOrgan(String name, String description) async {
    isLoading(true);
    SupervisoryOrgan supervisoryOrgan = SupervisoryOrgan(name: name, description: description);
    SupervisoryOrgan supervisoryOrganCreated = await _supervisoryOrganService.createSupervisoryOrgan(supervisoryOrgan);
    supervisoryOrgans.add(supervisoryOrganCreated);
    isLoading(false);
  }

  void findAllSupervisoryOrgans() async {
    isLoading(true);
    supervisoryOrgans.value = List.from(await _supervisoryOrganService.findAllSupervisoryOrgans());
    isLoading(false);
  }

  void updateSupervisoryOrgan(SupervisoryOrgan supervisoryOrgan) async {
    isLoading(true);
    await _supervisoryOrganService.updateSupervisoryOrgan(supervisoryOrgan);
    int supervisoryOrganIndex = supervisoryOrgans.indexWhere((element) => element.id == supervisoryOrgan.id);
    supervisoryOrgans[supervisoryOrganIndex] = supervisoryOrgan;
    isLoading(false);
  }

  void deleteSupervisoryOrgan(int supervisoryOrganId, int supervisoryOrganIndex) async {
    isLoading(true);
    await _supervisoryOrganService.deleteSupervisoryOrgan(supervisoryOrganId);
    supervisoryOrgans.removeAt(supervisoryOrganIndex);
    isLoading(false);
  }

  void deleteMultipleSupervisoryOrgans(List<SupervisoryOrgan> supervisoryOrgansToDelete) async {
    isLoading(true);
    for (SupervisoryOrgan supervisoryOrgan in supervisoryOrgansToDelete) {
      await _supervisoryOrganService.deleteSupervisoryOrgan(supervisoryOrgan.id!);
    }
    selectedSupervisoryOrgans.clear();
    findAllSupervisoryOrgans();
    isLoading(false);
  }
  
}