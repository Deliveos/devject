import 'package:devject/models/project.dart';
import 'package:devject/models/user.dart';
import 'package:devject/pages/project_page.dart';
import 'package:devject/utils/size.dart';
import 'package:flutter/material.dart';
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
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            style: const ButtonStyle(
              enableFeedback: false,
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectPage(project: project))), 
            child: Text(
              project.name, 
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                decoration: TextDecoration.underline
              )
            )
          ),
          Text(
            AppLocalizations.of(context)!.responsible+": ", 
            style: Theme.of(context).textTheme.bodyText1,
          ),
          ...buildResponsible(context, project.responsible),
          if(project.startDate != null && project.endDate != null)
            Text(
              AppLocalizations.of(context)!.start + ": " 
              + project.startDate.toString()
            )
          else
            Text(
              AppLocalizations.of(context)!.timeToExecute + ": " +
              AppLocalizations.of(context)!.indefinite.toLowerCase(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          SizedBox(height: ScreenSize.height(context, 1)),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    value: project.progress.toDouble() / 100,
                    backgroundColor: Theme.of(context).inputDecorationTheme.fillColor!.withOpacity(0.5),
                    valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  ),
                ),
              ),
              SizedBox(width: ScreenSize.width(context, 2)),
              Text(
                project.progress.toString() + "%",
                style: Theme.of(context).textTheme.bodyText1
              )
            ],
          )
        ]
      ),
    );
  }

  List<Widget> buildResponsible(BuildContext context, List<User> responsible) =>
    responsible.map((e) => Row(
      children: [
        TextButton(
          style: const ButtonStyle(
            enableFeedback: false,
          ),
          onPressed: () {}, child: Text(e.name, style: Theme.of(context).textTheme.bodyText2!.copyWith(decoration: TextDecoration.underline),)),
        e == responsible.last 
          ? const Text("")
          : const Text(",")
      ],
    )).toList();
}