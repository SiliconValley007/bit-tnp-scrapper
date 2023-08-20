import 'package:flutter/material.dart';

class CreationAwareListItem extends StatefulWidget {
  const CreationAwareListItem({super.key, this.onCreated, required this.child});

  final VoidCallback? onCreated;
  final Widget child;

  @override
  State<CreationAwareListItem> createState() => _CreationAwareListItemState();
}

class _CreationAwareListItemState extends State<CreationAwareListItem> {
  @override
  void initState() {
    super.initState();
    widget.onCreated?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
