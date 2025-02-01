import 'package:checkout_payment/core/api/api_services_implementation.dart';
import 'package:checkout_payment/core/utils/stripe_service/stripe_service_implementation.dart';
import 'package:checkout_payment/core/widgets/custom_button.dart';
import 'package:checkout_payment/payment/data/repositories/stripe_repository_implementation.dart';
import 'package:checkout_payment/payment/domain/use_cases/create_stripe_payment_intent_use_case.dart';
import 'package:checkout_payment/payment/presentation/cubits/stripe_cubit/stripe_cubit.dart';
import 'package:checkout_payment/payment/presentation/widgets/cart_info_item.dart';
import 'package:checkout_payment/payment/presentation/widgets/payment_methods_bottom_sheet.dart';
import 'package:checkout_payment/payment/presentation/widgets/total_price_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Expanded(child: Image.asset('assets/images/basket_image.png')),
          const SizedBox(
            height: 25,
          ),
          const OrderInfoItem(
            title: 'Order Subtotal',
            value: r'42.97$',
          ),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(
            title: 'Discount',
            value: r'0$',
          ),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(
            title: 'Shipping',
            value: r'8$',
          ),
          const Divider(
            thickness: 2,
            height: 34,
            color: Color(0xffC7C7C7),
          ),
          const TotalPrice(title: 'Total', value: r'$50.97'),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
            text: 'Complete Payment',
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //   return const PaymentDetailsView();
              // }));

              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                builder: (context) {
                  return BlocProvider(
                      create: (context) => StripeCubit(
                            createStripePaymentIntentUseCase:
                                CreateStripePaymentIntentUseCase(
                              stripeRepository: StripeRepositoryImplementation(
                                stripeService: StripeServiceImplementation(
                                  apiServices: ApiServicesImplementation(),
                                ),
                              ),
                            ),
                          ),
                      child: const PaymentMethodsBottomSheet());
                },
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
