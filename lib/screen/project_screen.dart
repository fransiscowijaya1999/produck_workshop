import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:produck_workshop/component/order_list.dart';
import 'package:produck_workshop/component/payment_dialog.dart';
import 'package:produck_workshop/component/project_form_card.dart';
import 'package:produck_workshop/db.dart';
import 'package:produck_workshop/schema/order.dart';
import 'package:produck_workshop/schema/payment.dart';
import 'package:produck_workshop/schema/project.dart';
import 'package:produck_workshop/util/project.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({
    super.key,
    required this.projectId,
    this.onDeleted
  });

  final int projectId;
  final VoidCallback? onDeleted;

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final db = DatabaseService.db;

  late Future<Project?> projectFuture;
  late StreamSubscription<Project?> projectStream;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    projectFuture = db.projects.get(widget.projectId);
    createWatcher(widget.projectId);
  }

  @override
  void dispose() {
    projectStream.cancel();
    super.dispose();
  }

  void createWatcher(int id) {
    projectFuture = db.projects.get(widget.projectId);

    final projectChanged = db.projects.watchObject(id);
    projectStream = projectChanged.listen((project) {
      if (project != null) {
        setState(() {
          projectFuture = db.projects.get(project.id);
        });
      }
    });
  }

  Future<void> saveProject(String label, String vehicle, String date) async {
    setState(() {
      isSaving = true;
    });
    final db = DatabaseService.db;
    await db.writeTxn(() async {
      final project = (await db.projects.get(widget.projectId))!;

      project.label = label;
      project.vehicle = vehicle;
      project.date = DateFormat('yyyy-MM-dd').parse(date);

      await db.projects.put(project);
    });
    setState(() {
      isSaving = false;
    });
  }

  Future<void> createPayment(DateTime date, double amount) async {
    final db = DatabaseService.db;
    await db.writeTxn(() async {
      final project = (await db.projects.get(widget.projectId))!;
      final payment = Payment();
      final remainingPayment = getOrdersTotalPrice(project.orders) - getProjectPaid(project.payments);
      final paid = amount > remainingPayment ? remainingPayment : amount;

      if (amount >= remainingPayment) {
        project.isUploaded = true;
      }
      payment.date = date;
      payment.amount = paid;
      
      project.payments = [...project.payments, payment];

      await db.projects.put(project);
    });
  }

  Future<void> _paymentDialogBuilder(BuildContext context) async {
    final project = (await db.projects.get(widget.projectId))!;

    if (context.mounted) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return PaymentDialog(
            remainingPayment: getOrdersTotalPrice(project.orders) - getProjectPaid(project.payments),
            onSubmit: (date, amount) async => await createPayment(date, amount),
          );
        }
      );
    }
  }


  Future<void> deleteProject() async {
    final db = DatabaseService.db;
    await db.writeTxn(() async {
      final success = await db.projects.delete(widget.projectId);
      if (success && widget.onDeleted != null) {
        widget.onDeleted!();
      }
    });
  }

  Future<void> submitOrder(List<Order> newOrders) async {
    final db = DatabaseService.db;

    await db.writeTxn(() async {
      final project = (await db.projects.get(widget.projectId))!;

      project.orders = newOrders;

      await db.projects.put(project);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Project?>(
      future: db.projects.get(widget.projectId),
      builder: (BuildContext context, AsyncSnapshot<Project?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              if (snapshot.data != null) {
                final project = snapshot.data!;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        ProjectFormCard(
                          label: project.label,
                          vehicle: project.vehicle,
                          date: DateFormat('yyyy-MM-dd').format(project.date),
                          totalPrice: getOrdersTotalPrice(project.orders),
                          paid: getProjectPaid(project.payments),
                          paymentCount: project.payments.length,
                          payments: project.payments,
                          onSave: saveProject,
                          onDelete: deleteProject,
                          onPayment: () => _paymentDialogBuilder(context),
                          isSaving: isSaving,
                          isUploaded: project.isUploaded,
                        ),
                        SizedBox(
                          height: 10
                        ),
                        OrderList(
                          orders: project.orders,
                          onSubmit: submitOrder,
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('No data exist, could it be already deleted?'));
              }
            }
        }
      },
    );
    
  }
}