import 'package:flutter/material.dart';
class Constants{
  static String UrlBase1="http://198.72.112.52/Monetapi/";
  static String appName = "Foody Bite";
  static Color lightPrimary = Color(0xff5D1049);
  static Color darkPrimary = Color(0xff4F0A3c);

  static Color Button= Color(0xffE30425);
  static Color Button1= Color(0xffD4434B);




  //Gradiente

 // static Color Gra1= Color(0xffA0157C);
  static Color Gra1= Color(0xff6A1254);
  static Color Gra2= Color(0xff520D3F);
  static Color Gra3= Color(0xff551043);


  static LinearGradient gradiente = new LinearGradient(
  colors: [Constants.Gra1, Constants.Gra2, Constants.Gra3],
  stops: [0.3, 0.6, 0.9],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter);

  static double font_18=18;
  static double font_s=14;
  static double font_lis=14;
  static String no=appName==""?  "":"eee";

  //Colors for theme
  static Color barra= Colors.deepOrange;
  static Color Color_text_Botones= Colors.white;
  static Color Botones= Colors.orange;
  static double titulo_producto=16;

  static double sub_titulo_producto=14;

  static Color divisor_off = Colors.grey;
  static Color divisor_onn= Colors.green;


  // Carculadora

  static double font_number=18;
  static double elevacion_number=5;
  static Color color_number= Color(0xff000000);


  //Fuentes
  static double font_titulo=24;
  static double font_subTitulo=20;
  static double font_parrafo=16;



  //Modulo2.Inicio
  static double i_font_titulo=24;
  static double i_font_subTitulo=20;
  static double i_font_parrafo=16;
  static double i_icopn_size=20;
  static Color color_i_icopn =Color(0xff6A1254);
  static var s_titulo= TextStyle(
      fontSize: 17.0,
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static  var s_subtitulo= TextStyle(
      fontSize: 15.0,
      color: Colors.black87,
      fontWeight: FontWeight.w400);
//http://198.72.112.52/Monetapi
  static String uri="http://198.72.112.52/Monetapi/";
  //http://198.72.112.52:8080/api/Monedas/GetListMoneda

  static Widget cargando= Center(
    child: new CircularProgressIndicator(
      backgroundColor: Colors.deepPurple,
      valueColor:new AlwaysStoppedAnimation<Color>(Colors.white),
    ),
  );




  static cargas(){

    print("Cargando");
  }

}