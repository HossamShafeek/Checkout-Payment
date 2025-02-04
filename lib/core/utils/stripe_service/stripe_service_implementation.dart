import 'package:checkout_payment/core/api/api_services.dart';
import 'package:checkout_payment/core/api/end_points.dart';
import 'package:checkout_payment/core/utils/stripe_service/stripe_service.dart';
import 'package:checkout_payment/payment/data/models/create_customer_input_model/create_customer_input_model.dart';
import 'package:checkout_payment/payment/data/models/customer_model/customer_model.dart';
import 'package:checkout_payment/payment/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:checkout_payment/payment/data/models/init_payment_sheet_input_model/init_payment_sheet_input_model.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeServiceImplementation extends StripeService {
  final ApiServices apiServices;

  StripeServiceImplementation({required this.apiServices});

  @override
  Future<CustomerModel> createCustomer(
      {required CreateCustomerInputModel createCustomerInputModel}) async {
    apiServices.setHeaders(
      headers: {
        'Authorization': 'Bearer ${EndPoints.stripeSecretKey}',
        'Content-Type': Headers.formUrlEncodedContentType,
      },
    );
    Response response = await apiServices.post(
        endPoint: EndPoints.createCustomer,
        data: createCustomerInputModel.toJson());
    CustomerModel customerModel = CustomerModel.fromJson(response.data);
    return customerModel;
  }

  @override
  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    apiServices.setHeaders(
      headers: {
        'Authorization': 'Bearer ${EndPoints.stripeSecretKey}',
        'Content-Type': Headers.formUrlEncodedContentType,
        'Stripe-Version': '2025-01-27.acacia',
      },
    );
    Response response = await apiServices.post(
      endPoint: EndPoints.createEphemeralKey,
      data: {'customer': customerId},
    );
    EphemeralKeyModel ephemeralKeyModel =
        EphemeralKeyModel.fromJson(response.data);
    return ephemeralKeyModel;
  }

  @override
  Future<PaymentIntentModel> createPaymentIntent(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    apiServices.setHeaders(
      headers: {
        'Authorization': 'Bearer ${EndPoints.stripeSecretKey}',
        'Content-Type': Headers.formUrlEncodedContentType,
      },
    );
    Response response = await apiServices.post(
        endPoint: EndPoints.createPaymentIntent,
        data: paymentIntentInputModel.toJson());
    PaymentIntentModel paymentIntentModel =
        PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  @override
  Future<void> initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInputModel}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret:
            initPaymentSheetInputModel.paymentIntentClientSecret,
        customerEphemeralKeySecret:
            initPaymentSheetInputModel.ephemeralKeySecret,
        customerId: initPaymentSheetInputModel.customerId,
        merchantDisplayName: 'Hossam Shafeek',
      ),
    );
  }

  @override
  Future<void> displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  @override
  Future<void> createPaymentOperation({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    PaymentIntentModel paymentIntentModel = await createPaymentIntent(
      paymentIntentInputModel: paymentIntentInputModel,
    );
    await initPaymentSheet(
      initPaymentSheetInputModel: InitPaymentSheetInputModel(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!,
        customerId: paymentIntentInputModel.customerId!,
        ephemeralKeySecret: paymentIntentInputModel.ephemeralKey!,
      ),
    );
    await displayPaymentSheet();
  }
}
