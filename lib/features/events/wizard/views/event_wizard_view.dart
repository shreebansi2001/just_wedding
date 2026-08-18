import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_page_container.dart';
import '../controllers/event_wizard_controller.dart';
import 'widgets/step1_event_details_view.dart';
import 'widgets/step2_client_details_view.dart';
import 'widgets/step3_function_details_view.dart';
import 'widgets/step4_other_details_view.dart';

class EventWizardView extends GetView<EventWizardController> {
  const EventWizardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: controller.previousStep,
        ),
        title: Obx(() {
          final titles = {
            1: AppStrings.eventDetails,
            2: AppStrings.clientDetails,
            3: AppStrings.functionDetails,
            4: AppStrings.otherInformationDetails,
          };
          return Text(
            titles[controller.currentStep.value] ?? AppStrings.eventDetails,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          );
        }),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AppPageContainer(
          maxWidth: 600,
          child: SingleChildScrollView(
            child: Obx(() {
              switch (controller.currentStep.value) {
                case 1:
                  return const Step1EventDetailsView();
                case 2:
                  return const Step2ClientDetailsView();
                case 3:
                  return const Step3FunctionDetailsView();
                case 4:
                  return const Step4OtherDetailsView();
                default:
                  return const Step1EventDetailsView();
              }
            }),
          ),
        ),
      ),
    );
  }
}
