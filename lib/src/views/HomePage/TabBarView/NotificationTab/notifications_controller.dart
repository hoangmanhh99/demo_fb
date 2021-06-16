import 'dart:convert';
import 'package:fakebook_flutter_app/src/helpers/fetch_data.dart';
import 'package:fakebook_flutter_app/src/helpers/internet_connection.dart';
import 'package:fakebook_flutter_app/src/helpers/shared_preferences.dart';
import 'dart:async';

class NotificationController {
  Future<void> getNotification(
      {Function(List<dynamic>) onSuccess, Function(String) onError}) async {
    try {
      await FetchData.getNotification(await StorageUtil.getToken(), "0", "20")
          .then((value) {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            onSuccess(val['data']);
          } else {
            onError("Thiếu param");
          }
        } else {
          onError("Lỗi server: ${value.statusCode}");
        }
      });
    } catch (e) {
      onError(e.toString());
    }
  }
}
