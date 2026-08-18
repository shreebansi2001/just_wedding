import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';

class CreateRsvpController extends GetxController {
  final currentStep = 1.obs;

  // Step 1: RSVP Details
  final selectedParty = 'Groom'.obs; // Groom or Bride
  final venueName = ''.obs;
  final weddingDate = ''.obs;
  final streetAddress = '123 Main St, Suite 100'.obs;
  final city = 'New York'.obs;
  final country = 'United States'.obs;
  final isAdvancedLocationOpen = false.obs;

  // Step 2: Guest Details
  final primaryGuestStatus = 'Confirmed'.obs; // Confirmed, Pending, Declined
  final newGuestStatus = 'Pending'.obs;
  final isNewGuestFormVisible = true.obs;

  final additionalGuests = <RsvpGuest>[
    RsvpGuest(
      name: 'Chidi Anagonye',
      email: 'chidi@ethics.edu',
      phone: '+44 7700 900077',
      status: 'Confirmed',
      initial: 'C',
    ),
    RsvpGuest(
      name: 'Tahani Al-Jamil',
      email: 'tahani@al-jamil.com',
      phone: '+44 7700 900078',
      status: 'Pending',
      initial: 'T',
    ),
  ].obs;

  // Step 3: Accommodation Details
  final checkInDate = '11/15/2026'.obs;
  final checkOutDate = '11/18/2026'.obs;
  final roomType = 'Executive Suite (King)'.obs;
  final hotelName = 'Grand Plaza Continental'.obs;
  final hotelAddress = '1250 Premium Ave, Downtown District, Metropolis, NY 10001'.obs;
  final totalRooms = 3.obs;
  final allocatedRooms = <String>['305', '402', '404'].obs;
  final staySpecialRequests = ''.obs;

  // Step 4: Transportation Details
  final pickupDate = '10/15/2026'.obs;
  final dropOffDate = '10/18/2026'.obs;
  final modeOfTransport = 'Premium Bus'.obs;
  final pickupLocation = 'JFK International Airport'.obs;
  final dropOffLocation = 'Grand Hyatt New York'.obs;
  final vehiclesCount = 2.obs;
  final serviceProvider = 'Empire Charters'.obs;
  final paymentStatus = 'Pending'.obs;
  final transportSpecialRequests = ''.obs;

  void setParty(String party) {
    selectedParty.value = party;
  }

  void toggleAdvancedLocation() {
    isAdvancedLocationOpen.value = !isAdvancedLocationOpen.value;
  }

  void setPrimaryGuestStatus(String status) {
    primaryGuestStatus.value = status;
  }

  void setNewGuestStatus(String status) {
    newGuestStatus.value = status;
  }

  void toggleNewGuestForm() {
    isNewGuestFormVisible.value = !isNewGuestFormVisible.value;
  }

  void saveGuest() {
    additionalGuests.add(
      RsvpGuest(
        name: 'New Companion',
        email: 'guest@example.com',
        phone: '+1 555-0000',
        status: newGuestStatus.value,
        initial: 'N',
      ),
    );
    isNewGuestFormVisible.value = false;
  }

  void removeGuest(int index) {
    if (index >= 0 && index < additionalGuests.length) {
      additionalGuests.removeAt(index);
    }
  }

  void removeRoom(int index) {
    if (index >= 0 && index < allocatedRooms.length) {
      allocatedRooms.removeAt(index);
      totalRooms.value = allocatedRooms.length;
    }
  }

  void addRoom(String roomNum) {
    allocatedRooms.add(roomNum);
    totalRooms.value = allocatedRooms.length;
  }

  void incrementVehicles() {
    vehiclesCount.value++;
  }

  void decrementVehicles() {
    if (vehiclesCount.value > 1) {
      vehiclesCount.value--;
    }
  }

  void nextStep() {
    if (currentStep.value < 4) {
      currentStep.value++;
    } else {
      finishRsvp();
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  void finishRsvp() {
    Get.offNamed(AppRoutes.rsvpReady);
  }

  void saveDraft() {
    Get.back();
  }
}

class RsvpGuest {
  String name;
  String email;
  String phone;
  String status;
  String initial;

  RsvpGuest({
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.initial,
  });
}
