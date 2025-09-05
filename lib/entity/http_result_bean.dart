import 'package:linecheck/util/macro.dart';

class HttpResultBean {
  String? msg;
  int? code;
  dynamic data;
  Exception? error;

  bool get succeed {
    return error == null && code == 0;
  }

  HttpResultBean({this.msg, this.data, this.code, this.error});

  HttpResultBean.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['data'] = this.data;
    data['code'] = code;

    return data;
  }

  bool isFail() {
    return !succeed;
  }

  void showMessage() {
    dismissLoading();
    showToast(msg);
  }
}
