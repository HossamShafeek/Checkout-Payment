import 'dart:convert';
import 'package:checkout_payment/core/errors/failures.dart';
import 'package:checkout_payment/core/utils/cache_helper.dart';
import 'package:checkout_payment/core/utils/stripe_service/stripe_service.dart';
import 'package:checkout_payment/payment/data/models/create_customer_input_model/create_customer_input_model.dart';
import 'package:checkout_payment/payment/data/models/customer_model/customer_model.dart';
import 'package:checkout_payment/payment/data/models/ephemeral_key_model/ephemeral_key_model.dart';

import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:checkout_payment/payment/domain/repositories/stripe_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class StripeRepositoryImplementation extends StripeRepository {
  final StripeService stripeService;

  StripeRepositoryImplementation({required this.stripeService});

  @override
  Future<Either<Failure, String>> createPaymentOperation(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.createPaymentOperation(
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

  @override
  Future<Either<Failure, CustomerModel>> createCustomer(
      {required CreateCustomerInputModel createCustomerInputModel}) async {
    try {
      if (await CacheHelper.getData(key: 'customer') == null) {
        CustomerModel customerModel = await stripeService.createCustomer(
            createCustomerInputModel: createCustomerInputModel);
        CacheHelper.setData(
          key: 'customer',
          value: jsonEncode(customerModel.toJson()),
        );
        return Right(customerModel);
      } else {
        CustomerModel customerModel = CustomerModel.fromJson(
            json.decode(await CacheHelper.getData(key: 'customer') ?? ''));
        return Right(customerModel);
      }
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, EphemeralKeyModel>> createEphemeralKey(
      {required String customerId}) async {
    try {
      EphemeralKeyModel ephemeralKeyModel =
          await stripeService.createEphemeralKey(
        customerId: customerId,
      );
      return Right(ephemeralKeyModel);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
