import 'package:checkout_payment/core/api/end_points.dart';
import 'package:checkout_payment/core/utils/show_snack_bar.dart';
import 'package:checkout_payment/core/widgets/custom_button.dart';
import 'package:checkout_payment/payment/data/models/transaction_model/amount.dart';
import 'package:checkout_payment/payment/data/models/transaction_model/details.dart';
import 'package:checkout_payment/payment/data/models/transaction_model/item.dart';
import 'package:checkout_payment/payment/data/models/transaction_model/item_list.dart';
import 'package:checkout_payment/payment/data/models/transaction_model/transaction_model.dart';
import 'package:checkout_payment/payment/presentation/cubits/stripe_cubit/stripe_cubit.dart';
import 'package:checkout_payment/payment/presentation/cubits/stripe_cubit/stripe_states.dart';
import 'package:checkout_payment/payment/presentation/views/thank_you_view.dart';
import 'package:checkout_payment/payment/presentation/widgets/payment_methods_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    StripeCubit stripeCubit = context.read<StripeCubit>();
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
                  createPaypalPaymentOperation(context);
                  // stripeCubit.createPaymentOperation(
                  //     amount:100,
                  //   );
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

  void createPaypalPaymentOperation(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: EndPoints.paypalClientId,
          secretKey: EndPoints.paypalSecretKey,
          transactions: [
            {
              "amount": {
                "total": '70',
                "currency": "USD",
                "details": {
                  "subtotal": '70',
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
              "item_list": {
                "items": [
                  {
                    "name": "Apple",
                    "quantity": 4,
                    "price": '5',
                    "currency": "USD"
                  },
                  {
                    "name": "Pineapple",
                    "quantity": 5,
                    "price": '10',
                    "currency": "USD"
                  }
                ],
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            print("onSuccess: $params");
          },
          onError: (error) {
            print("onError: $error");
            Navigator.pop(context);
          },
          onCancel: () {
            print('cancelled:');
          },
        ),
      ),
    );
  }

  final TransactionModel transactionModel = const TransactionModel(
    amount: Amount(
      total: '70',
      currency: 'USD',
      details: Details(
        subtotal: '70',
        shipping: '0',
        shippingDiscount: 0,
      ),
    ),
    description: 'The payment transaction description.',
    itemList: ItemList(
      items: [
        Item(
          name: 'Apple',
          quantity: 4,
          price: '5',
          currency: 'USD',
        ),
        Item(
          name: 'Pineapple',
          quantity: 5,
          price: '10',
          currency: 'USD',
        ),
      ],
    ),
  );
}
