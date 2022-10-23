import 'package:flutter/material.dart';

class PropertyTile extends StatelessWidget {
  const PropertyTile({
    Key? key,
    required this.property,
    required this.propertyType,
  }) : super(key: key);

  final String property;
  final String propertyType;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '$propertyType:',
        style: const TextStyle(fontSize: 15),
      ),
      subtitle: Text(
        property,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
