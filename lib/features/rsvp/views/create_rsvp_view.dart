import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_page_container.dart';
import '../controllers/create_rsvp_controller.dart';
import 'widgets/step1_rsvp_details_view.dart';
import 'widgets/step2_guest_details_view.dart';
import 'widgets/step3_accommodation_view.dart';
import 'widgets/step4_transportation_view.dart';

class CreateRsvpView extends GetView<CreateRsvpController> {
  const CreateRsvpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: controller.previousStep,
        ),
        title: Obx(() {
          final title = controller.currentStep.value == 4
              ? AppStrings.transportation
              : AppStrings.createRsvp;
          return Text(
            title,
            style: GoogleFonts.publicSans(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          );
        }),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: AppPageContainer(
          maxWidth: 600,
          child: SingleChildScrollView(
            child: Obx(() {
              switch (controller.currentStep.value) {
                case 1:
                  return const Step1RsvpDetailsView();
                case 2:
                  return const Step2GuestDetailsView();
                case 3:
                  return const Step3AccommodationView();
                case 4:
                  return const Step4TransportationView();
                default:
                  return const Step1RsvpDetailsView();
              }
            }),
          ),
        ),
      ),
    );
  }
}

