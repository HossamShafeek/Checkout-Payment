abstract class StripeStates {
  const StripeStates();
}

class StripeInitailState extends StripeStates {}

class CreateStripePaymentIntentLoadnigState extends StripeStates {}

class CreateStripePaymentIntentSuccessState extends StripeStates {
  final String message;

  const CreateStripePaymentIntentSuccessState({required this.message});
}

class CreateStripePaymentIntentFailureState extends StripeStates {
  final String failure;

  const CreateStripePaymentIntentFailureState({required this.failure});
}
