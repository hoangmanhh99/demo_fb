// import 'package:validators/validators.dart' as validate;

class ParseDate {
  // Check email
  static String parse(String created) {
    print(created);
    // if(DateTime.)
    var b, a;
    try {
      b = DateTime.parse(created);
      a = DateTime.now().difference(b);
    } catch (e) {
      return created;
    }

    // if (a.inHours.)
    var createdTemp;
    if (a.inMinutes < 1) {
      createdTemp = "Vừa xong";
    } else if (a.inHours < 1) {
      createdTemp = a.inMinutes.toString() + " phút";
    } else if (a.inHours < 24) {
      createdTemp = a.inHours.toString() + " giờ";
    } else if (a.inDays < 31) {
      createdTemp = a.inDays.toString() + " ngày";
    } else {
      createdTemp = b.day.toString() +
          " thg " +
          b.month.toString() +
          ", " +
          b.year.toString();
    }
    return createdTemp;
  }

  static String parseMessage(String created) {
    var b = DateTime.parse(created);
    var a = DateTime.now().difference(b);
    // if (a.inHours.)
    var minute =
        b.minute > 10 ? b.minute.toString() : "0" + b.minute.toString();
    var hour = b.hour > 10 ? b.hour.toString() : "0" + b.hour.toString();
    var createdTemp;
    var weekday = b.weekday == 8 ? "Chủ nhật" : "Thứ " + b.weekday.toString();
    if (a.inHours < 24) {
      createdTemp = hour + ":" + minute;
    } else if (a.inDays > 1) {
      createdTemp = weekday + " " + hour + ":" + minute;
    } else {
      createdTemp = hour +
          ":" +
          minute +
          " " +
          b.day.toString() +
          " thg " +
          b.month.toString() +
          ", " +
          b.year.toString();
    }
    return createdTemp;
  }
}
