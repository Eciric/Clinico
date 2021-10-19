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

  final AuthService _auth =AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error ='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.color1,
      appBar: AppBar(
        backgroundColor: MyColors.color2,
        elevation: 0.0,
        title: Text('Sign in Clinico'),
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              Text(
                'Login to Clinico',
                style: TextStyle(
                  fontSize: 35,
                  color: MyColors.color3,
                ),
                ),
              SizedBox(height: 20.0),
              Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/logo.jpg'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: MyDecoration.textInputDecoration.copyWith(hintText: 'Email',icon: Icon(Icons.person)),
                validator: (val) => val.isEmpty ? 'Type email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: MyDecoration.textInputDecoration.copyWith(hintText: 'Password',icon: Icon(Icons.lock)),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Password 6+ char' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyColors.color2),
                ),
                child: Text(
                  'Sing in',
                  style: TextStyle(color: MyColors.color3),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Wrong data';
                        loading = false;
                      });
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
                    'Don t have account ?',
                    style: TextStyle(color: MyColors.color3),
                  ),
                  GestureDetector(
                  onTap: () {widget.toggleView();},
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: MyColors.color3, 
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