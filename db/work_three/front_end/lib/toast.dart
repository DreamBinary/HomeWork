import 'package:fluttertoast/fluttertoast.dart';

void toast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    fontSize: 16.0,
    webBgColor: "linear-gradient(to right, #512DA8, #9575CD)",
    webPosition: "center",
  );
}
