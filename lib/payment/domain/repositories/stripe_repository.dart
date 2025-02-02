import 'package:checkout_payment/core/errors/failures.dart';
import 'package:checkout_payment/payment/data/models/create_customer_input_model/create_customer_input_model.dart';
import 'package:checkout_payment/payment/data/models/customer_model/customer_model.dart';
import 'package:checkout_payment/payment/data/models/ephemeral_key_model/ephemeral_key_model.dart';

import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:dartz/dartz.dart';

abstract class StripeRepository {
  Future<Either<Failure, String>> createPaymentOperation({
    required PaymentIntentInputModel paymentIntentInputModel,
  });

Future<Either<Failure, CustomerModel>> createCustomer({
    required CreateCustomerInputModel createCustomerInputModel,
  });

  Future<Either<Failure, EphemeralKeyModel>> createEphemeralKey({
    required String customerId,
  });

}
