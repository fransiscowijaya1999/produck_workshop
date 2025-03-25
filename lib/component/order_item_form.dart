import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:produck_workshop/component/order_list.dart';
import 'package:produck_workshop/model/product.dart';
import 'package:produck_workshop/schema/order.dart';
import 'package:produck_workshop/services/product.dart';

enum FormSubmitAction { create, update }

class OrderItemForm extends StatefulWidget {
  const OrderItemForm({
    super.key,
    this.order,
    this.formState = CreateFormState.order,
    this.submitAction = FormSubmitAction.create,
    this.onCancel
  });

  final Order? order;
  final CreateFormState formState;
  final FormSubmitAction submitAction;
  final VoidCallback? onCancel;

  @override
  State<OrderItemForm> createState() => _OrderItemFormState();
}

class _OrderItemFormState extends State<OrderItemForm> {
  final productController = TextEditingController();
  final descriptionController = TextEditingController();
  final costController = TextEditingController();
  final qtyController = TextEditingController();
  final priceController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late Future<List<Product>> futureProducts;

  bool isBroker = false;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService.filterProductLimited("", 5);
    productController.addListener(_onSearch);
  }

  @override
  void dispose() {
    productController.dispose();
    descriptionController.dispose();
    costController.dispose();
    qtyController.dispose();
    priceController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void formKeyDownHandler(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        if (widget.onCancel != null) { widget.onCancel!(); }
      }
    }
  }

  void _onSearch() {
    setState(() {
      futureProducts = ProductService.filterProductLimited(productController.text, 5);
    });
  }

  TextStyle shrinkStyle() {
    return TextStyle(
      fontSize: 13,
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.formState) {
      case CreateFormState.group:
        return ListTile(
          contentPadding: EdgeInsets.all(10),
          minTileHeight: 0,
          minVerticalPadding: 0,
          horizontalTitleGap: 5,
          dense: true,
          title: KeyboardListener(
            focusNode: _focusNode,
            autofocus: true,
            onKeyEvent: formKeyDownHandler,
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Section Name',
              )
            ),
          ),
        );
      case CreateFormState.order:
        return ListTile(
          contentPadding: EdgeInsets.all(10),
          minTileHeight: 0,
          minVerticalPadding: 0,
          horizontalTitleGap: 5,
          dense: true,
          title: KeyboardListener(
            focusNode: _focusNode,
            onKeyEvent: formKeyDownHandler,
            child: Row(
              children: [
                FutureBuilder<List<Product>>(
                  future: futureProducts,
                  builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
                    List<DropdownMenuEntry<String>> products = [];
                    
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        products = [DropdownMenuEntry(value: 'Loading', label: 'Loading')];
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          products = [DropdownMenuEntry(value: 'Error', label: 'Error')];
                        } else {
                          products = snapshot.data!.map((p) {
                            return DropdownMenuEntry(value: p.name, label: p.name);
                          }).toList();
                        }
                    }

                    return DropdownMenu<String>(
                      width: 250,
                      controller: productController,
                      label: Text('Product'),
                      dropdownMenuEntries: products
                    );
                  }
                ),
                
                SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: descriptionController..text = widget.order != null ? widget.order!.description : '',
                    decoration: InputDecoration(
                      hintText: 'Description',
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: costController..text = widget.order != null ? widget.order!.cost.toString() : '',
                    decoration: InputDecoration(
                      hintText: 'Cost'
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: qtyController..text = widget.order != null ? widget.order!.qty.toString() : '',
                    decoration: InputDecoration(
                      hintText: 'Qty'
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: priceController..text = widget.order != null ? widget.order!.price.toString() : '',
                    decoration: InputDecoration(
                      hintText: 'Price'
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Is broker?',
                  child: Checkbox(
                    value: isBroker,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          isBroker = value;
                        });
                      }
                    }
                  ),
                )
              ],
            ),
          ),
        );
      default:
        return ListTile();
    }
  }
}