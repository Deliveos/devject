import 'package:devject/services/api.dart';
import 'package:devject/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_page.dart';



class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.background,
                        Theme.of(context).colorScheme.onBackground
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                    )
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: ScreenSize.height(context, 10),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(Size(ScreenSize.width(context, 90), ScreenSize.width(context, 10))),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(
                            horizontal: AppSize.width(context, 10), 
                            vertical: AppSize.width(context, 10)
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                          side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: Colors.red, width: 1))
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.logout.toUpperCase(), 
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red)
                        ),
                        onPressed: () async {
                          await API.logout();
                          Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
                        },
                      )
                    ]
                  )
                )
              ])
            )
          ]
        )
      )
    );
  }
}