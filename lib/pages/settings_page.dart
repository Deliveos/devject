import 'package:flutter/material.dart';
import 'package:projetex/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:projetex/pages/login_page.dart';
import 'package:projetex/services/projetex_api.dart';
import 'package:projetex/utils/size.dart';
import 'package:projetex/widgets/default_sizedbox.dart';


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
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kBackgroundLightColor,
                        kBackgroundDarkColor
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                    )
                  ),
                  child: Column(
                    children: [
                      const HeightSizedBox(80),
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
                          await ProjetexApi.logout();
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