import 'package:clinico/validcheck/validators.dart';
import 'package:flutter/material.dart';
import 'package:clinico/services/auth.dart';
import 'package:clinico/style/colors.dart';
import 'package:clinico/style/inputdecoration.dart';
import 'package:clinico/style/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String password2 = '';
  String name = '';
  String surname = '';
  String pesel = '';
  String phoneNumber = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: MyColors.steelTeal,
            appBar: AppBar(
              backgroundColor: MyColors.darkSkyBlue,
              elevation: 0.0,
              title: Text('Sign up Clinico'),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Container(
                        height: 150.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.jpg'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Register to Clinico',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 40.0),
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        decoration: MyDecoration.textInputDecoration.copyWith(
                          hintText: 'Email',
                          suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.email,
                                  color: Colors.white, size: 35.0)),
                        ),
                        validator: (val) => val.isEmpty ? 'Type Email' : null,
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
                            val.length < 6 ? 'Type Password 6+ chars' : null,
                        onChanged: (val) {
                          setState(() => password = val);
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
                        // ignore: missing_return
                        validator: (val) {
                          if (val != password) {
                            return 'Password must be the same';
                          } else if (val.length < 6) {
                            return 'Type Password 6+ chars';
                          } else
                            return null;
                        },
                        /* validator: (val) => val != password
                            ? 'Password must be the same'
                            : null, */
                        onChanged: (val) {
                          setState(() => password2 = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        decoration: MyDecoration.textInputDecoration.copyWith(
                          hintText: 'Name',
                          suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 35.0)),
                        ),
                        validator: (val) =>
                            val.length == 0 ? 'Please type name' : null,
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        decoration: MyDecoration.textInputDecoration.copyWith(
                          hintText: 'Surname',
                          suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 35.0)),
                        ),
                        validator: (val) =>
                            val.length == 0 ? 'Please type surname' : null,
                        onChanged: (val) {
                          setState(() => surname = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        decoration: MyDecoration.textInputDecoration.copyWith(
                          hintText: 'Pesel number',
                          suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 35.0)),
                        ),
                        validator: (val) => validatePeselNumber(val),
                        onChanged: (val) {
                          setState(() => pesel = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        decoration: MyDecoration.textInputDecoration.copyWith(
                          hintText: 'Phone',
                          suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.phone,
                                  color: Colors.white, size: 35.0)),
                        ),
                        validator: (val) => validateMobile(val),
                        onChanged: (val) {
                          setState(() => phoneNumber = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            maximumSize:
                                MaterialStateProperty.all(Size(300, 60)),
                            minimumSize:
                                MaterialStateProperty.all(Size(300, 60)),
                            backgroundColor:
                                MaterialStateProperty.all(MyColors.darkSkyBlue),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius:
                                        BorderRadius.circular(90.0)))),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.checkIfPeselIsAvaviable(pesel);
                            if (result != 0) {
                              setState(() {
                                error = 'Pesel is already in use';
                                loading = false;
                              });
                            } else {
                              result = await _auth
                                  .checkIfPhoneIsAvaviable(phoneNumber);
                              if (result != 0) {
                                setState(() {
                                  error = 'Phone number is already in use';
                                  loading = false;
                                });
                              } else {
                                result =
                                    await _auth.registerWithEmailAndPassword(
                                        email,
                                        password,
                                        pesel,
                                        phoneNumber,
                                        surname,
                                        name);
                                if (result == null) {
                                  setState(() {
                                    error = 'Incorrect email address';
                                    loading = false;
                                  });
                                }
                              }
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Do you have account? ',
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Text(
                              'Sign in',
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
          );
  }
}
