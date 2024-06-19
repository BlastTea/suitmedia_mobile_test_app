import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_mobile_test_app/blocs/blocs.dart';
import 'package:suitmedia_mobile_test_app/utils/utils.dart';
import 'package:suitmedia_mobile_test_app/views/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final FirstBloc firstBloc = FirstBloc();
  static final SecondBloc secondBloc = SecondBloc();

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => firstBloc),
          BlocProvider(create: (context) => secondBloc),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2B637B)),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
            scaffoldBackgroundColor: Colors.white,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Color(0xFFE2E3E4)),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 16.0),
              hintStyle: TextStyle(color: Color(0x6867775C)),
              fillColor: Colors.white,
              filled: true,
            ),
            filledButtonTheme: const FilledButtonThemeData(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          home: const FirstPage(),
        ),
      );
}
