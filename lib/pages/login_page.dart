import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../helper/show_Bar.dart';
import '../wedgets/Text_form_field.dart';
import '../wedgets/button.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  static String id = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;

  String? passward;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Image.asset('assets/images/scholar.png'),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextFormField(
                    onChanged: ((data) {
                        email = data;
                      }),
                      hintText: 'Enter Your Email',
                      labelText: 'Email',),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextFormField(
                    onChanged: ((data) {
                        passward = data;
                      }),
                    hintText: 'Enter Your Passward',
                    labelText: 'Passward',
                    obscureText: true
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Button(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await signinUser();
                         Navigator.pushNamed(context, chatPage.id,arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showBar(context,'user-not-found');
                          } else if (e.code == 'wrong-password') {
                          showBar(context, 'Wrong password provided for that user.');
                          }
                        }catch (e) {
                          showBar(context, 'ther was an error');
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    text: 'Sign In',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'do not have an acount ?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Register.id);
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Color(0xffC7EDE6)),
                          ))
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signinUser() async {
    // ignore: unused_local_variable
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: passward!);
  }
}
