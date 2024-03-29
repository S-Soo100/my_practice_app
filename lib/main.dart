import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_practice_app/firebase_options.dart';
import 'package:my_practice_app/initial_binding.dart';
import 'package:my_practice_app/provider/shopping_cart_provider.dart';
import 'package:my_practice_app/screen/firebase/chatting_page.dart';
import 'package:my_practice_app/screen/firebase/auth_page.dart';
import 'package:my_practice_app/screen/firebase/google_login_page.dart';
import 'package:my_practice_app/screen/flutter_basic/animation_practice.dart';
import 'package:my_practice_app/screen/flutter_basic/flutter_basic_page.dart';
import 'package:my_practice_app/screen/hive/hive_page.dart';
import 'package:my_practice_app/screen/provider/counter_provider_practice.dart';
import 'package:my_practice_app/provider/counter_provider.dart';
import 'package:my_practice_app/screen/http/http_clone_coding.dart';
import 'package:my_practice_app/screen/http/dio_sign_up.dart';
import 'package:my_practice_app/screen/http/dio_test.dart';
import 'package:my_practice_app/screen/http/http_weather_loading_screen.dart';
import 'package:my_practice_app/screen/http/http_weather_ui_screen.dart';
import 'package:my_practice_app/screen/provider/no_provider.dart';
import 'package:my_practice_app/screen/provider/shopping_cart_provider_home.dart';
import 'package:my_practice_app/screen/singleton/get_singleton_screen.dart';
import 'package:my_practice_app/screen/singleton/set_singleton_screen.dart';
import 'package:my_practice_app/screen/skeleton_loading_practice.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
//fcm libraries
import 'package:firebase_messaging/firebase_messaging.dart';
//fcm controller
import 'package:my_practice_app/controller/app_controller.dart';

import 'screen/toss_payment/toss_payment_test.dart';

//내부 디바이스 저장소 사용
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('testBox'); //Open Box
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: "my_practice_app",
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() => print("complete!! thx"));
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
      ChangeNotifierProvider(create: (_) => ShoppingCart()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: InitialBinding(),
        debugShowCheckedModeBanner: false,
        title: 'my practice app',
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(),
          primaryTextTheme: GoogleFonts.openSansTextTheme().copyWith(
            headline6: const TextStyle(
              color: Colors.white,
            ),
          ),
          primarySwatch: Colors.green,
        ),
        initialRoute: 'home',
        routes: {
          'home': (context) => const MyHomePage(),
          'providerHome': (context) => const ProviderHome(),
          'noProviderHome': (context) => const NoProviderHome(),
          'shoppingCartProviderHome': (context) => ShoppingCartProviderHome(),
          'dioSignUpHome': (context) => const DioSignUpHome(),
          'dioTest': (context) => DioTest(),
          'httpCloneCoding': (context) => const HttpCloneCoding(),
          'httpWeatherLoadingScreenRouteName': (context) =>
              const HttpWeatherLoadingScreen(),
          'httpWeatherUiScreenRouteName': (context) =>
              const HttpWeatherUiScreen(),
          'skeletonLoadingPractice': (context) =>
              const SkeletonLoadingPractice(),
          'authPage': (context) => const AuthPage(),
          'googleLoginPage': (context) => const GoogleLoginPage(),
          'chattingPage': (context) => const ChattingPage(),
          'flutterBasic': (context) => const FlutterBasicPage(),
          'animationPractice': (context) => const AnimationPracticePage(),
          'getSingletonScreen': (context) => const GetSingletonScreen(),
          'setSingletonScreen': (context) => const SetSingletonScreen(),
          'tossPaymentTestRouteName': (context) => const TossPaymetTestScreen(),
          'hivePageRouteName': (context) => const HivePage(),
        });
  }
}
