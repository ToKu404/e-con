import 'package:e_con/src/presentations/features/login/pages/login_page.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrapper to check if user is login or not
    // final userNotifier = context.watch<>();
    // return StreamBuilder<UserEntity>(
    //   builder: (context, snapshot){
    //     if(snapshot.connectionState == ConnectionState.active){
    //       final UserEntity? user = snapshot.data;
    //       return user == null ? LoginPage() : MainPage(user: user);
    //     }else{
    //       return const Scaffold(body: LoadingIndicator());
    //     }
    //   }
    // );
    return LoginPage();
  }
}
