import 'package:checkout_payment/payment/data/models/create_customer_input_model/create_customer_input_model.dart';
import 'package:checkout_payment/payment/data/models/customer_model/customer_model.dart';
import 'package:checkout_payment/payment/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:checkout_payment/payment/data/models/init_payment_sheet_input_model/init_payment_sheet_input_model.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_model/payment_intent_model.dart';

// PaymentIntentObject Create payment intent ( amount , currency )
// Init payment sheet ( Payment intent client secret )
// PresentPaymentSheet()

abstract class StripeService {
  Future<PaymentIntentModel> createPaymentIntent({
    required PaymentIntentInputModel paymentIntentInputModel,
  });

  Future<void> initPaymentSheet({required InitPaymentSheetInputModel initPaymentSheetInputModel});

  Future<void> displayPaymentSheet();

  Future<void> createPaymentOperation(
      {required PaymentIntentInputModel paymentIntentInputModel});

  Future<CustomerModel> createCustomer({
  required CreateCustomerInputModel createCustomerInputModel
  });

  Future<EphemeralKeyModel> createEphemeralKey({required String customerId});
}
