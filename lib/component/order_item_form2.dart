import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:produck_workshop/component/order_list.dart';
import 'package:produck_workshop/component/product_dropdown.dart';
import 'package:produck_workshop/model/product.dart';
import 'package:produck_workshop/schema/order.dart';
import 'package:produck_workshop/services/product.dart';

enum FormSubmitAction { create, update }

class OrderItemForm2 extends StatefulWidget {
  const OrderItemForm2({
    super.key,
    this.order,
    this.formState = CreateFormState.order,
    this.submitAction = FormSubmitAction.create,
    this.onSubmit,
    this.onCancel
  });

  final Order? order;
  final CreateFormState formState;
  final FormSubmitAction submitAction;
  final Future Function(Order)? onSubmit;
  final VoidCallback? onCancel;

  @override
  State<OrderItemForm2> createState() => _OrderItemForm2State();
}

class _OrderItemForm2State extends State<OrderItemForm2> {
  late TextEditingController productController;
  late TextEditingController descriptionController;
  late TextEditingController costController;
  late TextEditingController qtyController;
  late TextEditingController priceController;
  final FocusNode _keyboardFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  late FocusNode _qtyFocusNode;
  late Future<List<Product>> productsFuture;

  late double price;
  late double cost;
  late double margin;

  bool isBroker = false;
  Product? selectedProduct;

  @override
  void initState() {
    super.initState();

    if (widget.order != null) {
      final initProduct = Product(
        id: widget.order!.productId!,
        name: widget.order!.description,
        price: widget.order!.price,
        cost: widget.order!.cost
      );
      selectedProduct = initProduct;
    }

    productController = TextEditingController()..text = widget.order?.description ?? '';
    descriptionController = TextEditingController()..text = widget.order?.description ?? '';
    costController = TextEditingController()..text = removeDecimalZeroFormat(widget.order?.cost ?? 0);
    qtyController = TextEditingController()..text = widget.order?.qty.toString() ?? '';
    priceController = TextEditingController()..text = removeDecimalZeroFormat(widget.order?.price ?? 0);

    productsFuture = ProductService.filterProductLimited('', 5);
    _qtyFocusNode = FocusNode();
    costController.addListener(() => setState(() {
      cost = double.tryParse(costController.text) ?? 0;
      margin = ((price - cost) / price) * 100;
    }));
    priceController.addListener(() => setState(() {
      price = double.tryParse(priceController.text) ?? 0;
      margin = ((price - cost) / price) * 100;
    }));
    cost = double.tryParse(costController.text) ?? 0;
    price = double.tryParse(priceController.text) ?? 0;
    margin = ((price - cost) / price) * 100;
  }

  @override
  void dispose() {
    _qtyFocusNode.dispose();
    descriptionController.dispose();
    costController.dispose();
    qtyController.dispose();
    priceController.dispose();
    _keyboardFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  Future<void> _onSearch(text) async {
    setState(() {
      productsFuture = ProductService.filterProductLimited(text, 5);
    });
  }

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  Future<void> submitOrder() async {
    if (widget.onSubmit != null && (widget.formState == CreateFormState.group || (selectedProduct != null && widget.formState == CreateFormState.order))) {
      final newOrder = Order()
        ..isGroup = widget.formState == CreateFormState.group ? true : false
        ..description = descriptionController.text
        ..productId = selectedProduct?.id
        ..qty = int.tryParse(qtyController.text) ?? 0
        ..price = double.tryParse(priceController.text) ?? 0
        ..cost = double.tryParse(costController.text) ?? 0
        ..isBroker = isBroker
        ..orders = widget.formState == CreateFormState.group ? [] : null
      ;

      await widget.onSubmit!(newOrder);

      setState(() {
        descriptionController.clear();
        selectedProduct = null;
        qtyController.clear();
        priceController.clear();
        costController.clear();
        isBroker = false;
      });

      productFocusNode.requestFocus();
    }
  }

  void formKeyDownHandler(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        if (widget.onCancel != null) { widget.onCancel!(); }
      }
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        submitOrder();
      }
    }
  }

  void _onProductSelected(Product product) {
    selectedProduct = product;
    descriptionController.text = product.name;
    costController.text = removeDecimalZeroFormat(product.cost).toString();
    priceController.text = removeDecimalZeroFormat(product.price).toString();
    qtyController.text = 1.toString();
    _qtyFocusNode.requestFocus();
  }

  Text marginHelperText() {
    Color textColor = margin >= 10 ? Colors.green : (margin <= 0 ? Colors.red : Colors.orange);

    return Text('${removeDecimalZeroFormat(margin)} %', style: TextStyle(
      color: textColor
    ));
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
            focusNode: _keyboardFocusNode,
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
            focusNode: _keyboardFocusNode,
            onKeyEvent: formKeyDownHandler,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ProductDropdown(
                    initProduct: selectedProduct,
                    future: productsFuture,
                    onSearch: _onSearch,
                    onSelected: _onProductSelected,
                  )
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: TextField(
                    focusNode: _descriptionFocusNode,
                    controller: descriptionController,
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
                    controller: costController,
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
                    controller: qtyController,
                    focusNode: _qtyFocusNode,
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
                    controller: priceController,
                    focusNode: _priceFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Price',
                      helper: marginHelperText(),
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