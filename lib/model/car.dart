// ignore_for_file: public_member_api_docs, sort_constructors_first

class Car {
  final int carId;
  final String carPanelNo;
  final String partnerMobile;
  final String state;
  final String carTypeId;
  final String customer;

  final String branch;
  Car({
    required this.carId,
    required this.carPanelNo,
    required this.partnerMobile,
    required this.state,
    required this.carTypeId,
    required this.customer,
    required this.branch,
  });

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> json = Map<String, dynamic>();
    json['car_panel_no'] = carPanelNo;
    json['partner_mobile'] = partnerMobile;
    json['state'] = state;
    json['car_type'] = carTypeId;
    json['id'] = carId;
    json['partner_name'] = customer;
    json['branch_name'] = branch;

    return json;
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
        carId: json['work_order_id'],
        carPanelNo: json['car_panel_no'],
        partnerMobile: json['partner_mobile'] == false
            ? 'no phone'
            : json['partner_mobile'],
        state: '',
        carTypeId: json['car_type'],
        customer: json['partner_name'],
        branch: json['branch_name']);
  }
}
