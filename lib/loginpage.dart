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
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
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
                        style: GoogleFonts.poppins(),
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        decoration: InputDecoration(
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
                        obscureText: true,
                        style: GoogleFonts.poppins(),
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

                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: TextButton(
                          onPressed: () => print("hi"),
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.primary),
                          )),
                    ),

                    //const SizedBox(height: 30.0,),

                    //Login Button

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 130.0, vertical: 18.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(244, 59, 245, 83)),
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10),
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
                                style: GoogleFonts.poppins(fontSize: 15),
                              )
                            ]),
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
                                  Text(
                                    "Facebook",
                                    style: GoogleFonts.poppins(fontSize: 15),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ), 

                    const SizedBox(height: 40.0,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",style: GoogleFonts.poppins(),),
                        Text("Register", style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.primary),)
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
