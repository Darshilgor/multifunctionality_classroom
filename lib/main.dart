import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/Home/forstudent.dart';
import 'package:my_app/firebase_options.dart';
import 'package:my_app/utils/constant/constants.dart';
import 'package:my_app/utils/login/choise.dart';
import 'package:my_app/utils/login/loginbloc/login_bloc.dart';
import 'package:my_app/utils/login/loginbloc/login_state.dart';

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate();
  // FirebaseMessaging.onBackgroundMessage(_firebasemessagingBackgroundHandler);
  runApp(DevicePreview(
    builder: (BuildContext context) => MyApp(),
  ));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MyApp",
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print('you entered in listener....');
        print('user type is in lisner is $uType');
        print('user type is in lisner is $uId');
        print(state);

        if (state is UsernotLoginState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Choise()),
          );
        }

        if (state is UserLoginState) {
          getloginuserdata(uType, uId);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ForStudent(
                userid: uId,
                usertype: uType,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Image(image: AssetImage('assets/ldpr_logo.png')),
        ),
      ),
    );
  }
}
