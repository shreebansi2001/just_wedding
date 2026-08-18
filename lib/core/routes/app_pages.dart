import 'package:get/get.dart';
import '../../features/splash/bindings/splash_binding.dart';
import '../../features/splash/views/splash_view.dart';
import '../../features/onboarding/bindings/onboarding_binding.dart';
import '../../features/onboarding/views/onboarding_view.dart';
import '../../features/auth/sign_in/views/sign_in_view.dart';
import '../../features/auth/sign_in/bindings/sign_in_binding.dart';
import '../../features/auth/register/views/register_view.dart';
import '../../features/auth/register/bindings/register_binding.dart';
import '../../features/layout/views/layout_view.dart';
import '../../features/layout/bindings/layout_binding.dart';
import '../../features/events/create/views/create_event_view.dart';
import '../../features/events/create/bindings/create_event_binding.dart';
import '../../features/events/wizard/views/event_wizard_view.dart';
import '../../features/events/wizard/bindings/event_wizard_binding.dart';
import '../../features/events/ready/views/event_ready_view.dart';
import '../../features/events/ready/bindings/event_ready_binding.dart';
import '../../features/rsvp/views/create_rsvp_view.dart';
import '../../features/rsvp/bindings/create_rsvp_binding.dart';
import '../../features/rsvp/views/rsvp_ready_view.dart';
import '../../features/rsvp/bindings/rsvp_ready_binding.dart';
import '../../features/quotation/views/quotation_view.dart';
import '../../features/quotation/bindings/quotation_binding.dart';
import '../../features/followup/views/follow_up_view.dart';
import '../../features/followup/bindings/follow_up_binding.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.layout,
      page: () => const LayoutView(),
      binding: LayoutBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.createEvent,
      page: () => const CreateEventView(),
      binding: CreateEventBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.eventWizard,
      page: () => const EventWizardView(),
      binding: EventWizardBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.eventReady,
      page: () => const EventReadyView(),
      binding: EventReadyBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.createRsvp,
      page: () => const CreateRsvpView(),
      binding: CreateRsvpBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.rsvpReady,
      page: () => const RsvpReadyView(),
      binding: RsvpReadyBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.quotation,
      page: () => const QuotationView(),
      binding: QuotationBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.followUp,
      page: () => const FollowUpView(),
      binding: FollowUpBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
