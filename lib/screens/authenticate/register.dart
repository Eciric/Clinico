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

  final AuthService _auth =AuthService();
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
  String error ='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        title: Text('Sign up Clinico'),
        actions: <Widget>[
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyColors.darkSkyBlue),
            ),
            icon: Icon(Icons.person),
            label: Text('Sign in'),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: MyDecoration.textInputDecoration.copyWith(icon: Icon(Icons.person),hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Type Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: MyDecoration.textInputDecoration.copyWith(hintText: 'Password',icon: Icon(Icons.lock)),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Type Password 6+ chars' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
               TextFormField(
                decoration: MyDecoration.textInputDecoration.copyWith(hintText: 'Again Password',icon: Icon(Icons.lock)),
                obscureText: true,
                validator: (val) => val!=password ? 'Password must be the same' : null,
                onChanged: (val) {
                  setState(() => password2 = val);
                },
              ),
              SizedBox(height: 20.0),
               TextFormField(
                decoration: MyDecoration.textInputDecoration.copyWith(hintText: 'Name'),
                validator: (val) => val.length == 0? 'Please type name' : null,
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
              SizedBox(height: 20.0),
               TextFormField(
                decoration: MyDecoration.textInputDecoration.copyWith(hintText: 'Surname'),
                validator: (val) => val.length == 0? 'Please type surname' : null,
                onChanged: (val) {
                  setState(() => surname = val);
                },
              ),
              SizedBox(height: 20.0),
               TextFormField(
                decoration: MyDecoration.textInputDecoration.copyWith(hintText: 'Pesel number'),
                validator: (val) => validatePeselNumber(val),
                onChanged: (val) {
                  setState(() => pesel = val);
                },
              ),
              SizedBox(height: 20.0),
               TextFormField(
                decoration: MyDecoration.textInputDecoration.copyWith(hintText: 'Phone'),
                validator: (val) => validateMobile(val),
                onChanged: (val) {
                  setState(() => phoneNumber = val);
                },
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyColors.darkSkyBlue),
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.checkIfPeselIsAvaviable(pesel);
                    if(result != 0) {
                      setState(() {
                        error = 'Pesel is already in use';
                        loading = false;
                      });
                    } else {
                      result = await _auth.checkIfPhoneIsAvaviable(phoneNumber);
                      if(result != 0) {
                        setState(() {
                        error = 'Phone number is already in use';
                        loading = false;
                        });
                      } else {
                          result = await _auth.registerWithEmailAndPassword(email, password, pesel ,phoneNumber,surname,name);
                          if(result == null){
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
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(
                  color: MyColors.error,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 12.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Do you have account ?',
                    style: TextStyle(color: MyColors.darkSkyBlue),
                  ),
                  GestureDetector(
                  onTap: () {widget.toggleView();},
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: MyColors.darkSkyBlue, 
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