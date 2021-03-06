import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinico/models/myUser.dart';
import 'package:clinico/screens/authenticate/authenticate.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    // Check if Login then show apropriate page
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
