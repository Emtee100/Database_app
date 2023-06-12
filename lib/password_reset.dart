import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  late GlobalKey<FormState> _passwordReset;
  late TextEditingController _emailController;
  final _passwordFocusNode = FocusNode();
  String errorText = '';
  bool showErrorText = false;

  @override
  void initState() {
    _passwordReset = GlobalKey();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  sendPasswordResetMail() async {
    try {
      showDialog(
          barrierColor: Colors.black26,
          barrierDismissible: false,
          context: context,
          builder: (context) => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ));
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      setState(() {
        showErrorText = false;
      });
      if (context.mounted) {
        Navigator.pop(context);
      }
      // ignore: use_build_context_synchronously
      showModalBottomSheet(
          showDragHandle: true,
          elevation: 12,
          context: context,
          builder: (context) {
            return Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(15),
                    child: const Icon(Icons.email),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Check your email',
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                        'We have sent instructions to reset your password to your email',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _emailController.clear();
                      _passwordFocusNode.unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140, vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 4, 19, 48),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Done',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          showErrorText = true;
          errorText = 'There\'s no user that has the given email';
        });
        if (context.mounted) {
          Navigator.pop(context);
        }
      } else if (e.code == 'invalid-email') {
        setState(() {
          showErrorText = true;
          errorText = 'Email provided is invalid';
        });
        if (context.mounted) {
          Navigator.pop(context);
        }
      } else if (e.code == 'invalid-continue-uri') {
        print('invalid continue URL');
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
                        "Forgot Password",
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
                        "Enter your email account to reset password",
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
                  key: _passwordReset,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your email";
                              }
                              return null;
                            },
                            style: GoogleFonts.poppins(),
                            autofocus: true,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                                errorText: showErrorText ? errorText : null,
                                labelText: "Email",
                                labelStyle: GoogleFonts.poppins(),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                        ),
                        // Text(
                        //   _errorText,
                        //   style: GoogleFonts.poppins(
                        //       color: Theme.of(context).colorScheme.error),
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_passwordReset.currentState!.validate()) {
                              sendPasswordResetMail();
                            }
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 110.0, vertical: 18.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(244, 59, 245, 83)),
                            child: Text(
                              "Continue",
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ]))
            ])));
  }
}
