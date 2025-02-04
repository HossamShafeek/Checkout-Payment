class InitPaymentSheetInputModel {
  final String paymentIntentClientSecret;
  final String customerId;
  final String ephemeralKeySecret;
  InitPaymentSheetInputModel({
    required this.paymentIntentClientSecret,
    required this.customerId,
    required this.ephemeralKeySecret,
  });
}
