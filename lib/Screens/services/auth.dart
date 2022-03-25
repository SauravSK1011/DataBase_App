
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  Dio dio = new Dio();

  register(String name,String email,int phone, String work,   String password, String cpassword) async {
    try {
      var a=await dio.post('https://sskserver.herokuapp.com/register',
          data: {
            "name": name,
            "email": email,
            "phone": phone,
            "work": work,
            "passward": password,
            "cpassward": cpassword
          },
          options: Options(contentType: Headers.formUrlEncodedContentType,headers: {
            "Content-Type":"application/json",
          }));
          return a;
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.message
        // "Error"e,
      );
    }
  }
  login(String email , String password,) async {
    try {
      return await dio.post('https://sskserver.herokuapp.com/login',
          data: {
            "email": email,
            "passward": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType,headers: {
            "Content-Type":"application/json",
          }));
           
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.message
        // "Error"e,
      );
    }
  }
}
