import 'package:checkout_payment/core/api/end_points.dart';
import 'package:checkout_payment/core/utils/bloc_observer.dart';
import 'package:checkout_payment/core/utils/cache_helper.dart';
import 'package:checkout_payment/core/utils/service_locator.dart';
import 'package:checkout_payment/payment/presentation/views/my_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Stripe.publishableKey = EndPoints.stripePuplishableKey;
  setupServiceLocator();
  await CacheHelper.init();
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
