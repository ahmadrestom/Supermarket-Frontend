import 'customer.dart';
import 'invoice_item.dart';

class Invoice {
  final int invoiceId;
  DateTime? invoiceDate;
  final double totalAmount;
  final Customer customer;
  final List<InvoiceItem> invoiceItems;

  Invoice(
      {required this.invoiceId,  this.invoiceDate, required this.totalAmount,
        required this.customer, required this.invoiceItems});


  Map<String, dynamic> toJson() {
    return {
      'invoices_id': invoiceId,
      'invoices_date': invoiceDate?.toIso8601String(),
      'total_amount': totalAmount,
      'customer': customer.toJson(),
      'invoice_items': invoiceItems.map((item) => item.toJson()).toList(),
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> json) {
    List<InvoiceItem> invoiceItems = <InvoiceItem>[];
    if (json['invoice_items'] != null) {
      invoiceItems = (json['invoice_items'] as List<dynamic>)
          .map((itemJson) => InvoiceItem.fromJson(itemJson))
          .toList();
    }

    dynamic customerData = json['customer'];
    Customer customer;
    if (customerData is Map<String, dynamic>) {
      customer = Customer.fromJson(customerData);
    } else if (customerData is int){
      customer = Customer.forInvoice1(id: customerData);
    }else{
      customer = Customer.forInvoice2();
    }

    return Invoice(
      invoiceId: json['invoices_id'] as int,
      invoiceDate: DateTime.tryParse(json['invoices_date'] as String),
      totalAmount: (json['total_amount'] ?? 0.0) as double,
      customer: customer,
      invoiceItems: invoiceItems,
    );
  }

}