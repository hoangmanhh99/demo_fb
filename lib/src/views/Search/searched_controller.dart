import 'dart:async';
import 'dart:convert';

import 'package:fakebook_flutter_app/src/helpers/fetch_data.dart';
import 'package:fakebook_flutter_app/src/helpers/shared_preferences.dart';
import 'package:fakebook_flutter_app/src/models/post.dart';

class SearchController {
  StreamController _savedSearch = new StreamController.broadcast();

  Stream get savedSearchStream => _savedSearch.stream;

  StreamController _search = new StreamController.broadcast();

  Stream get searchStream => _search.stream;

  String error;

  Future<void> getSavedSearch() async {
    error = "";
    _savedSearch.sink.add("");
    try {
      await FetchData.getSaveSearchApi(await StorageUtil.getToken(), 0, 10)
          .then((value) async {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            error = "Thành công";
            _savedSearch.sink.add(val['data']);
          } else {
            error = "Thiếu param";
            _savedSearch.addError(error);
          }
        } else {
          print(value.statusCode);
          print(value.body);
          error = "Lỗi server";
          _savedSearch.addError(error);
        }
      });
    } catch (e) {
      error = "Ứng dụng lỗi: " + e.toString();
      _savedSearch.addError("Không thể truy cập hãy thử lại");
      print(error);
    }
  }

  List<PostModel> parsePosts(Map<String, dynamic> json) {
    List<PostModel> temp;
    try {
      temp = List<PostModel>.from(
          json['data'].map((x) => PostModel.fromJson(x)).toList());
    } catch (e) {
      print(e.toString());
    }
    return temp;
  }

  List<PostModel> list;
  Future<void> search(String keyword) async {
    error = "";
    await _search.sink.add("");
    try {
      await FetchData.searchApi(await StorageUtil.getToken(), keyword,
              await StorageUtil.getUid(), 0, 10)
          .then((value) async {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            error = "Thành công";
            list = parsePosts(val);
            _search.sink.add(list);
          } else {
            error = "Thiếu param";
            _search.sink.addError(error);
          }
        } else {
          print(value.statusCode);
          print(value.body);
          error = "Lỗi server";
          _search.sink.addError(error);
        }
      });
    } catch (e) {
      error = "Ứng dụng lỗi: " + e.toString();
      _search.sink.addError("Không thể truy cập hãy thử lại");
      print(error);
    }
  }

  void dispose() {
    _savedSearch.close();
    _search.close();
  }
}

SearchController searchController = new SearchController();
