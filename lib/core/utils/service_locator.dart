import 'package:checkout_payment/core/api/api_services_implementation.dart';
import 'package:checkout_payment/core/utils/stripe_service/stripe_service_implementation.dart';
import 'package:checkout_payment/payment/data/repositories/stripe_repository_implementation.dart';
import 'package:checkout_payment/payment/domain/use_cases/create_customer_use_case.dart';
import 'package:checkout_payment/payment/domain/use_cases/create_ephemeral_key_use_case.dart';
import 'package:checkout_payment/payment/domain/use_cases/create_stripe_payment_intent_use_case.dart';
import 'package:checkout_payment/payment/presentation/cubits/stripe_cubit/stripe_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  //! Api Service
  getIt.registerSingleton<ApiServicesImplementation>(
      ApiServicesImplementation());
  //! Stripe Service
  getIt.registerSingleton<StripeServiceImplementation>(
      StripeServiceImplementation(
          apiServices: getIt<ApiServicesImplementation>()));
  //! Stripe Repo
  getIt.registerSingleton<StripeRepositoryImplementation>(
      StripeRepositoryImplementation(
          stripeService: getIt<StripeServiceImplementation>()));
  //! Stripe Use Cases
  getIt.registerSingleton<CreateCustomerUseCase>(
    CreateCustomerUseCase(
        stripeRepository: getIt<StripeRepositoryImplementation>()),
  );
  getIt.registerSingleton<CreateEphemeralKeyUseCase>(
    CreateEphemeralKeyUseCase(
        stripeRepository: getIt<StripeRepositoryImplementation>()),
  );
  getIt.registerSingleton<CreateStripePaymentIntentUseCase>(
    CreateStripePaymentIntentUseCase(
        stripeRepository: getIt<StripeRepositoryImplementation>()),
  );
  //! Stripe Cubit
  getIt.registerFactory<StripeCubit>(
    () => StripeCubit(
      createCustomerUseCase: getIt<CreateCustomerUseCase>(),
      createEphemeralKeyUseCase: getIt<CreateEphemeralKeyUseCase>(),
      createStripePaymentIntentUseCase:
          getIt<CreateStripePaymentIntentUseCase>(),
    ),
  );
}
