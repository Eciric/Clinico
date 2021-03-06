import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinico/models/myUser.dart';
import 'package:clinico/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:clinico/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: new ThemeData(
          canvasColor: MyColors.steelTeal,
        ),
        home: Wrapper(),
      ),
    );
  }
}
