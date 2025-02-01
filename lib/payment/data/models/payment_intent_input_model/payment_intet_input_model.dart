class PaymentIntentInputModel {
  final String amount;
  final String currency;

  const PaymentIntentInputModel({
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() => {
        'amount': (num.parse(amount) * 100).toString(),
        'currency': currency,
      };
}
