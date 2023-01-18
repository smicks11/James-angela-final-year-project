import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safespace/view-model/fetch_data_vm.dart';
import 'package:safespace/view/auth/sign_in.dart';
import 'package:safespace/view/home/home.dart';
import 'package:safespace/view/splash.dart';

import 'core/prefs.dart';
import 'view/resources/routes_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await UserPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
    final _userPrefs = UserPreferences();
    final _fetchData = FetchData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => _userPrefs),
        ChangeNotifierProvider(create: (ctx) => _fetchData),
      ],
      child: ScreenUtilInit(builder: (context, child) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
                .copyWith(boldText: false, textScaleFactor: 1.0),
            child: MaterialApp(
              useInheritedMediaQuery: true,
              title: 'Safe Space',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'Gilroy',
                // textTheme: GoogleFonts.carmeTextTheme(

                // )
              ),
              debugShowCheckedModeBanner: false,
              // initialRoute: Routes.splashRoute,
              home: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      return const SplashScreen(nextScreen: SignInScreen());
                    } else {
                      return const SplashScreen(nextScreen: SignInScreen());
                    }
                  }),
              onGenerateRoute: RouteGenerator.getRoute,
            ),
          );
        });
      }),
    );
  }
}
