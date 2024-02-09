import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                      onPressed: () async {
                        // signIn(widget.user, idcontroller.text);
                        await getEmail(widget.user, widget.idType);
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
                              FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email);
                              Fluttertoast.showToast(msg: 'Mail was sended');
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'please contact admin');
                              setState(() {});
                            }
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg:
                                    '${idcontroller.text.toString()} does not exits please check the Id');
                            setState(() {});
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Enter the id');
                          setState(() {});
                        }
                      } catch (e) {
                        Fluttertoast.showToast(msg: 'Please enter user id....');
                        setState(() {});
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
  getEmail(String collection, String id) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection(collection).get();

      if (collection == 'Student') {
        for (int i = 0; i < snapshot.docs.length; i++) {
          try {
            if (idcontroller.text.toString().isNotEmpty) {
              DocumentSnapshot snapshot = await FirebaseFirestore.instance
                  .collection(collection)
                  .doc(idcontroller.text.toString())
                  .get();

              if (snapshot.exists) {
                await FirebaseFirestore.instance
                    .collection(collection)
                    .doc(idcontroller.text.toString())
                    .get()
                    .then(
                  (value) {
                    emailId = value['Email'];
                  },
                ).whenComplete(
                  () {
                    if (emailId.isNotEmpty) {
                      if (passwordcontroller.text.toString().isNotEmpty) {
                        try {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailId,
                            password: passwordcontroller.text.toString(),
                          )
                              .then(
                            (value) async {
                              await setLocalData(
                                  collection, idcontroller.text.toString());
                              await getloginuserdata(
                                  collection, idcontroller.text.toString());
                              if (mounted) {
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForStudent(),
                                  ),
                                );
                              }
                            },
                          ).catchError(
                            (error) {
                              if (error is FirebaseAuthException) {
                                if (error.code == 'too-many-requests') {
                                  Fluttertoast.showToast(
                                    msg:
                                        'Too many login attempts. Please try again later.',
                                  );
                                } else if (error.code == 'wrong-password') {
                                  wrongpassword();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: error.message.toString());
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: error.message.toString());
                              }
                            },
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            wrongemailmessage();
                          } else if (e.code == 'wrong-password') {
                            wrongpassword();
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    'Something went wrong try after some time....');
                          }
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Please enter password....');
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'Email is does not exits...');
                    }
                  },
                );
              } else {
                Fluttertoast.showToast(
                    msg: 'Please check UserID or UserID does not exits...');
              }
            } else {
              Fluttertoast.showToast(msg: 'Please enter the UserId');
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-fount') {
              wrongemailmessage();
            } else if (e.code == 'wrong-password') {
              wrondpassword();
            } else if (e.code ==
                'cannot get field "Email" on a DocumentSnapshotPlatform which does not exist') {
            } else {
              Fluttertoast.showToast(msg: '${e.toString()}');
            }
          }
        }

        if (emailId.isEmpty) {
          Fluttertoast.showToast(msg: 'Email id is empty please contact admin');
        }
      }

      if (collection == 'Teacher') {
        for (int i = 0; i < snapshot.docs.length; i++) {
          try {
            if (idcontroller.text.toString().isNotEmpty) {
              DocumentSnapshot snapshot = await FirebaseFirestore.instance
                  .collection(collection)
                  .doc(idcontroller.text.toString())
                  .get();

              if (snapshot.exists) {
                await FirebaseFirestore.instance
                    .collection(collection)
                    .doc(idcontroller.text.toString())
                    .get()
                    .then(
                  (value) {
                    emailId = value['Email'];
                  },
                ).whenComplete(
                  () {
                    if (emailId.isNotEmpty) {
                      if (passwordcontroller.text.toString().isNotEmpty) {
                        try {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailId,
                            password: passwordcontroller.text.toString(),
                          )
                              .then(
                            (value) async {
                              uType = collection;
                              uId = id;
                              await setLocalData(
                                  collection, idcontroller.text.toString());
                              await getloginuserdata(collection, id);
                              if (mounted) {
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForStudent(),
                                  ),
                                );
                              }
                            },
                          ).catchError(
                            (error) {
                              if (error is FirebaseAuthException) {
                                if (error.code == 'too-many-requests') {
                                  Fluttertoast.showToast(
                                    msg:
                                        'Too many login attempts. Please try again later.',
                                  );
                                } else if (error.code == 'wrong-password') {
                                  wrongpassword();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: error.message.toString());
                                }
                              } else {
                                Fluttertoast.showToast(msg: error.toString());
                              }
                            },
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            wrongemailmessage();
                          } else if (e.code == 'wrong-password') {
                            wrongpassword();
                          } else {
                            Fluttertoast.showToast(msg: e.toString());
                          }
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Please enter password....');
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'Email is does not exits...');
                    }
                  },
                );
              } else {
                Fluttertoast.showToast(
                    msg: 'Please check UserID or UserID does not exits...');
              }
            } else {
              Fluttertoast.showToast(msg: 'Please enter the UserId');
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-fount') {
              wrongemailmessage();
            } else if (e.code == 'wrong-password') {
              wrondpassword();
            } else if (e.code ==
                'cannot get field "Email" on a DocumentSnapshotPlatform which does not exist') {
              Fluttertoast.showToast(
                  msg: 'Email is not exits please contact admin');
            } else {
              Fluttertoast.showToast(msg: e.toString());
            }
          }
        }

        if (emailId.isEmpty) {
          Fluttertoast.showToast(
              msg: 'Email id is not exits please contact admin');
        }
      }
      if (collection == 'Admin') {
        for (int i = 0; i < snapshot.docs.length; i++) {
          try {
            if (idcontroller.text.toString().isNotEmpty) {
              DocumentSnapshot snapshot = await FirebaseFirestore.instance
                  .collection(collection)
                  .doc(idcontroller.text.toString())
                  .get();

              if (snapshot.exists) {
                await FirebaseFirestore.instance
                    .collection(collection)
                    .doc(idcontroller.text.toString())
                    .get()
                    .then(
                  (value) {
                    emailId = value['Email'];
                  },
                ).whenComplete(
                  () {
                    if (emailId.isNotEmpty) {
                      if (passwordcontroller.text.toString().isNotEmpty) {
                        try {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailId,
                            password: passwordcontroller.text.toString(),
                          )
                              .then(
                            (value) async {
                              uType = collection;
                              uId = id;
                              await setLocalData(
                                  collection, idcontroller.text.toString());
                              await getloginuserdata(collection, id);
                              if (mounted) {
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForStudent(),
                                  ),
                                );
                              }
                            },
                          ).catchError(
                            (error) {
                              if (error is FirebaseAuthException) {
                                if (error.code == 'too-many-requests') {
                                  Fluttertoast.showToast(
                                    msg:
                                        'Too many login attempts. Please try again later.',
                                  );
                                } else if (error.code == 'wrong-password') {
                                  wrongpassword();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: error.message.toString());
                                }
                              } else {
                                Fluttertoast.showToast(msg: error.toString());
                              }
                            },
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            wrongemailmessage();
                          } else if (e.code == 'wrong-password') {
                            wrongpassword();
                          } else {
                            Fluttertoast.showToast(msg: e.toString());
                          }
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Please enter password....');
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'Email is does not exits...');
                    }
                  },
                );
              } else {
                Fluttertoast.showToast(
                    msg: 'Please check UserID or UserID does not exits...');
              }
            } else {
              Fluttertoast.showToast(msg: 'Please enter the UserId');
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-fount') {
              wrongemailmessage();
            } else if (e.code == 'wrong-password') {
              wrondpassword();
            } else if (e.code ==
                'cannot get field "Email" on a DocumentSnapshotPlatform which does not exist') {
              Fluttertoast.showToast(
                  msg: 'Email id is not exits please contact admin');
            } else {
              Fluttertoast.showToast(msg: e.toString());
            }
          }
        }

        if (emailId.isEmpty) {
          Fluttertoast.showToast(
              msg: 'Email id is not exits please contact admin');
        }
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      Navigator.pop(context); // Close the dialog
    }
  }

  void wrongpassword() {
    Fluttertoast.showToast(msg: 'Wrong password...');
  }
}
