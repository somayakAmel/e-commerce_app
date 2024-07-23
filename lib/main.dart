import 'package:e_commerce/features/user_management/view/screens/login.dart';
import 'package:e_commerce/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/user_management/view_model/auth_cubits/login/login_cubit.dart';
import 'features/user_management/view_model/auth_cubits/register/register_cubit.dart';
import 'firebase_options.dart';
import 'utils/bloc_observer.dart';
import 'utils/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(create: (context) => RegisterCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: CacheHelper.getData(key: 'uId') == null
            ? AppRoutes.login
            : AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
