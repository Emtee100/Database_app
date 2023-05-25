import 'package:database/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final GlobalKey<FormState> _signUpFormKey;

  @override
  void initState() {
    _signUpFormKey = GlobalKey();
    super.initState();
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
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
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
                            obscureText: true,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
                                focusColor: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
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
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15.0),
                          child: TextFormField(
                            obscureText: true,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
                                focusColor: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                labelText: "Repeat Password",
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 118.0, vertical: 18.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(244, 59, 245, 83)),
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
