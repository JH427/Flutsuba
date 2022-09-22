import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //title, welcome text
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Flutsuba",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              //email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextField(
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              //password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your password',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    final userCredential =
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    print(userCredential);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print("Weak Password");
                    } else if (e.code == 'email-already-in-use') {
                      print('Email already in use');
                    } else if (e.code == 'invalid-email') {
                      print('Invalid email');
                    }
                  }
                },
                child: const Text("Register"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login/',
                    (route) => false,
                  );
                },
                child: Text('Already registered? Login here!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
