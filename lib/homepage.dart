import 'package:database/database/person_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Person = realm.query<person>('emailAddress BEGINSWITH \$0 AND fullName CONTAINS \$1', ['m', 'Mark']);
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
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              realm.write(
                () {
                  realm.addAll([
                    person(ObjectId(), 'Elizabeth Mbonne', 'liz@gmail.com'),
                    person(ObjectId(), 'William Ruto', 'wruto@gmail.com'),
                    person(ObjectId(), 'Mark Thomas',
                        'markthomaskahiga@gmail.com'),
                    person(ObjectId(), 'Thomas Ngunjiri',
                        'thomaskahiga@gmail.com'),

                  ]);
                },
              );
            },
            child: const Text('Add to realm')),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          child: ListView.builder(
              itemCount: Person.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(Person[index].fullName),
                );
              }),
        ),
        Text(""" You're logged in as:
${FirebaseAuth.instance.currentUser!.email}"""),
        ElevatedButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            child: Text("Sign out"))
      ]),
    );
  }
}
