class Customer{
  final int id;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerEmail;

  Customer({required this.id, required this.customerName, required this.customerPhone,
      required this.customerAddress, required this.customerEmail});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['customer_id'] as int,
      customerName: json['customer_name'] as String,
      customerPhone: json['customer_phone'] as String,
      customerAddress: json['customer_address'] as String,
      customerEmail: json['customer_email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': id,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'customer_address': customerAddress,
      'customer_email': customerEmail,
    };
  }

  factory Customer.forInvoice1({
    required int id,
    String? customerName,
    String? customerPhone,
    String? customerAddress,
    String? customerEmail,
  }) {
    return Customer(
      id: id,
      customerName: customerName ?? '',
      customerPhone: customerPhone ?? '',
      customerAddress: customerAddress ?? '',
      customerEmail: customerEmail ?? '',
    );
  }
  factory Customer.forInvoice2({
    int? id,
    String? customerName,
    String? customerPhone,
    String? customerAddress,
    String? customerEmail,
  }) {
    return Customer(
      id: id ?? 0,
      customerName: customerName ?? '',
      customerPhone: customerPhone ?? '',
      customerAddress: customerAddress ?? '',
      customerEmail: customerEmail ?? '',
    );
  }


}