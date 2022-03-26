import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongoapp/models/user.dart';

class Auth {
  Dio dio = new Dio();

  register(String name, String email, int phone, String work, String password,
      String cpassword) async {
    try {
      var a = await dio.post('http://192.168.56.1:3000/register',
          data: {
            "name": name,
            "email": email,
            "phone": phone,
            "work": work,
            "passward": password,
            "cpassward": cpassword
          },
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Content-Type": "application/json",
          }));
      print(a);
      return a;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.response.toString()
          // "Error"e,
          );
    }
  }

  login(
    String email,
    String password,
  ) async {
    try {
      HashMap h = new HashMap();

      var a = await dio.post('http://192.168.56.1:3000/login',
          data: {
            "email": email,
            "passward": password,
          },
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Content-Type": "application/json",
          }));
      // var responce=Uri.parse(a)
      // var jsondata = jsonDecode(a.data);

      // ignore: avoid_print
      // for (var key in a.data.) print(key); // prints Key_1 then Key_2
      // for (var value in a.data[1]) print(value); // prints Value_1 then Value_2
      // for (var entry in a.data[1]) {
      //   print(entry.key);
      //   print(entry.value);

//       var entryList = a.data.toList();
// print(entryList[0].key);
//       // }
      // print(a.data["Data"]["tokens"][((a.data["Data"]["tokens"]).length) - 1]
      //     ["token"]);

     UsersModel user= UsersModel(
       massage:a.data["Massage"],
          name: a.data["Data"]["name"],
          email: a.data["Data"]["email"],
          work: a.data["Data"]["work"],
          phone: a.data["Data"]["phone"],
          token: a.data["Data"]["tokens"][((a.data["Data"]["tokens"]).length) - 1]["token"]
          );
      return user;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.response.toString()
          // "Error"e,
          );
      print(e.response.toString());
      return e.message;
    }
  }
}
