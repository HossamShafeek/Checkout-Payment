class Metadata {
  String? orderId;

  Metadata({this.orderId});

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        orderId: json['order_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
      };
}
