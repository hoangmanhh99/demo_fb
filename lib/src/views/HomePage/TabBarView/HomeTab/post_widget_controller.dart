import 'dart:async';
import 'dart:convert';

import 'package:fakebook_flutter_app/src/helpers/fetch_data.dart';
import 'package:fakebook_flutter_app/src/helpers/shared_preferences.dart';
import 'package:fakebook_flutter_app/src/models/comment.dart';

class PostController {
  StreamController _isLiked = new StreamController.broadcast();
  StreamController _likeNumber = new StreamController.broadcast();
  StreamController _commentNumber = new StreamController.broadcast();

  Stream get isLikedStream => _isLiked.stream;

  Stream get likeNumberStream => _likeNumber.stream;

  Stream get commentNumberStream => _commentNumber.stream;

  void init(bool is_liked, String like, String comment) {
    _isLiked.sink.add(is_liked);
    _likeNumber.sink.add(like);
    _commentNumber.sink.add(comment);
  }

  Future<void> likeBehavior(bool is_liked, String like, String postId) async {
    _isLiked.sink.add(is_liked);
    is_liked
        ? _likeNumber.sink.add("${int.parse(like) + 1}")
        : _likeNumber.sink.add("${int.parse(like) - 1}");
    try {
      await FetchData.likeApi(await StorageUtil.getToken(), postId)
          .then((value) {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            //_likeNumber.sink.add("${val["data"]["like"]}");
            //_isLiked.sink.add(val["data"]["is_like"]);
          } else {
            //onError("Thiếu param");
            print("thieu param");
          }
        } else {
          //onError("Lỗi server: ${value.statusCode}");
          print("loi server");
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> setComment(
      String postId, String comment, String numberOfComment) async {
    String result;
    try {
      await FetchData.setCommentApi(
              await StorageUtil.getToken(), postId, comment)
          .then((value) {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            var json = val["data"];
            result = "ok";
            _commentNumber.sink.add("${int.parse(numberOfComment) + 1}");
          } else {
            //onError("Thiếu param");
            result = "loi server";
            print("thieu param");
          }
        } else {
          result = "loi server";
          print("loi server");
        }
      });
    } catch (e) {
      result = "loi mang";
      print(e.toString());
    }
    return result;
  }

  void dispose() {
    _isLiked.close();
    _likeNumber.close();
    _commentNumber.close();
  }
}

List<PostController> postController;
