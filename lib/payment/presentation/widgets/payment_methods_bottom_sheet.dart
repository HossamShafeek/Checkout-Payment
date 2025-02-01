import 'package:checkout_payment/core/utils/show_snack_bar.dart';
import 'package:checkout_payment/core/widgets/custom_button.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:checkout_payment/payment/presentation/cubits/stripe_cubit/stripe_cubit.dart';
import 'package:checkout_payment/payment/presentation/cubits/stripe_cubit/stripe_states.dart';
import 'package:checkout_payment/payment/presentation/views/thank_you_view.dart';
import 'package:checkout_payment/payment/presentation/widgets/payment_methods_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(),
          SizedBox(
            height: 32,
          ),
          BlocConsumer<StripeCubit, StripeStates>(
            listener: (context, state) {
              if (state is CreateStripePaymentIntentSuccessState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ThankYouView();
                    },
                  ),
                );
              } else if (state is CreateStripePaymentIntentFailureState) {
                showErrorSnackBar(context: context, message: state.failure);
              }
            },
            builder: (context, state) {
              return CustomButton(
                onTap: () {
                  StripeCubit.get(context).createPaymentOperation(
                    paymentIntentInputModel: PaymentIntentInputModel(
                      amount: '100',
                      currency: 'USD',
                    ),
                  );
                },
                isLoading: state is CreateStripePaymentIntentLoadnigState,
                text: 'Continue',
              );
            },
          ),
        ],
      ),
    );
  }
}
