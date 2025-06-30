import 'dart:io';

import 'package:flutter/material.dart';
import 'package:clinica_veterinaria/screens/android/appclinica.dart';

void main(){

  if(Platform.isAndroid){
    runApp(AppClinica());
  }
  if(Platform.isIOS){
    debugPrint('app no IOS');
  }

}