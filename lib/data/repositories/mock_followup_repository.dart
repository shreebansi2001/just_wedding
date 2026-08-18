import '../../domain/models/followup_model.dart';
import '../../domain/repositories/followup_repository.dart';
import 'dart:math';

class MockFollowUpRepository implements FollowUpRepository {
  final List<FollowUpModel> _data = [
    FollowUpModel(
      id: '1',
      name: 'Sarah Jenkins',
      role: 'Lead Coordinator',
      time: 'CREATED Today, 10:30 AM',
      description: 'Client requested additional lighting options for the main stage area.',
      followUpDate: 'Oct 12, 2024',
      status: 'Confirm',
    ),
  ];

  @override
  Future<List<FollowUpModel>> getFollowUps() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_data);
  }

  @override
  Future<FollowUpModel> createFollowUp(FollowUpModel followUp) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newFollowUp = FollowUpModel(
      id: Random().nextInt(1000).toString(),
      name: followUp.name,
      role: followUp.role,
      time: followUp.time,
      description: followUp.description,
      followUpDate: followUp.followUpDate,
      status: followUp.status,
    );
    _data.add(newFollowUp);
    return newFollowUp;
  }
}
