import 'package:flutter/material.dart';

import '../colors.dart';

class BackButtonWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onPress;
  const BackButtonWidget({super.key, required this.child, required this.onPress});

  @override
  State<BackButtonWidget> createState() => _BackButtonWidgetState();
}

class _BackButtonWidgetState extends State<BackButtonWidget> {
  var isPress = false;

  void setChange(bool turn){
    setState(() {
      isPress = turn;
    });
    if(!turn) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onPress();
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (position){

        setChange(true);

      },
      onTapUp: (position){
        setChange(false);
      },
      onTapCancel: (){
        if(isPress){
          setChange(false);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isPress? Colors.yellow: MyColors.borderButtonColor, ),
            color: isPress?const Color(0xf9151E40):  const Color(0x16151E40)
        ),
        child: widget.child,
      ),
    );
  }
}
