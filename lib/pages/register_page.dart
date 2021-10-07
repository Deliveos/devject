import 'package:flutter/material.dart';
import 'package:projetex/constants/colors.dart';
import 'package:projetex/pages/login_page.dart';
import 'package:projetex/pages/main_page.dart';
import 'package:projetex/services/projetex_api.dart';
import 'package:projetex/utils/size.dart';
import 'package:projetex/widgets/backdrop_filter_container.dart';
import 'package:projetex/widgets/button.dart';
import 'package:projetex/widgets/default_sizedbox.dart';
import 'package:projetex/widgets/input_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = "RegisterPage";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: CustomScrollView(
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
                child: Center(
                  child: BackdropFilterContaiter(
                    margin: EdgeInsets.all(AppSize.width(context, 20)),
                    padding: EdgeInsets.all(AppSize.width(context, 20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(AppLocalizations.of(context)!.signUp.toUpperCase(), style: Theme.of(context).textTheme.caption),
                        const HeightSizedBox(20),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                          children:  <Widget>[
                            InputField(
                              controller: _nameController,
                              hintText: AppLocalizations.of(context)!.name,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.fieldCanNotBeEmpty;
                                }
                              },
                            ),
                            const HeightSizedBox(20),
                            InputField(
                              controller: _nicknameController,
                              hintText: AppLocalizations.of(context)!.nickname,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.fieldCanNotBeEmpty;
                                }
                                () async {
                                  if (await ProjetexApi.checkForUser(_nicknameController.text)) {
                                    return AppLocalizations.of(context)!.thisNicknameIsAlreadyUsed;
                                  }
                                };
                              },
                            ),
                            const HeightSizedBox(20),
                            InputField(
                              controller: _passwordController,
                              hintText: AppLocalizations.of(context)!.password,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.fieldCanNotBeEmpty;
                                }
                              },
                            ),
                            const HeightSizedBox(20),
                            InputField(
                              controller: _repeatPasswordController,
                              hintText: AppLocalizations.of(context)!.repeatPassword,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.fieldCanNotBeEmpty;
                                } else if (value != _passwordController.text) {
                                  return AppLocalizations.of(context)!.passwordMismatch;
                                }
                              },
                            ),
                            const HeightSizedBox(20),
                            PrimaryButton(
                              onTap: () async {
                                if(_formKey.currentState!.validate()) {
                                  await ProjetexApi.signUp(_nameController.text.trim(), _nicknameController.text.trim(), _passwordController.text.trim());
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  if (prefs.getString("token") != null) {
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainPage()), (route) => false);
                                  }
                                }
                              },
                              child: Text(AppLocalizations.of(context)!.signIn.toUpperCase(), style: Theme.of(context).textTheme.bodyText1,),
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                            )
                          ]
                          )
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const HeightSizedBox(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)!.alreadyThereIsAnAccount, 
                              style: Theme.of(context).textTheme.bodyText1
                            ),
                            TextButton(
                              style: const ButtonStyle(
                                enableFeedback: false,
                              ),
                              onPressed: ()  => Navigator.pushAndRemoveUntil(
                                context, 
                                MaterialPageRoute(builder: (context) => const LoginPage()), 
                                (route) => false
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.signIn, 
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  decoration: TextDecoration.underline
                                )
                              )
                            )
                          ]
                        ) 
                      ]
                    )
                  )
                )
              )
            ])
          )
        ]
      )
    );
  }
}

