import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  title: const Text("Homepage"),
  backgroundColor: Theme.of(context).colorScheme.primary,
),
body: Center(child: Text("${FirebaseAuth.instance.currentUser!.email}"),),
    );
  }
}