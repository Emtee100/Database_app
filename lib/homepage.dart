import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Homepage",
          style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [Text(""" You're logged in as:
${FirebaseAuth.instance.currentUser!.email}"""),
ElevatedButton(onPressed: ()=>FirebaseAuth.instance.signOut(), child: Text("Sign out"))
]
      ),
    );
  }
}
