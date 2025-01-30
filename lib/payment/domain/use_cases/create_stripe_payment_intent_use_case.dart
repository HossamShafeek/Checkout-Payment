import 'package:checkout_payment/core/errors/failures.dart';
import 'package:checkout_payment/core/use_case/use_case.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:checkout_payment/payment/domain/repositories/stripe_repository.dart';
import 'package:dartz/dartz.dart';

class CreateStripePaymentIntentUseCase
    extends UseCase<String, PaymentIntentInputModel> {
  CreateStripePaymentIntentUseCase({
    required this.stripeRepository,
  });

  final StripeRepository stripeRepository;

  @override
  Future<Either<Failure, String>> call(
      {required PaymentIntentInputModel params}) async {
    return await stripeRepository.createPaymentIntent(
        paymentIntentInputModel: params);
  }
}
