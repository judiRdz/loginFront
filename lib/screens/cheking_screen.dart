import 'package:flutter/material.dart';
import 'package:login_test/services/auth_services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authServices.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return Text('');
              if (snapshot.hasData != '') {
                Future.microtask(() {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder( //Para mandar a otra pagina
                          pageBuilder: (_, __, ___) => LoginPage(), //Construir la ruta
                          transitionDuration: Duration(seconds: 0)));
                });
              }else {
                Future.microtask((){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(pageBuilder: (_,__,___) => PrincipalScr(),
                     transitionDuration: Duration(seconds:0)));
                });
              }
            }),
      ),
    );
  }
}
