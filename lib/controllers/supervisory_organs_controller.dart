import 'package:bazaar_adm/models/supervisory_organ.dart';
import 'package:bazaar_adm/services/supervisory_organ_service.dart';
import 'package:get/state_manager.dart';

class SupervisoryOrgansController extends GetxController {

  final RxList<SupervisoryOrgan> supervisoryOrgans = <SupervisoryOrgan>[].obs;
  final SupervisoryOrganService _supervisoryOrganService = SupervisoryOrganService();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    findAllSupervisoryOrgans();
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

  void deleteSupervisoryOrgan(int supervisoryOrganId, int supervisoryOrganIndex) async {
    isLoading(true);
    await _supervisoryOrganService.deleteSupervisoryOrgan(supervisoryOrganId);
    supervisoryOrgans.removeAt(supervisoryOrganIndex);
    isLoading(false);
  }

  void updateSupervisoryOrgan(SupervisoryOrgan supervisoryOrgan, int supervisoryOrganIndex) async {
    isLoading(true);
    await _supervisoryOrganService.updateSupervisoryOrgan(supervisoryOrgan);
    supervisoryOrgans[supervisoryOrganIndex] = supervisoryOrgan;
    isLoading(false);
  }
  
}