class Customer{
  int id;
  String customerName;
  String customerPhone;
  String customerAddress;
  String customerEmail;

  Customer({required this.id, required this.customerName, required this.customerPhone,
      required this.customerAddress, required this.customerEmail});


  factory Customer.fromJson(Map<String, dynamic> json) { //getting cstomer
    return Customer(
      id: json['customer_id'] as int,
      customerName: json['customer_name'] as String,
      customerPhone: json['customer_phone'] as String,
      customerAddress: json['customer_address'] as String,
      customerEmail: json['customer_email'] as String,
    );
  }

  Map<String, dynamic> toJson() { //sending customer
    return {
      'customer_id': id,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'customer_address': customerAddress,
      'customer_email': customerEmail,
    };
  }

  factory Customer.forInvoice({ //for creating invoice
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


}