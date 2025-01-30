import 'package:checkout_payment/core/errors/failures.dart';
import 'package:checkout_payment/core/utils/stripe_service/stripe_service.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:checkout_payment/payment/domain/repositories/stripe_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class StripeRepositoryImplementation extends StripeRepository {
  final StripeService stripeService;

  StripeRepositoryImplementation({required this.stripeService});

  @override
  Future<Either<Failure, String>> createPaymentIntent(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      stripeService.makePaymentIntent(
          paymentIntentInputModel: paymentIntentInputModel);
      return Right('');
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
