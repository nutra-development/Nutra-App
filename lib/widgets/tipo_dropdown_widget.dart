import 'package:flutter/material.dart';

class TipoDropdownWidget extends StatefulWidget {
  final String campoNome;
  final List<String> options;
  final List<String> selectedValues;
  final void Function(List<String>) onChanged;

  const TipoDropdownWidget({
    super.key,
    required this.campoNome,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
  });

  @override
  State<TipoDropdownWidget> createState() => _TipoDropdownWidgetState();
}

class _TipoDropdownWidgetState extends State<TipoDropdownWidget> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late List<String> tempSelected; // Seleções temporárias no modal

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height + 5,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: BoxConstraints(maxHeight: 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        ...widget.options.map((option) {
                          final isSelected = tempSelected.contains(option);
                          return ListTile(
                            title: Text(
                              option,
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Theme.of(context).primaryColor : Colors.black,
                              ),
                            ),
                            trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
                            tileColor: isSelected ? Colors.grey[200] : null,
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  tempSelected.remove(option);
                                } else {
                                  tempSelected.add(option);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              tempSelected.clear();
                            });
                          },
                          child: Text("Limpar"),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onChanged(List.from(tempSelected));
                            _removeOverlay();
                          },
                          child: Text("Aplicar"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      tempSelected = List.from(widget.selectedValues);
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      setState(() {
        _isOpen = true;
      });
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String label;
    if (widget.selectedValues.isEmpty) {
      label = widget.campoNome;
    } else if (widget.selectedValues.length == 1) {
      label = widget.selectedValues.first;
    } else {
      label = '${widget.selectedValues.length} selecionados';
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.selectedValues.isEmpty ? Colors.grey : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
