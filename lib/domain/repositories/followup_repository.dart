import '../models/followup_model.dart';

abstract class FollowUpRepository {
  Future<List<FollowUpModel>> getFollowUps();
  Future<FollowUpModel> createFollowUp(FollowUpModel followUp);
}
