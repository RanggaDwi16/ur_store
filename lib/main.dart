import 'package:dio/dio.dart';
import 'package:fake_store_app/common/bloc/auth/cubit/auth_cubit.dart';
import 'package:fake_store_app/core/configs/app_theme.dart';
import 'package:fake_store_app/routers/go_router.dart';
import 'package:fake_store_app/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  setupServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthStateCubit()..appStarted()),
      ],
      child: MaterialApp.router(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
