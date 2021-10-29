import 'package:devject/models/task.dart';
import 'package:devject/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({Key? key, required this.task}) : super(key: key);

  final Task task;

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
            onPressed: () {}, 
            child: Text(
              task.name, 
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                decoration: TextDecoration.underline
              )
            )
          ),
          Text(AppLocalizations.of(context)!.responsible+": ", style: Theme.of(context).textTheme.bodyText1,),
          ...buildResponsible(context, task.responsible)
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