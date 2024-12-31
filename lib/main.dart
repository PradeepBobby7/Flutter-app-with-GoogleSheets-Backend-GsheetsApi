import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsheet_app/bloc/auth_bloc.dart';
import 'package:gsheet_app/bloc/product_bloc.dart';
import 'package:gsheet_app/google_sheet/gsheet_setup.dart';
import 'package:gsheet_app/repository/gsheet_repository.dart';
import 'package:gsheet_app/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGSheets();

  final googleSheetRepository = GoogleSheetRepository();
  runApp(MyApp(googleSheetRepository: googleSheetRepository));

  // runApp(
  //   MultiBlocProvider(
  //     providers: [
  //       BlocProvider(create: (_) => AuthBloc(googleSheetRepository)),
  //       BlocProvider(create: (_) => ProductBloc(googleSheetRepository)),
  //     ],
  //     child: MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  final GoogleSheetRepository googleSheetRepository;
  MyApp({required this.googleSheetRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(googleSheetRepository),
        ),
        BlocProvider(
          create: (_) => ProductBloc(googleSheetRepository),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Google Sheet App',
        home: LoginScreen(),
      ),
    );
  }
}
