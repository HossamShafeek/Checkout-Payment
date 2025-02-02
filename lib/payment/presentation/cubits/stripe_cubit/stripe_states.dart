import 'package:checkout_payment/payment/data/models/customer_model/customer_model.dart';
import 'package:checkout_payment/payment/data/models/ephemeral_key_model/ephemeral_key_model.dart';

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

class CreateStripeCustomerLoadnigState extends StripeStates {}

class CreateStripeCustomerSuccessState extends StripeStates {
  final CustomerModel customerModel;

  const CreateStripeCustomerSuccessState({required this.customerModel});
}

class CreateStripeCustomerFailureState extends StripeStates {
  final String failure;

  const CreateStripeCustomerFailureState({required this.failure});
}

class CreateStripeEphemeralKeyLoadnigState extends StripeStates {}

class CreateStripeEphemeralKeySuccessState extends StripeStates {
  final EphemeralKeyModel ephemeralKeyModel;

  const CreateStripeEphemeralKeySuccessState({required this.ephemeralKeyModel});
}

class CreateStripeEphemeralKeyFailureState extends StripeStates {
  final String failure;

  const CreateStripeEphemeralKeyFailureState({required this.failure});
}
