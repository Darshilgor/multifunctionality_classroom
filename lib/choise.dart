import 'package:flutter/material.dart';
import 'package:my_app/userlogin.dart';

class Choise extends StatelessWidget {
  const Choise({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 230),
                const Text(
                  "Login As",
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  height: 35,
                ),
                //Goto student login
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.assignment_ind_sharp,
                    size: 30,
                  ),
                  onPressed: () {
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserLogIn(
                                  user: 'Student', idType: 'Enrollement No')));
                    }
                  },
                  label: const Text(
                    "Student",
                    style: TextStyle(fontSize: 30),
                  ),
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(180, 50)),
                ),
                const SizedBox(height: 20),
                //Goto teacher login
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserLogIn(
                                user: 'Teacher', idType: 'Teacher Id')));
                  },
                  label: const Text(
                    "Teacher",
                    style: TextStyle(fontSize: 30),
                  ),
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(180, 50)),
                ),
                const SizedBox(height: 20),
                //Goto admin login
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.admin_panel_settings,
                    size: 33,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UserLogIn(user: 'Admin', idType: 'Admin Id')));
                  },
                  label: const Text(
                    "Admin",
                    style: TextStyle(fontSize: 30),
                  ),
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(180, 50)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
