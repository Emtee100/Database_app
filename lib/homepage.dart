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
   final Person = realm.all <person>();
   final Person1 = Person[0];
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
        children: [
          ElevatedButton(onPressed: (){realm.write(() {
            realm.add(person(ObjectId(), 'Mark Thomas', 'mt9510037@gmail.com'));
          },);}, child: Text('Add to realm')),
  

const SizedBox(height: 20,),

Container(
  height: 50,
  child: ListView.builder(
    itemCount: Person.length,
    itemBuilder: (context,index){
      return ListTile(
        title: Text(Person1.fullName),
      );
    }),
),
          Text(""" You're logged in as:
${FirebaseAuth.instance.currentUser!.email}"""),
ElevatedButton(onPressed: ()=>FirebaseAuth.instance.signOut(), child: Text("Sign out"))
]
      ),
    );
  }
}
