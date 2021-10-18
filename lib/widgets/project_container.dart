import 'package:flutter/material.dart';
import 'package:projetex/constants/colors.dart';
import 'package:projetex/models/project.dart';
import 'package:projetex/utils/size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectContainer extends StatelessWidget {
  const ProjectContainer(this.project, {Key? key}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSize.height(context, 10)),
      padding: EdgeInsets.all(AppSize.width(context, 20)),
      decoration: BoxDecoration(
        color: kBackgroundLightColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            style: const ButtonStyle(
              enableFeedback: false,
            ),
            onPressed: () {}, 
            child: Text(
              project.name, 
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                decoration: TextDecoration.underline
              )
            )
          ),
          Text(AppLocalizations.of(context)!.responsible+": ", style: Theme.of(context).textTheme.bodyText1,),
          ...buildResponsible(context, project.responsible)
        ]
      ),
    );
  }

  List<Widget> buildResponsible(BuildContext context, List responsible) =>
    responsible.map((e) => Row(
      children: [
        TextButton(
          style: const ButtonStyle(
            enableFeedback: false,
          ),
          onPressed: () {}, child: Text(e, style: Theme.of(context).textTheme.bodyText2!.copyWith(decoration: TextDecoration.underline),)),
        e == responsible.last 
          ? const Text("")
          : const Text(",")
      ],
    )).toList();
}