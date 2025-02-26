import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_main/preferences.dart';
import 'package:flutter_project_main/register.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

Color navyBlue = Colors.blueAccent;
String userEmail = '';

class _LoginPageState extends State<LoginPage> {
  String? errorEmail;
  String? errorPassword;
  bool pass = true;
  bool success = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  login() async {
    User? user = (await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passController.text))
        .user;

    if (user != null) {
      userEmail = user.email.toString();
      loginClick();
      setState(() {
        success = true;
      });
    } else {
      setState(() {
        success = false;
      });
    }
  }

  loginClick() {
    Preferences.addData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/bgdnm12.jpg"),
                fit: BoxFit.fitHeight,
                opacity: 0.8),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(60),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.deepPurple,
                    child: CircleAvatar(
                      radius: 85,
                      backgroundColor: Colors.black45,
                      foregroundImage: AssetImage("asset/giris1.png"),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: const Text("E - Mail"),
                      prefixIcon: const Icon(Icons.account_box),
                      errorText: errorEmail,
                    ),
                    onChanged: (val) {
                      setState(() {
                        errorEmail = val.isEmpty ? 'Geçerli Mail Adresi Giriniz' : null;
                      });
                    },
                    controller: emailController,
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    obscureText: pass,
                    decoration: InputDecoration(
                      label: const Text("Şifre"),
                      prefixIcon: const Icon(Icons.password_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            pass = !pass;
                          });
                        },
                        icon: Icon(
                            pass ? Icons.visibility_off : Icons.visibility),
                      ),
                      errorText: errorPassword,
                    ),
                    onChanged: (val) {
                      setState(() {
                        errorPassword =
                            val.isEmpty ? 'Lütfen Doğru Şifreyi Giriniz' : null;
                      });
                    },
                    controller: passController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: MaterialButton(
                      color: navyBlue,
                      height: 45,
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "GİRİŞ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        try {
                          await login();
                          if (success == true) {
                            Navigator.pushReplacementNamed(context, 'second');
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              "Geçersiz Bilgiler",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )));
                          }
                        } on FirebaseAuthException {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            "Geçersiz Bilgiler",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )));
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'fourth');
                      },
                      child: const Text(
                        "Hesabınız yoksa buraya tıklayın ve kayıt olun!",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
