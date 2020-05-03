import 'dart:ui';

import 'package:flutter/widgets.dart';

class CustomDecorationImage{

  final String _imagePath = "assets/wall-background.jpg";

  Container bluredImageContainer(Widget childWidget){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_imagePath),
          fit: BoxFit.cover
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.75, sigmaY: 1.75),
        child: childWidget
      ,),
    );
  
  }

}