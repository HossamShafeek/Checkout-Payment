import 'package:checkout_payment/core/api/api_services.dart';
import 'package:checkout_payment/core/api/end_points.dart';
import 'package:checkout_payment/core/utils/stripe_service/stripe_service.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_input_model/payment_intet_input_model.dart';
import 'package:checkout_payment/payment/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// PaymentIntentObject Create payment intent ( amount , currency )
// Init payment sheet ( Payment intent client secret )
// PresentPaymentSheet()

class StripeServiceImplementation extends StripeService {
  final ApiServices apiServices;

  StripeServiceImplementation({required this.apiServices});

  @override
  Future<PaymentIntentModel> createPaymentIntent(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    apiServices.setHeaders(
      headers: {
        'Authorization': 'Bearer ${EndPoints.secretKey}',
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
      {required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
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
      paymentIntentClientSecret: paymentIntentModel.clientSecret!,
    );
    await displayPaymentSheet();
  }
}
