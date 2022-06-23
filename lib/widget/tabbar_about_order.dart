import 'package:flutter/material.dart';

class TabbaraboutandOrder extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;
  const TabbaraboutandOrder({
    @required this.index,
    @required this.onChangedTab,
    Key key,
  }) : super(key: key);

  @override
  State<TabbaraboutandOrder> createState() => _TabbaraboutandOrderState();
}

class _TabbaraboutandOrderState extends State<TabbaraboutandOrder> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(
            index: 0,
            icon: Icon(Icons.add_shopping_cart),
          ),
          buildTabItem(
            index: 1,
            icon: Icon(Icons.article_sharp),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem({
    @required int index,
    @required Icon icon,
  }) {
    final isSelected = index == widget.index;
    return IconTheme(
      data: IconThemeData(
        color: isSelected ? Colors.red : Colors.black,
      ),
      child: IconButton(
        icon: icon,
        onPressed: () => widget.onChangedTab(index),
      ),
    );
  }
}
