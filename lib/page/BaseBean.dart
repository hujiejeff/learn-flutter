/// errorCode : 0
/// errorMsg : ""

class BaseBean<T> {
  BaseBean(
    this.errorCode,
    this.errorMsg,
    this.data,
  );

  BaseBean.fromJson(Map<String, dynamic> json)
      : errorCode = json['errorCode'],
        errorMsg = json['errorMsg'],
        data = json['data'];

  int errorCode;
  String errorMsg;
  T? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorCode'] = errorCode;
    map['errorMsg'] = errorMsg;
    return map;
  }
}
