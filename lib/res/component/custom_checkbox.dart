import 'package:flutter/material.dart';
import 'package:rs_wallpaper/res/colors.dart';


class CustomCheckBox extends StatefulWidget {
  final bool isChecked, hasEnable;
  final Function(bool)? onChanged;
  final String? title, extension;
  const CustomCheckBox({super.key, this.isChecked =false, this.hasEnable=false,  this.onChanged, this.title, this.extension});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  void didUpdateWidget(covariant CustomCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isChecked != isChecked) {
      // Update the state if the parent state has changed
      isChecked = widget.isChecked;
    }
  }

  @override
  Widget build(BuildContext context) {
     return widget.title!=null ? _getTitleCheckbox(): _getCheckBox();
  }

  Widget _getTitleCheckbox(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _getCheckBox(),
        SizedBox(width: 7,),
        Text('${widget.title}', style: TextStyle(color: isChecked? Colors.lightGreen: MyColors.activeTextColor, fontSize: 14),),
        if(widget.extension!=null)
          SizedBox(width: 2),
        if(widget.extension!=null)
        Text('(${widget.extension})', style: TextStyle(color:  MyColors.activeTextColor, fontSize: 14),),
      ],
    );
  }

  Widget _getCheckBox(){
    return SizedBox(
      height: 26,
      width: 26,
      child: Checkbox(
        checkColor: Colors.white,
        value: isChecked,
        activeColor: Colors.lightGreen,
        side: const BorderSide(color: MyColors.activeTextColor),
        onChanged: (bool? value) {
          if(!widget.hasEnable){
            return;
          }
          setState(() {
            isChecked = value!;
          });
          widget.onChanged!=null && value!=null ? widget.onChanged!(value!): null;
        },
      ),
    );
  }
}