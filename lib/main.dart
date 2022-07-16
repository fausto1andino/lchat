import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lchat_rp/src/page/chat_page.dart';
import 'package:lchat_rp/src/page/login_page.dart';
import 'package:lchat_rp/src/provider/main_provider.dart';
import 'package:lchat_rp/src/theme/theme_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return FutureBuilder<bool>(
        future: mainProvider.getPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: AppTheme.themeData(mainProvider.mode).copyWith(
                      pageTransitionsTheme: const PageTransitionsTheme(
                    builders: <TargetPlatform, PageTransitionsBuilder>{
                      TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    },
                  )),
                  home: mainProvider.token == ""
                      ? const LoginPage()
                      : ChatPage(
                          token: mainProvider.token,
                        ));
            } catch (e) {
              //print(e)
            }
          }
          return const SizedBox.square(
              dimension: 100.0, child: CircularProgressIndicator());
        });
  }
}
