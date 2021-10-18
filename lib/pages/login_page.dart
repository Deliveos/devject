import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projetex/constants/colors.dart';
import 'package:projetex/cubit/user_cubit.dart';
import 'package:projetex/pages/register_page.dart';
import 'package:projetex/services/projetex_api.dart';
import 'package:projetex/utils/size.dart';
import 'package:projetex/widgets/backdrop_filter_container.dart';
import 'package:projetex/widgets/button.dart';
import 'package:projetex/widgets/default_sizedbox.dart';
import 'package:projetex/widgets/input_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:projetex/widgets/input_text_editing_controller.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = "LoginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final InputTextEditingController _nicknameOrEmailController = InputTextEditingController();
  final InputTextEditingController _passwordController = InputTextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;

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
                        Text(AppLocalizations.of(context)!.signIn.toUpperCase(), style: Theme.of(context).textTheme.caption),
                        const HeightSizedBox(20),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                          children:  <Widget>[
                            /*
                            * NICKNAME OR EMAIL FIELD
                            */
                            InputField(
                              controller: _nicknameOrEmailController,
                              hintText: AppLocalizations.of(context)!.nicknameOrEmail,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.fieldCanNotBeEmpty;
                                }   
                              }
                            ),
                            const HeightSizedBox(20),
                            /*
                            * PASSWORD FIELD
                            */
                            InputField(
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isHiddenPassword = !isHiddenPassword;
                                  });
                                },
                                child: Icon(
                                  isHiddenPassword ?  Icons.visibility_off : Icons.visibility, 
                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                  size: 20
                                ),
                              ),
                              obscureText: isHiddenPassword,
                              controller: _passwordController,
                              hintText: AppLocalizations.of(context)!.password,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!.fieldCanNotBeEmpty;
                                }   
                              }
                            ),
                            const HeightSizedBox(20),
                            /*
                            * SIGN IN BUTTON
                            */
                            PrimaryButton(
                              onTap: () async {
                                if(_formKey.currentState!.validate()) {
                                  if (await ProjetexApi.signIn(_nicknameOrEmailController.text.trim(), _passwordController.text.trim()) != null) {
                                    BlocProvider.of<UserCubit>(context).load();
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainPage()), (route) => false);
                                  }
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.signIn.toUpperCase(), 
                                style: Theme.of(context).textTheme.bodyText1
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                            )
                          ]
                          )
                        ),
                        const HeightSizedBox(20),
                        /*
                        * SIGN IN LINK
                        */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(AppLocalizations.of(context)!.doNotHaveAnAccount, style: Theme.of(context).textTheme.bodyText1,),
                            TextButton(
                              style: const ButtonStyle(
                                enableFeedback: false,
                              ),
                              onPressed: ()  => Navigator.pushAndRemoveUntil(
                                context, 
                                MaterialPageRoute(builder: (context) => 
                                  BlocProvider.value(
                                    value: BlocProvider.of<UserCubit>(context),
                                    child: const RegisterPage(),
                                  )
                                ), 
                                (route) => false
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.signUp, 
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


