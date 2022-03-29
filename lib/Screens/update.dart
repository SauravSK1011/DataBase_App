import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongoapp/Screens/login_page.dart';
import 'package:mongoapp/Screens/profile_page.dart';
import 'package:mongoapp/Screens/services/auth.dart';
import 'package:mongoapp/Screens/userprofile.dart';
import 'package:mongoapp/Screens/widgets/header_widget.dart';
import 'package:mongoapp/common/theme_helper.dart';
import 'package:mongoapp/models/user.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key, required this.user}) : super(key: key);
  final UsersModel user;
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  String name = "test1";
  int phone = 1234567898;
  String work = "dev";

  bool checkedValue = false;
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper()
                                .textInputDecoration('Name', 'Enter your name'),
                            onSaved: (name1) => setState(() {
                              name = name1!;
                            }),
                            validator: (val) {
                              if ((val!.isEmpty)) {
                                return "Enter your name";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Profession', 'Enter your Profession'),
                            onSaved: (profession) => setState(() {
                              work = profession!;
                            }),
                            validator: (val) {
                              if ((val!.isEmpty)) {
                                return "Please Enter your Profession";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number", "Enter your mobile number"),
                            onSaved: (value) => setState(() {
                              var myInt = int.parse(value!);
                              phone = myInt;
                            }),
                            validator: (val) {
                              if ((val!.isEmpty) || (val.length != 10)) {
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    const Text(
                                      "I accept all terms and conditions.",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Update".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                Auth()
                                    .update(
                                        name, widget.user.email, phone, work)
                                    .then((val) {
                                  if (val.data["Massage"] == "Update Done") {
                                    Fluttertoast.showToast(msg: "Update Done");
                                    UsersModel updateduser = UsersModel(
                                        email: val.data["Data"]["email"],
                                        name: val.data["Data"]["name"],
                                        phone: val.data["Data"]["phone"],
                                        work: val.data["Data"]["work"],
                                        address: val.data["Data"]["address"],
                                        token: val.data["Data"]["tokens"][
                                            ((val.data["Data"]["tokens"])
                                                    .length) -
                                                1]["token"],
                                        massage: '');
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ProfilePage(
                                                  user: updateduser,
                                                )));
                                  }
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
