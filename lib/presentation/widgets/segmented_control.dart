import 'package:flutter/material.dart';

class SegmentedControl extends StatefulWidget {
  final String title;
  final List<String> items;
  final void Function(int)? onPressed;
  final Function(int) valueIndex;
  const SegmentedControl({
    Key? key,
    required this.title,
    required this.items,
    required this.valueIndex,
    this.onPressed,
  }) : super(key: key);

  @override
  _SegmentedControlState createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'GloryRegular',
            fontSize: 16.0,
            height: 18.0 / 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: widget.items
              .map<Widget>((e) => _SegmentItem(
                    isSelected: widget.items[_selectedIndex] == e,
                    title: e,
                    onTap: () => {
                      widget.valueIndex(widget.items.indexOf(e)),
                      setState(
                        () => _selectedIndex = widget.items.indexOf(e),
                      )
                    },
                  ))
              .toList()
              .joined(const SizedBox(width: 8.0)),
        )
      ],
    );
  }
}

class _SegmentItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback? onTap;

  const _SegmentItem({
    Key? key,
    this.onTap,
    required this.isSelected,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(7.0),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 9.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: isSelected ? const Color(0xff6CC9E0) : Colors.white,
              border: isSelected
                  ? null
                  : Border.all(color: const Color(0xffBBBBBB)),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xff2B2B2B),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension ListExt<T> on List<T> {
  List<T> joined(T element) {
    return _joinedIterable(element).toList();
  }

  Iterable<T> _joinedIterable(T element) sync* {
    for (int i = 0; i < length; i++) {
      yield this[i];

      if (i + 1 != length) {
        yield element;
      }
    }
  }
}
