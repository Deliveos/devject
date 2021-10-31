import 'dart:io';
import 'package:devject/cubit/projects_cubit.dart';
import 'package:devject/cubit/responsible_cubit.dart';
import 'package:devject/models/project.dart';
import 'package:devject/models/user.dart';
import 'package:devject/services/api.dart';
import 'package:devject/utils/base64.dart';
import 'package:devject/utils/size.dart';
import 'package:devject/widgets/backdrop_filter_container.dart';
import 'package:devject/widgets/button.dart';
import 'package:devject/widgets/input_field.dart';
import 'package:devject/widgets/input_text_editing_controller.dart';
import 'package:devject/widgets/rounded_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({Key? key}) : super(key: key);

  static const routeName = "AddProjectPage";

  @override
  _AddProjectPageState createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final InputTextEditingController _nameController = InputTextEditingController();
  final InputTextEditingController _description = InputTextEditingController();
  final InputTextEditingController _startDateController = InputTextEditingController();
  final InputTextEditingController _endDateController = InputTextEditingController();
  final DateFormat dateFormat = DateFormat.yMMMMd(Platform.localeName);
  DateTimeRange? dateTimeRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: Text(
        AppLocalizations.of(context)!.newProject,
        style: Theme.of(context).textTheme.subtitle1,
      )),
      body: CustomScrollView(slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
              height: MediaQuery.of(context).size.height,
              padding:
                  EdgeInsets.symmetric(horizontal: AppSize.width(context, 20)),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.background,
                        Theme.of(context).colorScheme.onBackground
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: BlocBuilder<ResponsibleCubit, List<User>>(
                builder: (context, responsible) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              /*
                              * NAME FIELD
                              */
                              InputField(
                                controller: _nameController,
                                hintText: AppLocalizations.of(context)!.projectName,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!
                                      .fieldCanNotBeEmpty;
                                  }
                                }
                              ),
                              SizedBox(
                                height: ScreenSize.height(context, 3),
                              ),
                              /*
                              * DESCRIPTON FIELD
                              */
                              InputField(
                                  controller: _description,
                                  minLines: 1,
                                  maxLines: 8,
                                  hintText: AppLocalizations.of(context)!
                                      .description),
                              SizedBox(
                                height: ScreenSize.height(context, 3),
                              ),
                              /*
                              * DATES FIELDS
                              */
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    InputField(
                                        readOnly: true,
                                        width: ScreenSize.width(context, 40),
                                        controller: _startDateController,
                                        hintText: AppLocalizations.of(context)!
                                            .startDate,
                                        onTap: () async {
                                          await pickDateRange(context);
                                        }),
                                    Text("-",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    InputField(
                                        readOnly: true,
                                        width: ScreenSize.width(context, 40),
                                        controller: _endDateController,
                                        hintText: AppLocalizations.of(context)!
                                            .endDate,
                                        onTap: () async {
                                          await pickDateRange(context);
                                        }),
                                  ]),
                              SizedBox(
                                height: ScreenSize.height(context, 3),
                              ),
                              if(responsible.isNotEmpty)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: buildResponsible(context),),
                                ),
                              if(responsible.isNotEmpty)
                                SizedBox(
                                  height: ScreenSize.height(context, 3),
                                ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    color: Theme.of(context).inputDecorationTheme.fillColor!.withOpacity(0.5)),
                                child: TypeAheadField<User>(
                                    suggestionsCallback: API.searchUserByNickname,
                                    debounceDuration: const Duration(milliseconds: 500),
                                    // FIXME: Make normal loader
                                    loadingBuilder: (context) =>
                                        const Text("Loading..."),
                                    textFieldConfiguration: TextFieldConfiguration(
                                      cursorColor: Theme.of(context).primaryColor,
                                      style: Theme.of(context).textTheme.bodyText1,
                                      decoration: InputDecoration(
                                        hintText: "${AppLocalizations.of(context)!
                                        .responsible} (${AppLocalizations.of(context)!.nickname.toLowerCase()})",
                                        hintStyle: Theme.of(context).textTheme.bodyText1,
                                        border: InputBorder.none
                                      )
                                    ),
                                    noItemsFoundBuilder: (context) {
                                      return Center(
                                        child: Text(
                                          AppLocalizations.of(context)!.notFound,
                                          style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!
                                            .withOpacity(0.5)
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error) {
                                      return Container(height: 0);
                                    },
                                    itemBuilder: (context, User? user) {
                                      if (user != null) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: ScreenSize.width(context, 3), 
                                            vertical: ScreenSize.height(context, 1)
                                          ),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).backgroundColor
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              if (user.image != null) 
                                                RoundedImage(
                                                  image: imageFromBase64String(
                                                    user.image!,
                                                    height: ScreenSize.width(context, 15),
                                                    width: ScreenSize.width(context, 15),
                                                  )
                                                )
                                              else
                                                SvgPicture.asset(
                                                  "assets/images/avatar.svg", 
                                                  height: ScreenSize.width(context, 15),
                                                  width: ScreenSize.width(context, 15),
                                                ),
                                              SizedBox(width: ScreenSize.width(context, 3)),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(user.name, overflow: TextOverflow.clip,),
                                                  Text(user.nickname, style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.clip)
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return Container();
                                    },
                                    onSuggestionSelected: (User? selected) {
                                      bool isAdded = false;
                                      for (User resp in responsible) {
                                        if ( resp.id == selected!.id!) {
                                          isAdded = true;
                                        }
                                      }
                                      if (!isAdded) {
                                        responsible.add(selected!);
                                      }
                                    }),
                              ),
                              SizedBox(
                                height: ScreenSize.height(context, 3),
                              ),
                              /*
                              * CREATE NEW PROJECT BUTTON
                              */
                              PrimaryButton(
                                onTap: () async {
                                  Project project = Project(
                                    responsible: responsible,
                                    name: _nameController.text.trim(),
                                    startDate: dateTimeRange?.start,
                                    endDate: dateTimeRange?.end
                                  );
                                  await API.addProject(project);
                                  BlocProvider.of<ProjectsCubit>(context).add(project);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.create.toUpperCase(),
                                  style: Theme.of(context).textTheme.bodyText1
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30, 
                                  vertical: 5
                                ),
                              )
                            ]
                          )
                        ),
                        SizedBox(
                          height: ScreenSize.height(context, 3),
                        ),
                      ]
                    )
                  );
                },
              ))
        ]))
      ]),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
        start: dateTimeRange?.start ?? DateTime.now(),
        end: dateTimeRange?.end ??
            DateTime.now().add(const Duration(hours: 24 * 3)));
    final newDateRange = await showDateRangePicker(
        cancelText: AppLocalizations.of(context)!.done,
        builder: (context, Widget? child) => Theme(
          data: Theme.of(context).copyWith(
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: Theme.of(context).backgroundColor,
              iconTheme: Theme.of(context)
              .appBarTheme
              .iconTheme!
              .copyWith(color: Colors.white)
            ),
          ),
          child: child!,
        ),
        initialDateRange: dateTimeRange ?? initialDateRange,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10));
    if (newDateRange == null) return;
    setState(() {
      dateTimeRange = newDateRange;
      _startDateController.text = dateFormat.format(dateTimeRange!.start);
      _endDateController.text = dateFormat.format(dateTimeRange!.end);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        dateFormat.format(dateTimeRange!.start) +
            " - " +
            dateFormat.format(dateTimeRange!.end),
        style: Theme.of(context).textTheme.bodyText1,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      duration: const Duration(milliseconds: 2000)
    ));
  }

  List<Widget> buildResponsible(BuildContext context) {
    final responsibleCubit = BlocProvider.of<ResponsibleCubit>(context);
    final List<Widget> res = [];
    for (int i = 0; i < responsibleCubit.state.length; i++) {
      res.add(BackdropFilterContaiter(
        padding: EdgeInsets.all(ScreenSize.width(context, 5)),
          child: Column(
            children: [
              RoundedImage(
                image: responsibleCubit.state[i].image != null
                ? imageFromBase64String(
                  responsibleCubit.state[i].image!,
                  height: ScreenSize.width(context, 25),
                  width: ScreenSize.width(context, 25)
                )
                : SvgPicture.asset(
                  "assets/images/avatar.svg", 
                  height: ScreenSize.width(context, 25),
                  width: ScreenSize.width(context, 25)
                ),
              ),

              
              SizedBox(height: ScreenSize.height(context, 1)),
              Text(responsibleCubit.state[i].name),
              SizedBox(height: ScreenSize.height(context, 1)),
              Text(responsibleCubit.state[i].nickname, style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: ScreenSize.height(context, 1)),
              // Cancel button
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.width(context, 100)),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor
                    ),
                    child: Icon(FluentIcons.dismiss_24_regular, color: Theme.of(context).textTheme.bodyText1!.color,),
                  ),
                ),
                onTap: () {
                  responsibleCubit.remove(responsibleCubit.state[i].id!);
                },
              )
            ]
          )
        )
      );
      res.add(SizedBox(width: ScreenSize.width(context, 5)));
    }
    return res;
  }
}
