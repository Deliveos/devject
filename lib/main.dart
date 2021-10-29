import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'cubit/projects_cubit.dart';
import 'cubit/responsible_cubit.dart';
import 'cubit/user_cubit.dart';
import 'l10n/l10n.dart';
import 'models/project.dart';
import 'models/user.dart';
import 'pages/login_page.dart';
import 'pages/main_page.dart';
import 'routes.dart';
import 'themes/dark_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => ProjectsCubit()),
        BlocProvider(create: (context) => ResponsibleCubit()),
      ],
      child: BlocListener<UserCubit, User?>(
        listener: (context, state) async {
          if (state == null) BlocProvider.of<UserCubit>(context).load();
        },
        child: BlocListener<ProjectsCubit, List<Project>?>(
          listener: (context, state) {
            if (state == null) BlocProvider.of<ProjectsCubit>(context).load();
          },
          child: MaterialApp(
            title: 'Devject',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.dark,
            darkTheme: darkTheme,
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            home: BlocBuilder<UserCubit, User?>(
              builder: (context, state) {
                if (state is User) {
                  return BlocProvider.value(
                      value: BlocProvider.of<UserCubit>(context),
                      child: const MainPage());
                } else {
                  BlocProvider.of<UserCubit>(context).load();
                  return const LoginPage();
                }
              },
            ),
            routes: routes,
          ),
        )
      ),
    );
  }
}
