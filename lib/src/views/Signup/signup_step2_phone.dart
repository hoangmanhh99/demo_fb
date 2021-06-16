import 'package:fakebook_flutter_app/src/helpers/validator.dart';
import 'package:fakebook_flutter_app/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_flutter_app/src/helpers/validator.dart';


class SignupPhone extends StatefulWidget {
  @override
  _SignupPhoneState createState() => _SignupPhoneState();
}

class _SignupPhoneState extends State<SignupPhone> {

  var _isPhoneNull;

  TextEditingController _phoneController = new TextEditingController();

  void initState() {
    super.initState();
    _isPhoneNull = false;
  }

  @override
  Widget build(BuildContext context) {
    UserModel userInput = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Số di động',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 45, 0, 45),
                child: Text(
                  "Nhập số di động của bạn",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                //textInputAction: TextInputAction.,
                keyboardType: TextInputType.phone,
                onChanged: (text) {
                  setState(() {
                    if (text.isNotEmpty) _isPhoneNull = false;
                  });
                },
                controller: _phoneController,
                autofocus: true,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Số điện thoại",
                    errorText: !_isPhoneNull
                        ? null
                        : "Vui lòng nhập một số di động hợp lệ",
                    suffixIcon: Visibility(
                      visible: _phoneController.text.isNotEmpty ? true : false,
                      child: new GestureDetector(
                        onTap: () {
                          setState(() {
                            _phoneController.text = '';
                            _isPhoneNull = false;
                          });
                        },
                        child: new Icon(Icons.close),
                      ),
                    ),
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () {
                      if(!Validators.isValidPhone(_phoneController.text)){
                        setState(() {
                          _isPhoneNull=true;
                        });
                      } else {
                        userInput.phone = _phoneController.text;
                        Navigator.pushNamed(context, "signup_step5",
                            arguments: userInput);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all((Radius.circular(8)))),
                    color: Colors.blue,
                    child: Text(
                      "Tiếp",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
