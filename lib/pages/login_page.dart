import 'package:flutter/material.dart';
import 'package:projetex/constants/colors.dart';
import 'package:projetex/utils/size.dart';
import 'package:projetex/widgets/backdrop_filter_container.dart';
import 'package:projetex/widgets/button.dart';
import 'package:projetex/widgets/default_sizedbox.dart';
import 'package:projetex/widgets/input_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        children: [Container(
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
          child: Center(
            child: BackdropFilterContaiter(
              margin: EdgeInsets.all(AppSize.width(context, 20)),
              padding: EdgeInsets.all(AppSize.width(context, 20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.signIn.toUpperCase(), style: Theme.of(context).textTheme.caption),
                  const DefaultSizedBox(),
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                    children:  <Widget>[
                      InputField(hintText: AppLocalizations.of(context)!.email),
                      const DefaultSizedBox(),
                      InputField(hintText: AppLocalizations.of(context)!.password),
                      const DefaultSizedBox(),
                      PrimaryButton(
                        onTap: () {},
                        child: Text(AppLocalizations.of(context)!.signIn.toUpperCase(), style: Theme.of(context).textTheme.bodyText1,),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      )
                    ]
                    )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(AppLocalizations.of(context)!.signInWith.toLowerCase(), style: Theme.of(context).textTheme.bodyText1,),
                  TextButton(onPressed: () {}, child: const Text("Google")),
                  const DefaultSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(AppLocalizations.of(context)!.doNotHaveAnAccount, style: Theme.of(context).textTheme.bodyText1,),
                      TextButton(
                        style: const ButtonStyle(
                          enableFeedback: false,
                        ),
                        onPressed: ()  {}, 
                        child: Text(AppLocalizations.of(context)!.signUp, style: Theme.of(context).textTheme.bodyText2!.copyWith(decoration: TextDecoration.underline,)) , )
                    ]
                  ) 
                ],
              )
            ),
          )
        )],
      )
    );
  }
}