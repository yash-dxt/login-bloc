import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_up_streams/sign_up_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) {
        return Bloc();
      },
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bloc bloc;
    bloc = Provider.of<Bloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder(
              stream: bloc.email,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextField(
                    onChanged: bloc.addEmail,
                    decoration: InputDecoration(errorText: snapshot.error));
              },
            ),
            StreamBuilder(
              stream: bloc.password,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextField(
                    onChanged: bloc.addPassword,
                    decoration: InputDecoration(errorText: snapshot.error));
              },
            ),
            StreamBuilder(
                stream: bloc.submitValue,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  return RaisedButton(
                      child: Text('Login!'),
                      onPressed: snapshot.hasData
                          ? () {
                              print("""bloc.email bloc.password """);
                            }
                          : null);
                }),
          ],
        ),
      ),
    );
  }
}
