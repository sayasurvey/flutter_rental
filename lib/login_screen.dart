import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: () async {
                    try {
                      final User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email, password: _password))
                          .user;
                      if (user != null) {
                        print("ログインしました ${user.email} , ${user.uid}");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
              TextButton(
                child: const Text('ユーザ登録画面へ'),
                onPressed: () {
                  Navigator.pushNamed(context, '/createUser');
                },
              ),
              TextButton(
                child: const Text('パスワードリセット画面へ'),
                onPressed: () {
                  Navigator.pushNamed(context, '/resetPassword');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
