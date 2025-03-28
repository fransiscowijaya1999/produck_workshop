import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DropdownMenuDebounced extends StatefulWidget {
  const DropdownMenuDebounced({
    super.key,
    required this.onSearch,
    this.onChanged,
    this.hintText = 'Search...',
  });

  final Function(String search) onSearch;
  final Function(String text)? onChanged;
  final String hintText;

  @override
  State<DropdownMenuDebounced> createState() => _DropdownMenuDebouncedState();
}

class _DropdownMenuDebouncedState extends State<DropdownMenuDebounced> {
  Timer? _debounce;
  final Duration _debounceDuration = const Duration(milliseconds: 300);
  final productController = TextEditingController();
  final OverlayPortalController productsOverlayController = OverlayPortalController();
  late FocusNode focusNode;
  late FocusNode keyboardFocusNode;
  late Size size;
  final layerLink = LayerLink();

  _onSearchChanged(String text) async {
    if (widget.onChanged != null) widget.onChanged!(text);
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () async {
      await widget.onSearch(text);
    });
  }

  void initPosition() {
    final targetRenderBox = context.findRenderObject() as RenderBox;
    size = targetRenderBox.size;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initPosition());

    keyboardFocusNode = FocusNode();
    focusNode = FocusNode();
    focusNode.addListener(() {
      productsOverlayController.toggle();
    });

    productController.addListener(() {
      _onSearchChanged(productController.text);
    });
  }

  @override
  void dispose() {
    productController.dispose();
    _debounce?.cancel();
    keyboardFocusNode.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: productsOverlayController,
      overlayChildBuilder: (BuildContext context) {
        return Positioned(
          width: size.width + 30,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(-15, size.height + 10),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text('child'),
              ),
            ),
          ),
        );
      },
      child: CompositedTransformTarget(
        link: layerLink,
        child: DefaultTextEditingShortcuts(
          child: Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              SingleActivator(LogicalKeyboardKey.arrowDown, alt: false): Intent.doNothing,
              SingleActivator(LogicalKeyboardKey.arrowUp, alt: false): Intent.doNothing,
            },
            child: TextField(
              controller: productController,
              autofocus: true,
              focusNode: focusNode,
            ),
          ),
        ),
      )
    );
  }
}