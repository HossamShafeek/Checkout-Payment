import 'package:checkout_payment/core/errors/failures.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:dartz/dartz.dart';

abstract class StripeRepository {
  Future<Either<Failure, String>> createPaymentOperation({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
