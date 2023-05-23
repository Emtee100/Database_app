// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _loginFormKey;

  @override
  void initState() {
    _loginFormKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration:
                  BoxDecoration(color: Color.fromARGB(218, 10, 52, 131)),
            ),
            const SizedBox(
              height: 20.0,
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
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        decoration: InputDecoration(
                            focusColor:
                                Theme.of(context).colorScheme.background,
                            labelText: "Email Address",
                            labelStyle: GoogleFonts.poppins(),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            focusColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            labelText: "Password",
                            labelStyle: GoogleFonts.poppins(),
                            suffixIconColor: Colors.black,
                            suffixIcon: const IconButton(
                                onPressed: null,
                                icon: Icon(Icons.visibility_off_outlined)),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(right: 20.0),
                    //   child:
                    TextButton(
                        onPressed: () => print("hi"),
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.poppins(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                        )),

                    //   ),

                    //const SizedBox(height: 30.0,),

                    //Login Button

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 130.0, vertical: 18.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
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

                    
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
