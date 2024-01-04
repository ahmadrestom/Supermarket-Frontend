class Supplier{
  int supplierId;
  late String supplierName;
  late String supplierPhone;

  Supplier({required this.supplierId, required this.supplierName, required this.supplierPhone});

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      supplierId: json['supplier_id'] as int,
      supplierName: json['supplier_name'] as String,
      supplierPhone: json['supplier_phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'supplier_id': supplierId,
      'supplier_name': supplierName,
      'supplier_phone': supplierPhone,
    };
  }
}