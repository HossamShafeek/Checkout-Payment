class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String? customerId;
  final String? ephemeralKey;

  const PaymentIntentInputModel({
    required this.amount,
    required this.currency,
    this.customerId,
    this.ephemeralKey,
  });

// remove ephemeral key - because it is not required to create payment intent
// pass ephemeral key to init payment sheet to get user cardes
  Map<String, dynamic> toJson() => {
        'amount': (num.parse(amount) * 100).toString(),
        'currency': currency,
        'customer': customerId,
      };
}
