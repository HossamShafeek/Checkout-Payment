import 'package:checkout_payment/core/errors/failures.dart';
import 'package:checkout_payment/payment/data/models/create_customer_input_model/create_customer_input_model.dart';
import 'package:checkout_payment/payment/data/models/customer_model/customer_model.dart';
import 'package:checkout_payment/payment/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:checkout_payment/payment/domain/use_cases/create_customer_use_case.dart';
import 'package:checkout_payment/payment/domain/use_cases/create_ephemeral_key_use_case.dart';
import 'package:checkout_payment/payment/domain/use_cases/create_stripe_payment_intent_use_case.dart';
import 'package:checkout_payment/payment/presentation/cubits/stripe_cubit/stripe_states.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StripeCubit extends Cubit<StripeStates> {
  StripeCubit({
    required this.createStripePaymentIntentUseCase,
    required this.createCustomerUseCase,
    required this.createEphemeralKeyUseCase,
  }) : super(StripeInitailState());

  final CreateStripePaymentIntentUseCase createStripePaymentIntentUseCase;
  final CreateEphemeralKeyUseCase createEphemeralKeyUseCase;
  final CreateCustomerUseCase createCustomerUseCase;
  CustomerModel? customerModel;
  EphemeralKeyModel? ephemeralKeyModel;

  final CreateCustomerInputModel createCustomerInputModel =
      CreateCustomerInputModel(
    name: 'Hossam Shafeek',
    email: 'hossamShafik55@gmail.com',
    phone: '01010040257',
  );

  static StripeCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> createPaymentOperation({
    required num amount,
  }) async {
    emit(CreateStripePaymentIntentLoadnigState());
    // first create customer
    await createCustomer(createCustomerInputModel: createCustomerInputModel);
    //second create ephemeral key
    // to get user data ( saved cards )
    await createEphemeralKey(customerId: customerModel!.id!);
    PaymentIntentInputModel paymentIntentInputModel = PaymentIntentInputModel(
      amount: "$amount",
      currency: 'USD',
      customerId: customerModel?.id!,
      ephemeralKey: ephemeralKeyModel!.secret!,
    );
    //third create payment
    Either<Failure, String> result = await createStripePaymentIntentUseCase
        .call(params: paymentIntentInputModel);
    result.fold((failure) {
      emit(CreateStripePaymentIntentFailureState(
          failure: failure.error.toString()));
    }, (message) {
      emit(CreateStripePaymentIntentSuccessState(message: message));
    });
  }

  Future<void> createCustomer(
      {required CreateCustomerInputModel createCustomerInputModel}) async {
    emit(CreateStripeCustomerLoadnigState());
    Either<Failure, CustomerModel> result = await createCustomerUseCase.call(
      params: createCustomerInputModel,
    );

    result.fold((failure) {
      emit(CreateStripeCustomerFailureState(failure: failure.error.toString()));
    }, (customerModel) {
      this.customerModel = customerModel;
      emit(CreateStripeCustomerSuccessState(customerModel: customerModel));
    });
  }

  Future<void> createEphemeralKey({required String customerId}) async {
    emit(CreateStripeEphemeralKeyLoadnigState());
    Either<Failure, EphemeralKeyModel> result =
        await createEphemeralKeyUseCase.call(
      params: customerId,
    );
    result.fold((failure) {
      emit(CreateStripeEphemeralKeyFailureState(
          failure: failure.error.toString()));
    }, (ephemeralKeyModel) {
      this.ephemeralKeyModel = ephemeralKeyModel;
      emit(CreateStripeEphemeralKeySuccessState(
          ephemeralKeyModel: ephemeralKeyModel));
    });
  }
}
