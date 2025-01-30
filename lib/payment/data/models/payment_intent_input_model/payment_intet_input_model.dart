class PaymentIntetInputModel {
  final String amount;
  final String currency;

 const  PaymentIntetInputModel({
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'currency': currency,
      };
}
