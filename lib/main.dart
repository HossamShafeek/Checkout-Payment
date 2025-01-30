import 'package:checkout_payment/payment/presentation/views/my_cart_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CheckoutApp());

}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}

// PaymentIntentObject Create payment intent ( amount , currency )
// Init payment sheet ( Payment intent client secret )
// PresentPaymentSheet()
