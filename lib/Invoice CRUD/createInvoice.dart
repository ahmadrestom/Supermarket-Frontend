import 'package:flutter/material.dart';
import 'package:frontend/Models/invoice.dart';
import 'package:frontend/Models/invoice_item.dart';
import 'package:frontend/Services/invoice_service.dart';

import '../Models/customer.dart';
import '../Models/item.dart';
import '../Services/customer_service.dart';
import '../Services/item_service.dart';

class CreateInvoice extends StatefulWidget{
  const CreateInvoice({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateInvoice createState() => _CreateInvoice();

}

class _CreateInvoice extends State<CreateInvoice>{

  final TextEditingController _id = TextEditingController();
  final TextEditingController _searchQuery = TextEditingController();
  final ItemService itemService = ItemService();
  List<InvoiceItem> invoiceItems = [];
  List<Item> _searchResult = [];

  Future<void> performSearch(String query) async{
    try{
      List<Item> items = await itemService.getItemsByName(query);
      setState(() {
        _searchResult = items;
      });
    }catch(e){
      //print('Error fetching items: $e');
      setState(() {
        _searchResult = [];
      });
    }
  }
  
  void addItem(Item item){
    setState(() {
      invoiceItems.add(InvoiceItem(invoiceItemId: 0, quantity: 1, subtotal: item.itemPrice, item: item));
      item.itemQuantity -=1;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                controller: _id,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: "Enter customer id",
                  prefixIcon: const Icon(Icons.numbers),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              const SizedBox(height: 20), // Spacer
              TextField(
                controller: _searchQuery,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Search for items',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onChanged: (value) {
                  performSearch(value);
                },
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(
                            _searchResult[index].itemName,
                            style: TextStyle(
                              color: _searchResult[index].itemQuantity <=5 ? Colors.red : Colors.black
                            ),

                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              if(_searchResult[index].itemQuantity > 0) {
                                addItem(_searchResult[index]);
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Item is not available at the moment'),
                                  ),
                                );

                              }

                            },
                            child: const Text('Add'),
                          ),

                        );
                      }
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  onPressed: () {
                    Set<InvoiceItem> uniqueItems = invoiceItems.toSet();
                    List<InvoiceItem> uniqueItemList = uniqueItems.toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectedItemsPage(uniqueItemList: uniqueItemList, customerId: _id.text),
                      ),
                    );
                  },
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(child: Text("Done")),
                    ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

//------------------------------------------------

class SelectedItemsPage extends StatefulWidget {
  final List<InvoiceItem> uniqueItemList;
  final String customerId;
  const SelectedItemsPage({
    Key? key,
    required this.uniqueItemList,
    required this.customerId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SelectedItem createState() => _SelectedItem();
}

class _SelectedItem extends State<SelectedItemsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Items'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.uniqueItemList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.uniqueItemList[index].item.itemName),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            widget.uniqueItemList.removeAt(index);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if(widget.uniqueItemList[index].quantity > 1){
                              widget.uniqueItemList[index].quantity -= 1;
                              widget.uniqueItemList[index].item.itemQuantity+=1;
                            }
                          });
                        },
                      ),
                      Text('${widget.uniqueItemList[index].quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                              if(widget.uniqueItemList[index].item.itemQuantity != 0){
                                widget.uniqueItemList[index].quantity += 1;
                                widget.uniqueItemList[index].item.itemQuantity-=1;
                              }
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15,0,15,50),
            child: ElevatedButton(
              onPressed: () {
                String customerId = widget.customerId;
                int customerIid = int.tryParse(customerId) ?? 0;

                if (customerIid != 0) {
                  CustomerService().doesCustomerExist(customerIid).then((doesExist) {
                    if (doesExist) {
                      Invoice invoice = Invoice(
                        invoiceId: 0,
                        invoiceDate: null,
                        totalAmount: 0,
                        customer: Customer.forInvoice(id: customerIid),
                        invoiceItems: widget.uniqueItemList,
                      );
                      if(widget.uniqueItemList.isNotEmpty) {
                        InvoiceService().createInvoice(invoice);
                        Navigator.of(context).popUntil(ModalRoute.withName('/invoice'));
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Success'),
                              content: const Text('Invoice successfully created!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }else{
                        Navigator.of(context).popUntil(ModalRoute.withName('/invoice'));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No items selected'),
                          ),
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Customer does not exist.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please fill in all fields.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const SizedBox(
                width: double.infinity,
                child: Center(child: Text("Create Invoice")),
              ),
            ),

          )
        ],
      ),
    );
  }

}