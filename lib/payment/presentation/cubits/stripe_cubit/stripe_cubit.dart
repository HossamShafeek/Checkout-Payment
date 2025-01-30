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

  StripeCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> createPaymentIntent({required paymentIntentInputModel}) async {
    emit(CreatePaymentIntentLoadnigState());
    Either<Failure, String> result = await createStripePaymentIntentUseCase
        .call(params: paymentIntentInputModel);
    result.fold((failure) {
      emit(CreatePaymentIntentFailureState(failure: failure.toString()));
    }, (message) {
      emit(CreatePaymentIntentSuccessState(message: message));
    });
  }
}
