import 'package:checkout_payment/core/errors/failures.dart';
import 'package:checkout_payment/payment/domain/use_cases/create_stripe_payment_intent_use_case.dart';
import 'package:checkout_payment/payment/presentation/cubits/stripe_cubit/stripe_states.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StripeCubit extends Cubit<StripeStates> {
  StripeCubit({required this.createStripePaymentIntentUseCase})
      : super(StripeInitailState());

  final CreateStripePaymentIntentUseCase createStripePaymentIntentUseCase;

  static StripeCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> createPaymentOperation(
      {required paymentIntentInputModel}) async {
    emit(CreateStripePaymentIntentLoadnigState());
    Either<Failure, String> result = await createStripePaymentIntentUseCase
        .call(params: paymentIntentInputModel);
    result.fold((failure) {
      emit(CreateStripePaymentIntentFailureState(
          failure: failure.error.toString()));
    }, (message) {
      emit(CreateStripePaymentIntentSuccessState(message: message));
    });
  }
}
