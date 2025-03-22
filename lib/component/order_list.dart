import 'package:flutter/material.dart';
import 'package:produck_workshop/component/order_item.dart';
import 'package:produck_workshop/component/order_item_form.dart';
import 'package:produck_workshop/schema/order.dart';

enum CreateFormState { order, group, off }

class OrderList extends StatefulWidget {
  const OrderList({
    super.key,
    this.orders = const [],
  });

  final List<Order> orders;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final List<Order> _selectedOrder = [];
  int? currentEditIndex;
  CreateFormState createFormState = CreateFormState.off;

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
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text('Selected Items: ${_selectedOrder.length}'),
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
                flex: 3,
                child: Text('Product')
              ),
              Expanded(
                flex: 6,
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
            OrderItemForm(
              formState: createFormState,
              submitAction: FormSubmitAction.create,
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