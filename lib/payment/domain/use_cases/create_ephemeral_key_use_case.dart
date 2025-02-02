import 'package:checkout_payment/core/errors/failures.dart';
import 'package:checkout_payment/core/use_case/use_case.dart';
import 'package:checkout_payment/payment/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:checkout_payment/payment/domain/repositories/stripe_repository.dart';
import 'package:dartz/dartz.dart';

class CreateEphemeralKeyUseCase extends UseCase<EphemeralKeyModel, String> {
  final StripeRepository stripeRepository;

  CreateEphemeralKeyUseCase({required this.stripeRepository});

  @override
  Future<Either<Failure, EphemeralKeyModel>> call(
      {required String params}) async {
    return await stripeRepository.createEphemeralKey(customerId: params);
  }
}
