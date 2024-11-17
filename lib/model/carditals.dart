class CarDetail {
  int? id;
  int? headerId;
  String? categ_id;
  String? name;
  String? en_name;
  double unitPrice;
  String technicalisDone;
  String state;
  String? default_code;
  String completeDate;
  CarDetail({
    required this.id,
    required this.headerId,
    required this.categ_id,
    required this.name,
    required this.default_code,
    required this.en_name,
    required this.unitPrice,
    required this.technicalisDone,
    required this.state,
    required this.completeDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'headerId': headerId,
      'categ_id': categ_id,
      'name': name,
      'technical_is_done': technicalisDone,
      'state': state,
      'complete_date': completeDate,
      'unit_price': unitPrice,
      'en_name': en_name,
      'default_code': default_code,
    };
  }

  factory CarDetail.fromJson(Map<String, dynamic> json) {
    return CarDetail(
      id: json['id'] as int,
      default_code: json['default_code'] as String,
      name: json['name'] as String,
      en_name: json['en_name'] as String,
      categ_id: json['categ_id'].runtimeType != String
          ? json['categ_id'][1] as String
          : json['categ_id'] as String,
      headerId: json['headerId'].runtimeType != int
          ? json['headerId'][0] as int
          : json['headerId'] as int,
      technicalisDone: json['technical_is_done'].runtimeType != bool
          ? json['technical_is_done'][0].toString()
          : json['technical_is_done'].toString(),
      state: json['state'] == false ? 'NEW' : json['state'],
      unitPrice: json['unit_price'],
      completeDate: json['complete_date'] == String
          ? json['complete_date']
          : json['complete_date'].toString(),
    );
  }
  factory CarDetail.fromJson2(Map<String, dynamic> json) {
    return CarDetail(
        id: json['id'] as int,
        default_code: json['default_code'] as String,
        name: json['name'] as String,
        en_name: json['en_name'] as String,
        categ_id: json['categ_id'],
        headerId: json['headerId'],
        technicalisDone: json['technical_is_done'],
        state: json['state'] == false ? 'NEW' : json['state'],
        unitPrice: json['unit_price'],
        completeDate: json['complete_date']);
  }
}
