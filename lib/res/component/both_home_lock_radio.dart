import 'package:flutter/material.dart';
import 'package:rs_wallpaper/res/component/custom_checkbox.dart';
import 'package:rs_wallpaper/res/utils/utils.dart';

class BothHomeLockDesign extends StatefulWidget {
  final Function(bool, bool) feedBack;
  final bool home, lock;
  const BothHomeLockDesign({super.key, required this.feedBack,required this.home,required this.lock});

  @override
  State<BothHomeLockDesign> createState() => _BothHomeLockDesignState();
}

class _BothHomeLockDesignState extends State<BothHomeLockDesign> {
  bool both = false, home =true, lock =false;

  void bothselect(hasBoth){
    lock = false;
    if(hasBoth){
      lock = true;
    }
     home = true;
     both = hasBoth; // Update both variable
     setState(() {

     });
     widget.feedBack(home, lock);
  }
  void homeselect(bool hasHome){
     lock = !hasHome;
     home = hasHome;
     both = false; // Update both variable
     setState(() {

     });
     widget.feedBack(home, lock);

  }

  @override
  void initState() {
    // TODO: implement initState
    if(widget.home&& widget.lock){
      bothselect(true);
    }else if(widget.lock){
       homeselect(false);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomCheckBox(title: 'Both', hasEnable: true, onChanged: (value){

          bothselect(value);
        }, isChecked: both,),
        CustomCheckBox(title: 'Home ', hasEnable: true,onChanged: (value){
          homeselect(value);
        }, isChecked: home,),
        CustomCheckBox(title: 'Lock ', hasEnable: true, onChanged: (value){
          homeselect(!value);

        }, isChecked: lock),

      ],
    );
  }
}
