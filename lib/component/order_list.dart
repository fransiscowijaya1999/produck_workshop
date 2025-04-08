import 'package:flutter/material.dart';
import 'package:produck_workshop/component/order_item.dart';
import 'package:produck_workshop/component/order_item_form2.dart';
import 'package:produck_workshop/schema/order.dart';

enum CreateFormState { order, group, off }

class OrderList extends StatefulWidget {
  const OrderList({
    super.key,
    this.orders = const [],
    this.onSubmit
  });

  final List<Order> orders;
  final Future Function(List<Order>)? onSubmit;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<Order> _selectedOrder = [];
  int? currentEditIndex;
  CreateFormState createFormState = CreateFormState.off;

  Future<void> _onSubmit(Order order) async {
    if (widget.onSubmit != null) {
      await widget.onSubmit!([...widget.orders, order]);
    }
  }

  Future<void> _onSubmitGroup(Order order) async {
    if (widget.onSubmit != null) {
      await widget.onSubmit!(widget.orders);
    }
  }

  Future<void> _onOrdersDelete() async {
    if (widget.onSubmit != null) {
      final List<Order> remains = List.from(widget.orders);

      remains.removeWhere((o) => _selectedOrder.contains(o));

      await widget.onSubmit!(remains);

      setState(() {
        _selectedOrder = [];
      });
    }
  }

  Future<void> _selectedDialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Items: ${_selectedOrder.length}'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: ListView.builder(
              itemCount: _selectedOrder.length,
              itemBuilder: (_, index) {
                final order = _selectedOrder[index];
            
                return ListTile(
                  key: Key('$index'),
                  dense: true,
                  title: Text('${index + 1}. ${order.description}'),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _onOrdersDelete();
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.delete)
            )
          ],
        );
      }
    );
  }

  void onChecked(Order order) {
    if (_selectedOrder.contains(order)) {
      setState(() {
        _selectedOrder.remove(order);
      });
    } else {
      setState(() {
        _selectedOrder.add(order);
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                TextButton(
                  onPressed: _selectedOrder.isNotEmpty ? () => _selectedDialogBuilder(context) : null,
                  child: Text('Selected Items: ${_selectedOrder.length}'),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: Checkbox(
                  value: _selectedOrder.length == widget.orders.length,
                  onChanged: null
                ),
              ),
              Expanded(
                flex: 5,
                child: Text('Description')
              ),
              Expanded(
                flex: 1,
                child: Text('Cost'),
              ),
              Expanded(
                flex: 1,
                child: Text('Qty'),
              ),
              Expanded(
                flex: 1,
                child: Text('Price'),
              ),
              Expanded(
                flex: 2,
                child: Text('Total'),
              )
            ],
          ),
          Divider(
            height: 2,
            thickness: 2,
          ),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.orders.length,
            itemBuilder: (_, index) {
              final order= widget.orders[index];
          
              return OrderItem(
                key: Key('$index'),
                order: order,
                isChecked: _selectedOrder.contains(order),
                onChecked: onChecked,
                onSubmit: _onSubmitGroup,
              );
            },
            onReorder: (int oldIndex, int newIndex) {
          
            }
          ),
          Divider(
            height: 2,
            thickness: 2,
          ),
          createFormState == CreateFormState.off ?
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        createFormState = CreateFormState.order;
                      });
                    },
                    child: Text('Add product'),
                  ),
                  SizedBox(width: 5,),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        createFormState = CreateFormState.group;
                      });
                    },
                    child: Text('Add section'),
                  )
                ]
              ),
            )
            :
            OrderItemForm2(
              formState: createFormState,
              submitAction: FormSubmitAction.create,
              onSubmit: _onSubmit,
              onCancel: () {
                setState(() {
                  createFormState = CreateFormState.off;
                });
              },
            )
        ],
      ),
    );
  }
}