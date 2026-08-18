import 'package:get/get.dart';
import '../../../domain/models/followup_model.dart';
import '../../../domain/repositories/followup_repository.dart';

class FollowUpController extends GetxController {
  final FollowUpRepository _repository = Get.find<FollowUpRepository>();

  final selectedFilter = 0.obs;
  final followUps = <FollowUpModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFollowUps();
  }

  Future<void> fetchFollowUps() async {
    try {
      isLoading.value = true;
      followUps.value = await _repository.getFollowUps();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load follow-ups');
    } finally {
      isLoading.value = false;
    }
  }

  void selectFilter(int index) {
    selectedFilter.value = index;
  }
}
