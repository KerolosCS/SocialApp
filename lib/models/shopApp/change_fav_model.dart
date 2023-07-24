class ChangeFavModel {
  bool? status;
  String? msg;
  ChangeFavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['message'];
  }
}
