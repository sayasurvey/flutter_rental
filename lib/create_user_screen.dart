import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ユーザ登録')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
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
                  child: const Text('ユーザ登録'),
                  onPressed: () async {
                    try {
                      final User? user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _email, password: _password))
                          .user;
                      if (user != null) {
                        print("ユーザ登録しました ${user.email} , ${user.uid}");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
              TextButton(
                child: const Text('ログイン画面へ'),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
