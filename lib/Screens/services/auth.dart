import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongoapp/models/user.dart';

class Auth {
  Dio dio = new Dio();

  register(String name, String email, int phone, String work, String password,
      String cpassword) async {
    try {
      var a = await dio.post('https://sskserver.herokuapp.com/register',
          data: {
            "name": name,
            "email": email,
            "phone": phone,
            "work": work,
            "passward": password,
            "cpassward": cpassword,
            "address": "address"
          },
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Content-Type": "application/json",
          }));
      return a;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.response.toString());
    }
  }

  update(String name, String email, int phone, String work) async {
    try {
      var a = await dio.post('http://10.0.2.2:3000/update',
          data: {
            "name": name,
            "email": email,
            "phone": phone,
            "work": work,
          },
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Content-Type": "application/json",
          }));
      return a;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.response.toString());
    }
  }

  addaddress(String email, String address) async {
    try {
      var a = await dio.post('https://sskserver.herokuapp.com/addaddress',
          data: {"email": email, "address": address},
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Content-Type": "application/json",
          }));
      return a;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.response.toString());
    }
  }

  login(
    String email,
    String password,
  ) async {
    try {
      var a = await dio.post('https://sskserver.herokuapp.com/login',
          data: {
            "email": email,
            "passward": password,
          },
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Content-Type": "application/json",
          }));
      UsersModel user = UsersModel(
        address: "address",
          massage: a.data["Massage"],
          name: a.data["Data"]["name"],
          email: a.data["Data"]["email"],
          work: a.data["Data"]["work"],
          phone: a.data["Data"]["phone"],
          token: a.data["Data"]["tokens"]
              [((a.data["Data"]["tokens"]).length) - 1]["token"]);
      return user;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.response.toString());
      return e.message;
    }
  }
}
