import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Home/forstudent.dart';
import 'package:my_app/utils/constant/constants.dart';

class UserLogIn extends StatefulWidget {
  final String user; //define user type
  final String idType; //define userlogin id
  final int studentsemester = 0;

  const UserLogIn({super.key, required this.user, required this.idType});

  @override
  State<UserLogIn> createState() => _UserLogInState();
}

class _UserLogInState extends State<UserLogIn> {
  TextEditingController idcontroller =
      TextEditingController(); //user id controller
  TextEditingController passwordcontroller =
      TextEditingController(); //user password controller

  var emailId = '';
  var password = '';
  @override
  void initState() {
    super.initState();
    setLocalData(widget.user, widget.idType);
  }

  @override
  void dispose() {
    super.dispose();
    passwordcontroller.dispose();
    idcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              loginText(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                //id textformfield
                child: TextFormField(
                  controller: idcontroller,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: '${widget.user} ${widget.idType}',
                    labelText: widget.idType,
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          width: 2,
                          color: Colors.black,
                          style: BorderStyle.solid),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                //Password textformfield
                child: TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    hintText: '${widget.user} password',
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          width: 2,
                          color: Colors.black,
                          style: BorderStyle.solid),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 45),
                    //login button
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(250, 60),
                        textStyle: TextStyle(fontSize: 25),
                      ),
                      onPressed: () {
                        signIn(widget.user, idcontroller.text);
                      },
                      child: Text("LogIn"),
                    ),
                  ),
                  //back button
                  backButton(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                    onTap: () async {
                      try {
                        if (idcontroller.text.toString().isNotEmpty) {
                          try {
                            await FirebaseFirestore.instance
                                .collection(widget.user)
                                .doc(idcontroller.text.toString())
                                .get()
                                .then((value) {
                              email = value['Email'];
                            });
                            if (email.isNotEmpty) {
                              print('Send');
                              // FirebaseAuth.instance
                              //     .sendPasswordResetEmail(email: email);
                            } else {
                              print('please contact admin');
                            }
                          } catch (e) {
                            print('does not exits');
                          }
                        } else {
                          print('Enter the id');
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: Text('forgate password')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Login heading
  loginText() {
    return Padding(
      padding: const EdgeInsets.only(top: 230),
      child: Center(
        child: Text(
          "Log in As - ${widget.user}",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  //Login process method
  Future signIn(String collection, String id) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await getEmail(collection, id);

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailId,
        password: passwordcontroller.text.toString(),
      )
          .then((value) async {
        uType = collection;
        uId = id;
        await setLocalData(collection, id);
        await getloginuserdata(collection, id);
        Navigator.pop(context);
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ForStudent(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongemailmessage();
      } else if (e.code == 'wrong-password') {
        wrondpassword();
      } else {
        print(e);
      }
    }
    
  }

  //Wrong email method
  void wrongemailmessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Invalid User"),
          );
        });
  }

  //Wrong password method
  void wrondpassword() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Invalid Password"),
        );
      },
    );
  }

  //Backbutton method
  backButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size.fromRadius(30),
        ),
        child: const Icon(Icons.keyboard_backspace_sharp),
      ),
    );
  }

  //getting use email method
  Future getEmail(String collection, String id) async {
    try {
      await FirebaseFirestore.instance.collection(collection).get().then(
        (QuerySnapshot snapshot) {
          snapshot.docs.forEach(
            (element) async {
              if (collection == 'Student') {
                if (id == element['Enrollment No']) {
                  await FirebaseFirestore.instance
                      .collection(collection)
                      .doc(id)
                      .get()
                      .then(
                    (value) {
                      setState(
                        () {
                          emailId = value['Email'];
                        },
                      );
                    },
                  );
                } else {
                  wrongemailmessage();
                }
              } else if (collection == 'Teacher') {
                if (id == element['TID']) {
                  await FirebaseFirestore.instance
                      .collection(collection)
                      .doc(id)
                      .get()
                      .then(
                    (value) {
                      setState(
                        () {
                          emailId = value['Email'];
                        },
                      );
                    },
                  );
                } else {
                  wrongemailmessage();
                }
              } else if (collection == 'Admin') {
                if (id == element['AID']) {
                  await FirebaseFirestore.instance
                      .collection(collection)
                      .doc(id)
                      .get()
                      .then(
                    (value) {
                      setState(
                        () {
                          emailId = value['Email'];
                        },
                      );
                    },
                  );
                } else {
                  wrongemailmessage();
                }
              }
              setState(() {});
            },
          );
        },
      );
    } on FirebaseException catch (e) {
      print(e);
    }
    
    return emailId;
  }
}
