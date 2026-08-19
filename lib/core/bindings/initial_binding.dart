import 'package:get/get.dart';
import '../../core/network/dio_client.dart';
import '../../domain/repositories/event_repository.dart';
import '../../data/repositories/event_repository_impl.dart';
import '../../domain/repositories/followup_repository.dart';
import '../../data/repositories/mock_followup_repository.dart';
import '../../domain/repositories/quotation_repository.dart';
import '../../data/repositories/quotation_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/repositories/location_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final dioClient = DioClient();
    Get.put<DioClient>(dioClient, permanent: true);
    Get.put<AuthRepository>(AuthRepositoryImpl(dioClient), permanent: true);
    Get.put<LocationRepository>(LocationRepositoryImpl(dioClient), permanent: true);
    Get.put<EventRepository>(EventRepositoryImpl(dioClient), permanent: true);
    Get.put<FollowUpRepository>(MockFollowUpRepository(), permanent: true);
    Get.put<QuotationRepository>(QuotationRepositoryImpl(dioClient), permanent: true);
  }
}
