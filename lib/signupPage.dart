import 'package:database/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final GlobalKey<FormState> _signUpFormKey;
  late final TextEditingController _emailController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _repeatPasswordFocusNode;
  late final TextEditingController _fullName;
  late final TextEditingController _repeatPasswordController;
  late final TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    _passwordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    _fullName = TextEditingController();
    _repeatPasswordController = TextEditingController();
    _signUpFormKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _repeatPasswordController.dispose();
    _passwordFocusNode.dispose();
    _repeatPasswordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _fullName.dispose();
    super.dispose();
  }

  bool isPasswordVisible = false;
  bool isRepeatPasswordVisible = false;
  bool _weakPassword = false;
  bool emailUsed = false;
  bool _invalidEmail = false;
  createUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      //Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          _weakPassword = !_weakPassword;
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          _invalidEmail = !_invalidEmail;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              Container(
                width: 400,
                height: 250,
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 4, 19, 48)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Register",
                        style: GoogleFonts.poppins(
                            fontSize: 35,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Create your account",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Form(
                  key: _signUpFormKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            onEditingComplete: () =>
                                _emailFocusNode.requestFocus(),
                            controller: _fullName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your full name";
                              }
                              return null;
                            },
                            style: GoogleFonts.poppins(),
                            autofocus: true,
                            decoration: InputDecoration(
                                labelText: "Full Name",
                                labelStyle: GoogleFonts.poppins(),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                          child: TextFormField(
                            focusNode: _emailFocusNode,
                            onEditingComplete: () =>
                                _passwordFocusNode.requestFocus(),
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your email address";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
                                errorText: _invalidEmail
                                    ? 'This is an invalid Email'
                                    : null,
                                focusColor: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                labelText: "Email",
                                labelStyle: GoogleFonts.poppins(),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                          child: TextFormField(
                            focusNode: _passwordFocusNode,
                            onEditingComplete: () =>
                                _repeatPasswordFocusNode.requestFocus(),
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter a password";
                              } else if (value.length < 6) {
                                return "Password needs to have a minimum of 6 characters";
                              }
                              return null;
                            },
                            obscureText: isPasswordVisible ? false : true,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
                                errorStyle: GoogleFonts.poppins(),
                                errorText:
                                    _weakPassword ? 'Weak password' : null,
                                focusColor: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                labelText: "Password",
                                labelStyle: GoogleFonts.poppins(),
                                suffixIconColor: Colors.black,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                    icon: isPasswordVisible
                                        ? const Icon(Icons.visibility_rounded)
                                        : const Icon(
                                            Icons.visibility_off_outlined)),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15.0),
                          child: TextFormField(
                            focusNode: _repeatPasswordFocusNode,
                            onEditingComplete: () =>
                                _repeatPasswordFocusNode.unfocus(),
                            controller: _repeatPasswordController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value != _passwordController.text) {
                                return "Your password doesn't match";
                              }
                              return null;
                            },
                            obscureText: isRepeatPasswordVisible ? false : true,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
                                focusColor: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                labelText: "Repeat Password",
                                labelStyle: GoogleFonts.poppins(),
                                suffixIconColor: Colors.black,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isRepeatPasswordVisible =
                                            !isRepeatPasswordVisible;
                                      });
                                    },
                                    icon: isRepeatPasswordVisible
                                        ? const Icon(Icons.visibility_rounded)
                                        : const Icon(
                                            Icons.visibility_off_outlined)),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              createUser();
                            }
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 118.0, vertical: 18.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(244, 59, 245, 83)),
                            child: Text(
                              "Register",
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "I have an account?",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey.shade700),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage())),
                                child: Text(
                                  "Log in",
                                  style: GoogleFonts.poppins(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ])
                      ]))
            ])));
  }
}
