import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:produck_workshop/component/product_dropdown_overlay.dart';
import 'package:produck_workshop/model/product.dart';
import 'package:produck_workshop/services/product.dart';

class ProductDropdown extends StatefulWidget {
  const ProductDropdown({
    super.key,
    required this.onSelected,
    required this.onSearch,
    required this.future
  });

  final ValueSetter<Product> onSelected;
  final ValueSetter<String> onSearch;
  final Future<List<Product>> future;

  @override
  State<ProductDropdown> createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<ProductDropdown> {
  Timer? _debounce;
  final Duration _debounceDuration = const Duration(milliseconds: 300);

  final productController = TextEditingController();
  final OverlayPortalController productsOverlayController = OverlayPortalController();
  final layerLink = LayerLink();
  late Size size;

  late FocusNode keyboardFocusNode;

  int currentIndex = 0;
  Product? selectedProduct;

  _onSearchChanged(String text) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () {
      widget.onSearch(text);
      currentIndex = 0;
    });
  }

  void initPosition() {
    final targetRenderBox = context.findRenderObject() as RenderBox;
    size = targetRenderBox.size;
  }

  void moveSelection(int step) {
    final int afterStep = currentIndex + step;

    if (afterStep >= 0 && afterStep < productList.length) {
      setState(() {
        currentIndex = currentIndex + step;
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
        final selected = productList[currentIndex];
        selectedProduct = selected;
        widget.onSelected(selected);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPosition());

    keyboardFocusNode = FocusNode();
    productFocusNode = FocusNode();
    productFocusNode.addListener(() {
      if (productFocusNode.hasFocus) {
        if (selectedProduct != null) {
          productController.text = '';
        }
      } else {
        if (selectedProduct != null) {
          productController.text = selectedProduct!.name;
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
    productFocusNode.dispose();
    keyboardFocusNode.dispose();
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
            child: ProductDropdownOverlay(
              future: widget.future,
              currentIndex: currentIndex,
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
                focusNode: productFocusNode,
              ),
            ),
          ),
        ),
      )
    );
  }
}