abstract class StripeStates {
  const StripeStates();
}

class StripeInitailState extends StripeStates {}

class CreatePaymentIntentLoadnigState extends StripeStates {}

class CreatePaymentIntentSuccessState extends StripeStates {
  final String message;

 const CreatePaymentIntentSuccessState({required this.message});
}

class CreatePaymentIntentFailureState extends StripeStates {
  final String failure;

  const CreatePaymentIntentFailureState({required this.failure});
}
