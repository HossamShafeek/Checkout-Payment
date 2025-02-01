import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_model/payment_intent_model.dart';

// PaymentIntentObject Create payment intent ( amount , currency )
// Init payment sheet ( Payment intent client secret )
// PresentPaymentSheet()

abstract class StripeService {
  Future<PaymentIntentModel> createPaymentIntent({
    required PaymentIntentInputModel paymentIntentInputModel,
  });

  Future<void> initPaymentSheet({required String paymentIntentClientSecret});

  Future<void> displayPaymentSheet();

  Future<void> createPaymentOperation(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
