class UserModel {
  int? id;
  String? image;
  FaceFeatures? faceFeatures;
  UserModel({
    this.id,
    this.image,
    this.faceFeatures,
  });
//
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      image: json['image'],
      faceFeatures: FaceFeatures.fromJson(json["faceFeatures"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json["botton_mouth_x"] = faceFeatures!.bottomMouth!.x;
    json["botton_mouth_y"] = faceFeatures!.bottomMouth!.y;

    json["left_cheak_x"] = faceFeatures!.leftCheek!.x;
    json["left_cheak_y"] = faceFeatures!.leftCheek!.y;

    json["left_ear_x"] = faceFeatures!.leftEar!.x;
    json["left_ear_y"] = faceFeatures!.leftEar!.y;

    json["left_eye_x"] = faceFeatures!.leftEye!.x;
    json["left_eye_y"] = faceFeatures!.leftEye!.y;

    json["left_mouth_x"] = faceFeatures!.leftMouth!.x;
    json["left_mouth_y"] = faceFeatures!.leftMouth!.y;

    json["nose_base_x"] = faceFeatures!.noseBase!.x;
    json["nose_base_y"] = faceFeatures!.noseBase!.y;

    json["right_cheak_x"] = faceFeatures!.rightCheek!.x;
    json["right_cheak_y"] = faceFeatures!.rightCheek!.y;

    json["right_ear_x"] = faceFeatures!.rightEar!.x;
    json["right_ear_y"] = faceFeatures!.rightEar!.y;

    json["right_eye_x"] = faceFeatures!.rightEye!.x;
    json["right_eye_y"] = faceFeatures!.rightEye!.y;

    json["right_mouth_x"] = faceFeatures!.rightMouth!.x;
    json["right_mouth_y"] = faceFeatures!.rightMouth!.y;

    json["employee_id"] = id;
    return json;
  }
}

class FaceFeatures {
  Points? rightEar;
  Points? leftEar;
  Points? rightEye;
  Points? leftEye;
  Points? rightCheek;
  Points? leftCheek;
  Points? rightMouth;
  Points? leftMouth;
  Points? noseBase;
  Points? bottomMouth;

  FaceFeatures({
    this.rightMouth,
    this.leftMouth,
    this.leftCheek,
    this.rightCheek,
    this.leftEye,
    this.rightEar,
    this.leftEar,
    this.rightEye,
    this.noseBase,
    this.bottomMouth,
  });

  factory FaceFeatures.fromJson(Map<String, dynamic> json) => FaceFeatures(
        rightMouth: Points.fromJson(
            {"x": json['right_mouth_x'], "y": json['right_mouth_y']}),
        leftMouth: Points.fromJson(
            {"x": json['left_mouth_x'], "y": json['left_mouth_y']}),
        leftCheek: Points.fromJson(
            {"x": json['left_cheak_x'], "y": json['left_cheak_y']}),
        rightCheek: Points.fromJson(
            {"x": json['right_cheak_x'], "y": json['right_cheak_y']}),
        leftEye:
            Points.fromJson({"x": json['left_eye_x'], "y": json['left_eye_y']}),
        rightEar: Points.fromJson(
            {"x": json['right_ear_x'], "y": json['right_ear_y']}),
        leftEar:
            Points.fromJson({"x": json['left_ear_x'], "y": json['left_ear_y']}),
        rightEye: Points.fromJson(
            {"x": json['right_eye_x'], "y": json['right_eye_y']}),
        noseBase: Points.fromJson(
            {"x": json['nose_base_x'], "y": json['nose_base_y']}),
        bottomMouth: Points.fromJson(
            {"x": json['botton_mouth_x'], "y": json['botton_mouth_y']}),
      );

  Map<String, dynamic> toJson() => {
        "rightMouth": rightMouth?.toJson() ?? {},
        "leftMouth": leftMouth?.toJson() ?? {},
        "leftCheek": leftCheek?.toJson() ?? {},
        "rightCheek": rightCheek?.toJson() ?? {},
        "leftEye": leftEye?.toJson() ?? {},
        "rightEar": rightEar?.toJson() ?? {},
        "leftEar": leftEar?.toJson() ?? {},
        "rightEye": rightEye?.toJson() ?? {},
        "noseBase": noseBase?.toJson() ?? {},
        "bottomMouth": bottomMouth?.toJson() ?? {},
      };
}

class Points {
  int? x;
  int? y;

  Points({
    required this.x,
    required this.y,
  });

  factory Points.fromJson(Map<String, dynamic> json) => Points(
        x: (json['x'] ?? 0) as int,
        y: (json['y'] ?? 0) as int,
      );

  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}
