import 'package:Lekhone/routes.dart';
import 'package:Lekhone/screens/Splashscreen/splash_screen.dart';
import 'package:Lekhone/screens/theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //it requires 3 parameters
    //context, orientation, device
    //it always requires, see plugin documentation
    return Sizer(builder: (context, orientation, device) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lekhone',
        theme: CustomTheme().baseTheme,
        //initial route is splash screen
        //mean first screen
        initialRoute: SplashScreen.routeName,
        //define the routes file here in order to access the routes any where all over the app
        routes: routes,
      );
    });
  }
}
