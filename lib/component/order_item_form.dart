import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:produck_workshop/component/order_list.dart';
import 'package:produck_workshop/schema/order.dart';

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

  bool isBroker = false;

  @override
  void dispose() {
    productController.dispose();
    descriptionController.dispose();
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
                DropdownMenu<String>(
                  width: 250,
                  controller: productController,
                  label: Text('Product'),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 'test', label: 'test'),
                    DropdownMenuEntry(value: 'hey', label: 'hoho')
                  ],
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