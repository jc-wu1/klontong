import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/injector.dart';
import 'src/core/routes/app_router.dart';
import 'src/features/authentication/bloc/authentication_cubit.dart';

class KlontongApp extends StatelessWidget {
  const KlontongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(
        usecases: sl(),
      )..checkAuth(),
      child: const KlontongAppView(),
    );
  }
}

class KlontongAppView extends StatelessWidget {
  const KlontongAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        router.refresh();
      },
      child: MaterialApp.router(
        title: 'Klontong Mobile Apps',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
