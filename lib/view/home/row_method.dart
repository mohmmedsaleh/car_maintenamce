import 'package:car_maintenance_technicians/string/constans.dart';
import 'package:flutter/material.dart';

TableRow rowMethod(BuildContext context, text, item) {
  return TableRow(
    // decoration: BoxDecoration(color: secondaryColor.withOpacity(0.3)),
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding * 1,
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall!,
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding * 1,
          ),
          child: Center(
            child: Text(
              item.toString(),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.visible,
              style: Theme.of(context).textTheme.headlineSmall!,
            ),
          ),
        ),
      ),
    ],
  );
}
