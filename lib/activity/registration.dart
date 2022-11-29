import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_application/reusable/reusabletextfield.dart';
import 'package:test_application/routes.dart';
import 'login.dart';
import 'mainpage.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // ignore: prefer_typing_uninitialized_variables
  final formkey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names

  final _usercontroller = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        //  EdgeInsets.fromLTRB(MediaQuery.of(context).size.height*.5,30.0,30.0,30.0),
        child: Form(
          child: Column(
            children: <Widget>[
              /* Image.asset("assets/register.jpg",fit: BoxFit.fill), */
              Text(
                "$name registration",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 40.0),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "enter your name",
                    labelText: "Name",
                    icon: Icon(Icons.person)),
                onChanged: (value) {
                  name = value;
                  setState(() {});
                },
              ),
              /*  Textfields("Name",_Textcontroller), */
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "enter your Email",
                    labelText: "Email",
                    icon: Icon(Icons.email)),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "enter your Password",
                    labelText: "Pass",
                    icon: Icon(Icons.password)),
              ),
              TextFormField(
                validator: (value) {
                  if (value != _passwordController.text) {
                    return "Password did'nt match";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  hintText: "enter your Re-password",
                  labelText: "Re-pass",
                  icon: Icon(Icons.password),
                ),
              ),
              const SizedBox(height: 30.0, width: 130.0),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) {
                      value.user!.updateDisplayName(_usercontroller.text);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const Login();
                        },
                      ));
                    });
                  },
                  child: const Text(
                    "sign up",
                    textAlign: TextAlign.justify,
                  )),
              const SizedBox(height: 30.0, width: 130.0),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("already,have account"))
            ],
          ),
        ),
      ),
    );
  }
}
