import 'package:flutter/material.dart';
import 'package:smart_home/core/util/app_colors.dart';

class FormTextWithItsValue extends StatefulWidget {
  final Widget? action;
  final String stateOrValue;
    final String title;
    final IconData iconOfLeading;
  //  final String? subtitle;
   final BuildContext context;
  const FormTextWithItsValue({super.key, required this.stateOrValue,
  required this.title,required this.iconOfLeading, required this.context, this.action,});

  @override
  State<FormTextWithItsValue> createState() => _FormTextWithItsValueState();
}

class _FormTextWithItsValueState extends State<FormTextWithItsValue> {
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    final isLandscape =MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      margin: const EdgeInsets.all(10),
      width: size.width * 0.9,
      height: size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.grey2,
      ),
      child: Center(
        child: ListTile(

          subtitle: widget.action,
          
          // title: is used to show the title of the list tile
          title: Text(widget.title,style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontSize: 20
          ),),
          // leading: is used to show the leading icon of the list tile
          leading: Icon(
            widget.iconOfLeading,
            size: isLandscape ? size.height * 0.05 : size.height * 0.035,
            color: 
            AppColors.blue,
          ),
          // subtitle: is used to show the subtitle of the list tile
          // subtitle: Text(widget.subtitle,style: Theme.of(context).textTheme.headlineSmall,),
          // trailing: is used to show the trailing icon of the list tile
          trailing: Text(widget.stateOrValue,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold ),),
          onTap: () {},
        ),
      ),
    );
  }
}