import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../helper/show_Bar.dart';
import '../wedgets/Text_form_field.dart';
import '../wedgets/button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);
  static String id = 'registerPage';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;

  String? passward;

  bool isLoading = false;

  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formState,
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
                      'Register',
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
                      labelText: 'Email'),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      passward = data;
                    },
                    hintText: 'Enter Your Passward',
                    labelText: 'Passward',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Button(
                    onTap: () async {
                      if (formState.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await registerUser();
                          Navigator.pushNamed(context, chatPage.id);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showBar(context, 'weak passward');
                          } else if (e.code == 'email-already-in-use') {
                            showBar(context, 'email already in use');
                          }
                        } catch (e) {
                          showBar(context, 'ther was an error');
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    text: 'Register',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'already have an acount ?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
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

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: passward!);
  }
}
