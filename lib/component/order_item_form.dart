import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:produck_workshop/component/dropdownmenu_debounced.dart';
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
  final descriptionController = TextEditingController();
  final costController = TextEditingController();
  final qtyController = TextEditingController();
  final priceController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late Future<List<Product>> futureProducts;

  bool isBroker = false;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService.filterProductLimited("", 5);
  }

  @override
  void dispose() {
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

  void _onProductSelected(Product product) {
    setState(() {
      costController.text = product.cost.toString();
      priceController.text = product.price.toString();
      qtyController.text = 1.toString();
    });
  }

  void _onSearch(String text) {
    setState(() {
      futureProducts = ProductService.filterProductLimited(searchText, 5);
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
                    List<DropdownMenuEntry<Product?>> products = [];
                    
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                          products = [DropdownMenuEntry(value: null, label: 'Loading')];
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          products = [DropdownMenuEntry(value: null, label: 'Error')];
                        } else {
                          for (final p in snapshot.data!) {
                            products.add(DropdownMenuEntry(value: p, label: p.name));
                          }
                        }
                    }

                    return Expanded(
                      flex: 2,
                      child: DropdownMenuDebounced(
                        onSearch: _onSearch,
                        hintText: 'Product',
                        onChanged: (text) => searchText = text,
                      ),
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
                    keyboardType: TextInputType.number,
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
                    keyboardType: TextInputType.number,
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
                    keyboardType: TextInputType.number,
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