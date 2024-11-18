
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/car.dart';
import '../../../string/constans.dart';
import 'file_info_card.dart';

//the file name isn't snake_case identifier
class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.allcar,
    required this.technicalId,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final List allcar;
  final int technicalId;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: allcar.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          Car carItem = Car(
            carId: allcar[index]["work_order_id"],
            carPanelNo: allcar[index]["car_panel_no"] == false
                ? " "
                : allcar[index]["car_panel_no"],
            partnerMobile: allcar[index]["partner_mobile"] == false
                ? "nophone".tr
                : allcar[index]["partner_mobile"],
            state: '',
            carTypeId: allcar[index]["car_type"] == false
                ? " "
                : allcar[index]["car_type"],
            customer: allcar[index]["partner_name"] == false
                ? " "
                : allcar[index]["partner_name"],
            branch: allcar[index]["branch_name"] == false
                ? " "
                : allcar[index]["branch_name"],
          );

          return FileInfoCard(
            infoCar: carItem,
            technicalId: technicalId,
            cars: allcar,
          );
        });
  }
}
