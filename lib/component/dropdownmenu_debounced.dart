import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:produck_workshop/component/dropdownmenu_overlay.dart';

class DropdownMenuDebounced extends StatefulWidget {
  const DropdownMenuDebounced({
    super.key,
    required this.onSearch,
    this.onChanged,
    this.onSelected,
    this.hintText = 'Search...',
    this.isLoading = false,
    required this.list,
    this.hasSelection
  });

  final Function(String search) onSearch;
  final Function(String text)? onChanged;
  final Function(int index)? onSelected;
  final String hintText;
  final bool isLoading;
  final List<String> list;
  final String? hasSelection;

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
  int selectedIndex = 0;

  _onSearchChanged(String text) async {
    if (widget.onChanged != null) widget.onChanged!(text);
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () async {
      await widget.onSearch(text);
      setState(() {
        selectedIndex = 0;
      });
    });
  }

  void initPosition() {
    final targetRenderBox = context.findRenderObject() as RenderBox;
    size = targetRenderBox.size;
  }

  void moveSelection(int step) {
    final int afterStep = selectedIndex + step;

    if (afterStep >= 0 && afterStep < widget.list.length) {
      setState(() {
        selectedIndex = selectedIndex + step;
      });
    }
  }

  void onKeyDown(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        moveSelection(1);
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        moveSelection(-1);
      }
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (widget.onSelected != null) widget.onSelected!(selectedIndex);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPosition());

    keyboardFocusNode = FocusNode();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (widget.hasSelection != null) {
          productController.text = '';
        }
      } else {
        if (widget.hasSelection != null) {
          productController.text = widget.hasSelection!;
        }
      }

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
            child: DropdownmenuOverlay(
              list: widget.list,
              isLoading: widget.isLoading,
              selectedIndex: selectedIndex,
            )
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
              SingleActivator(LogicalKeyboardKey.enter, alt: false): Intent.doNothing,
            },
            child: KeyboardListener(
              onKeyEvent: onKeyDown,
              focusNode: keyboardFocusNode,
              child: TextField(
                autofocus: true,
                controller: productController,
                focusNode: focusNode,
              ),
            ),
          ),
        ),
      )
    );
  }
}