import 'package:checkout_payment/core/errors/failures.dart';
import 'package:checkout_payment/core/use_case/use_case.dart';
import 'package:checkout_payment/payment/data/models/create_customer_input_model/create_customer_input_model.dart';
import 'package:checkout_payment/payment/data/models/customer_model/customer_model.dart';
import 'package:checkout_payment/payment/domain/repositories/stripe_repository.dart';
import 'package:dartz/dartz.dart';

class CreateCustomerUseCase
    extends UseCase<CustomerModel, CreateCustomerInputModel> {
  final StripeRepository stripeRepository;

  CreateCustomerUseCase({required this.stripeRepository});

  @override
  Future<Either<Failure, CustomerModel>> call(
      {required CreateCustomerInputModel params}) async {
    return await stripeRepository.createCustomer(
        createCustomerInputModel: params);
  }
}
