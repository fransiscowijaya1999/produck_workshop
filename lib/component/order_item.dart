import 'package:flutter/material.dart';
import 'package:produck_workshop/component/order_item_form2.dart';
import 'package:produck_workshop/component/order_list.dart';
import 'package:produck_workshop/schema/order.dart';
import 'package:produck_workshop/util/project.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    super.key,
    required this.order,
    this.isChecked = false,
    this.onChecked,
    this.onSubmit,
    this.onUpdate
  });

  final Order order;
  final bool isChecked;
  final ValueSetter<Order>? onChecked;
  final Future Function(Order)? onSubmit;
  final Future Function(Order)? onUpdate;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isEditing = false;

  void _onEdit() {
    setState(() {
      isEditing = true;
    });
  }

  void _onCancelEdit() {
    setState(() {
      isEditing = false;
    });
  }

  Future<void> _onUpdate(Order newOrder) async {
    if (widget.onUpdate != null) {
      widget.order.productId = newOrder.productId;
      widget.order.description = newOrder.description;
      widget.order.cost = newOrder.cost;
      widget.order.qty = newOrder.qty;
      widget.order.price = newOrder.price;

      widget.onUpdate!(newOrder);
    }

    setState(() {
      isEditing = false;
    });
  }

  Future<void> _onSubmitGroup(List<Order> newOrders) async {
    if (widget.onSubmit != null && widget.order.isGroup) {
      widget.order.orders = newOrders;
      widget.onSubmit!(widget.order);
    }
  }

  Future<void> _onQtyIncrement() async {
    if (widget.onSubmit != null) {
      widget.order.qty += 1;
      widget.onSubmit!(widget.order);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return OrderItemForm2(
        order: widget.order,
        formState: widget.order.isGroup ? CreateFormState.group : CreateFormState.order,
        submitAction: FormSubmitAction.update,
        onCancel: _onCancelEdit,
        onSubmit: _onUpdate,
      );
    }
    if (widget.order.isGroup) {
      return ExpansionTile(
        controlAffinity: ListTileControlAffinity.leading,
        minTileHeight: 0,
        dense: true,
        childrenPadding: EdgeInsets.all(10),
        backgroundColor: Colors.black12,
        collapsedBackgroundColor: Colors.black12,
        title: Row(
          children: [
            SizedBox(
              width: 50,
              child: Checkbox(
                value: widget.isChecked,
                onChanged: widget.onChecked != null ? (checkStatus) => widget.onChecked!(widget.order) : null
              ),
            ),
            SizedBox(
              width: 50,
              child: TextButton(
                onPressed: _onEdit,
                child: Icon(Icons.edit),
              )
            ),
            SizedBox(width: 10,),
            Expanded(
              flex: 12,
              child: Text(widget.order.description)
            ),
            Expanded(
              flex: 2,
              child: Text('Rp${removeDecimalZeroFormat(getOrdersTotalPrice(widget.order.orders))}'),
            )
          ],
        ),
        children: [
          OrderList(
            orders: widget.order.orders ?? [],
            onSubmit: _onSubmitGroup,
          )
        ],
      );
    }

    return ListTile(
      tileColor: widget.order.isBroker ? Colors.amber : null,
      contentPadding: EdgeInsets.all(0),
      minVerticalPadding: 0,
      horizontalTitleGap: 5,
      dense: true,
      title: Row(
        children: [
          SizedBox(
            width: 50,
            child: Checkbox(
              value: widget.isChecked,
              onChanged: widget.onChecked != null ? (checkStatus) => widget.onChecked!(widget.order) : null
            ),
          ),
          SizedBox(
            width: 50,
            child: TextButton(
              onPressed: _onEdit,
              child: Icon(Icons.edit),
            )
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 5,
            child: Text(widget.order.description)
          ),
          Expanded(
            flex: 1,
            child: Text('Rp${removeDecimalZeroFormat(widget.order.cost)}',
              style: TextStyle(
                color: Colors.black54
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 20,
              child: TextButton(
                onPressed: _onQtyIncrement,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${widget.order.qty}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('Rp${removeDecimalZeroFormat(widget.order.price)}'),
          ),
          Expanded(
            flex: 2,
            child: Text('Rp${removeDecimalZeroFormat(widget.order.qty * widget.order.price)}',
              style: TextStyle(),
            ),
          )
        ],
      ),
    );
  }
}