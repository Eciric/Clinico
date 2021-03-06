import 'package:flutter/material.dart';
import 'package:clinico/services/auth.dart';
import 'package:clinico/style/colors.dart';
import 'package:clinico/style/inputdecoration.dart';
import 'package:clinico/style/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/main_background.png'),
              fit: BoxFit.fill,
            )),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60.0),
                        Container(
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo.jpg'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 2, color: Colors.white)),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Login to Clinico',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 50.0),
                        TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: MyDecoration.textInputDecoration.copyWith(
                            hintText: 'Email',
                            suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Icons.person,
                                    color: Colors.white, size: 35.0)),
                          ),
                          validator: (val) => val.isEmpty ? 'Type email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: MyDecoration.textInputDecoration.copyWith(
                            hintText: 'Password',
                            suffixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.lock,
                                    color: Colors.white, size: 35.0)),
                          ),
                          obscureText: true,
                          validator: (val) =>
                              val.length < 6 ? 'Password 6+ char' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(300, 60)),
                              backgroundColor: MaterialStateProperty.all(
                                  MyColors.darkSkyBlue.withOpacity(0.5)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius:
                                          BorderRadius.circular(90.0)))),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Wrong data';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: MyColors.error,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.toggleView();
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
