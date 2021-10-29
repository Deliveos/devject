import 'package:devject/cubit/user_cubit.dart';
import 'package:devject/services/api.dart';
import 'package:devject/utils/size.dart';
import 'package:devject/widgets/backdrop_filter_container.dart';
import 'package:devject/widgets/button.dart';
import 'package:devject/widgets/input_field.dart';
import 'package:devject/widgets/input_text_editing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'main_page.dart';
import 'register_page.dart';

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
                        SizedBox(
                          height: ScreenSize.height(context, 5),
                        ),
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
                            SizedBox(
                              height: ScreenSize.height(context, 5),
                            ),
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
                            SizedBox(
                              height: ScreenSize.height(context, 5),
                            ),
                            /*
                            * SIGN IN BUTTON
                            */
                            PrimaryButton(
                              onTap: () async {
                                if(_nicknameOrEmailController.isValid && _passwordController.isValid) {
                                  if (RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)").hasMatch(_nicknameOrEmailController.text.trim())) {
                                    if (await API.signInByEmail(_nicknameOrEmailController.text.trim(), _passwordController.text.trim()) != null) {
                                      BlocProvider.of<UserCubit>(context).load();
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainPage()), (route) => false);
                                    }
                                  }
                                  if (!(RegExp(r"[\{\}\[\]\(\)\'\<!?;,@#$%^&*>+=]").hasMatch(_nicknameOrEmailController.text.trim()))) {
                                    if (await API.signInByNickname(_nicknameOrEmailController.text.trim(), _passwordController.text.trim()) != null) {
                                      BlocProvider.of<UserCubit>(context).load();
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainPage()), (route) => false);
                                    }
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
                        SizedBox(
                          height: ScreenSize.height(context, 5),
                        ),
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


