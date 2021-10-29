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

import 'login_page.dart';
import 'main_page.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = "RegisterPage";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final InputTextEditingController _nameController = InputTextEditingController();
  final InputTextEditingController _nicknameController = InputTextEditingController();
  final InputTextEditingController _emailController = InputTextEditingController();
  final InputTextEditingController _passwordController = InputTextEditingController();
  final InputTextEditingController _repeatPasswordController = InputTextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;
  bool isHiddenRepeatPassword = true;


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
                        Text(
                          AppLocalizations.of(context)!.signUp.toUpperCase(), 
                          style: Theme.of(context).textTheme.caption
                        ),
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
                              * NAME FIELD
                              */
                              InputField(
                                controller: _nameController,
                                hintText: AppLocalizations.of(context)!.name,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!.fieldCanNotBeEmpty;
                                  }
                                },
                              ),
                              SizedBox(
                                height: ScreenSize.height(context, 5),
                              ),
                              /*
                              * NICKNAME FIELD
                              */
                              InputField(
                                controller: _nicknameController,
                                hintText: AppLocalizations.of(context)!.nickname,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!.fieldCanNotBeEmpty;
                                  } else if (value.contains(" ") ) {
                                    return AppLocalizations.of(context)!.nicknameMustNotContainSpaces + ' ' + AppLocalizations.of(context)!.theFollowingCharactersAreAllowed;
                                  } else if(RegExp(r"[\{\}\[\]\(\)\'\<!?;,@#$%^&*>+=]").hasMatch(value)) {
                                    return AppLocalizations.of(context)!.usingAnInvalidCharacter + ' ' + AppLocalizations.of(context)!.theFollowingCharactersAreAllowed;
                                  }
                                  () async {
                                    if (await API.checkForUser(_nicknameController.text)) {
                                      return AppLocalizations.of(context)!.thisNicknameIsAlreadyUsed;
                                    }
                                  };
                                },
                              ),
                              SizedBox(
                                height: ScreenSize.height(context, 5),
                              ),
                              /*
                              * EMAIL FIELD
                              */
                              InputField(
                                controller: _emailController,
                                hintText: AppLocalizations.of(context)!.email,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!.fieldCanNotBeEmpty;
                                  } else if (value.contains(" ") ) {
                                    return AppLocalizations.of(context)!.nicknameMustNotContainSpaces + ' ' + AppLocalizations.of(context)!.theFollowingCharactersAreAllowed;
                                  } else if (!RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)").hasMatch(value)) {
                                    return AppLocalizations.of(context)!.emailIsNotCorrect;
                                  }
                                  () async {
                                    if (await API.checkForUser(_nicknameController.text)) {
                                      return AppLocalizations.of(context)!.thisNicknameIsAlreadyUsed;
                                    }
                                  };
                                },
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
                                  } else if (_passwordController.text.length < 8) {
                                    return AppLocalizations.of(context)!.minimumPasswordLength;
                                  } else if(RegExp(r"[\{\}\[\]\(\)\'\<!?;,@#$%^&*>+=]").hasMatch(value)) {
                                    return AppLocalizations.of(context)!.usingAnInvalidCharacter + ' ' + AppLocalizations.of(context)!.theFollowingCharactersAreAllowed;
                                  }
                                },
                              ),
                              SizedBox(
                                height: ScreenSize.height(context, 5),
                              ),
                              /*
                              * REPEAT PASSWORD FIELD
                              */
                              InputField(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isHiddenRepeatPassword = !isHiddenRepeatPassword;
                                    });
                                  },
                                  child: Icon(
                                    isHiddenRepeatPassword ?  Icons.visibility_off : Icons.visibility, 
                                    color: Theme.of(context).textTheme.bodyText1!.color,
                                    size: 20
                                  ),
                                ),
                                obscureText: isHiddenRepeatPassword,
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
                              SizedBox(
                                height: ScreenSize.height(context, 5),
                              ),
                              /*
                              * SIGN UP BUTTON
                              */
                              PrimaryButton(
                                onTap: () async {
                                  if(_nameController.isValid && 
                                  _nicknameController.isValid &&
                                  _emailController.isValid && 
                                  _passwordController.isValid && 
                                  _repeatPasswordController.isValid) {
                                    if(await API.signUp(
                                      _nameController.text.trim(), 
                                      _nicknameController.text.trim(),
                                      _emailController.text.trim(), 
                                      _passwordController.text.trim()) != null) {
                                      BlocProvider.of<UserCubit>(context).load();
                                      Navigator.pushAndRemoveUntil(
                                        context, 
                                        MaterialPageRoute(
                                          builder: (context) => const MainPage()
                                        ), 
                                        (route) => false
                                      );
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

