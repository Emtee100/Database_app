// ignore_for_file: camel_case_types

import 'package:database/password_reset.dart';
import 'package:database/signupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _loginFormKey;
  late final TextEditingController _emailController;
  late final FocusNode _loginFocusNode;
  late final TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _loginFocusNode = FocusNode();
    _passwordController = TextEditingController();
    _loginFormKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _loginFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isVisible = false;

  // these values of the below variables are going to be set by the emailSignin function and they will be fed to the errormessage of textfields

  // the boolean variable is for switching between the _emailErrorCode and _invalidEmailErrorCode

  bool _errorText =false;
  bool _passwordError = false;

  Future<UserCredential> signInWithGoogle() async {
    showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ));
            
    //Triger authentication flow i.e showing list of google accounts and store the data about that account into the variable
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //get the authentication tokens from the account and store them in the googleAuth runtime constant(final)
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    //create a credential
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    if (context.mounted) {
      Navigator.pop(context);
    }

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<dynamic> emailSignIn() async {
    try {
      showDialog(
        barrierColor: Colors.black26,
        barrierDismissible: false,
        context: context, builder: (context) => Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,),));
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if(context.mounted){
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _errorText = false;
        });
        if(context.mounted){
        Navigator.pop(context);
      }
      } else if (e.code == 'wrong-password') {
        setState(() {
          _passwordError = true;
        });
        if(context.mounted){
        Navigator.pop(context);
      }
      } else if (e.code == 'invalid-email') {
        setState(() {
          _errorText = true;
        });
        if(context.mounted){
        Navigator.pop(context);
      }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 250,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 4, 19, 48)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Sign in to your Account",
                      style: GoogleFonts.poppins(
                          fontSize: 35,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Sign in to your Account",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Form(
                key: _loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
                        onEditingComplete: () => _loginFocusNode.requestFocus(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an email address";
                          }
                          return null;
                        },
                        style: GoogleFonts.poppins(),
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        decoration: InputDecoration(
                            errorText: _errorText
                                ? "Cannot Find user"//'Email entered is not a valid email'
                                : null,
                            labelText: "Email Address",
                            labelStyle: GoogleFonts.poppins(),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 15.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onEditingComplete: () => _loginFocusNode.unfocus(),
                        focusNode: _loginFocusNode,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please a password";
                          }
                          return null;
                        },
                        obscureText: isVisible ? false : true,
                        style: GoogleFonts.poppins(),
                        decoration: InputDecoration(
                            focusColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            labelText: "Password",
                            errorText: _passwordError ? 'Wrong password' : null,
                            labelStyle: GoogleFonts.poppins(),
                            suffixIconColor: Colors.black,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: isVisible
                                    ? const Icon(Icons.visibility_rounded)
                                    : const Icon(
                                        Icons.visibility_off_outlined)),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordReset())),
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.primary),
                          )),
                    ),

                    //const SizedBox(height: 30.0,),

                    //Login Button

                    GestureDetector(
                      onTap: () {
                        if (_loginFormKey.currentState!.validate()) {
                          _loginFocusNode.unfocus();
                          emailSignIn();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 132.0, vertical: 18.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(244, 59, 245, 83)),
                        child: Text(
                          "Login",
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
                      height: 15.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(children: [
                        const Expanded(child: Divider()),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "Or login with",
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const Expanded(child: Divider()),
                      ]),
                    ),

                    const SizedBox(
                      height: 15.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => signInWithGoogle(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35.0, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(children: [
                                Image.asset(
                                  "assets/icons8-google-48.png",
                                  height: 15,
                                  width: 15,
                                ),
                                const SizedBox(
                                  width: 7.0,
                                ),
                                Text(
                                  "Google",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700),
                                )
                              ]),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/icons8-facebook-48.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 7.0,
                                  ),
                                  Text("Facebook",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700))
                                ]),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 40.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style:
                              GoogleFonts.poppins(color: Colors.grey.shade700),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpForm())),
                          child: Text(
                            "Register",
                            style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
