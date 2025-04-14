import 'dart:async';

import 'package:flutter/material.dart';
import 'package:produck_workshop/model/pos.dart';
import 'package:produck_workshop/prefs.dart';
import 'package:produck_workshop/services/pos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PosSelectionScreen extends StatefulWidget {
  const PosSelectionScreen({
    super.key,
    required this.posId
  });

  final int? posId;

  @override
  State<PosSelectionScreen> createState() => _PosSelectionScreenState();
}

class _PosSelectionScreenState extends State<PosSelectionScreen> {
  final Duration _debounceDuration = const Duration(milliseconds: 300);
  Timer? _debounce;
  final searchController = TextEditingController();
  late int? selectedId;

  late Future<List<Pos>> posFuture;

  _onSearchChanged(String text) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () async {
      setState(() {
        posFuture = PosService.filterPos(searchController.text, 10);
      });
    });
  }

  Future<void> _onSelected(Pos pos) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setInt(prefsApi['POS_ID']!, pos.id);

    setState(() {
      selectedId = pos.id;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedId = widget.posId;
    posFuture = PosService.filterPos(searchController.text, 10);
    searchController.addListener(() {
      _onSearchChanged(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pos Selection'),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: searchController,
              ),
              SizedBox(height: 10,),
              PosListFuture(
                future: posFuture,
                selectedId: selectedId,
                onSelected: _onSelected,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PosListFuture extends StatelessWidget {
  const PosListFuture({
    super.key,
    this.selectedId,
    required this.future,
    required this.onSelected
  });

  final int? selectedId;
  final Future<List<Pos>> future;
  final ValueSetter<Pos> onSelected;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pos>>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<Pos>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: const CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data != null) {
                final posList = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: posList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      trailing: selectedId == posList[index].id ? Icon(Icons.check_outlined) : null,
                      title: Text(posList[index].name),
                      onTap: () => onSelected(posList[index]),
                    );
                  }
                );
              } else {
                return const Text('Error: data is not found');
              }
            }
        }
      }
    );
  }
}