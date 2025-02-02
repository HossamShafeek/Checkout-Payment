class CreateCustomerInputModel {
  final String name;
  final String email;
  final String phone;

  const CreateCustomerInputModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
      };
}
