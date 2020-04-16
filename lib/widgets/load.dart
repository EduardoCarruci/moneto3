import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Loads {
  BuildContext context;
  Loads(BuildContext context  ) {
    this.context = context;
  }


  ProgressDialog pr ;

  Carga(String Mensage ) async {
    pr = new ProgressDialog( context ,type: ProgressDialogType.Normal, isDismissible: true , showLogs: true );
    pr.style(
        message: Mensage,
        borderRadius: 5.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        insetAnimCurve: Curves.bounceIn,
        progressTextStyle:TextStyle(color: Colors.deepPurple) ,
        progress: 100.0,

        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600, )
    );
    await pr.show();
  }

  cerrar()
  {
    pr.hide().then((isHidden) {
      print(isHidden);
    });
  }

  //Parametros
  //Color= 1 es para un mensaje de exito
  //Color= 2 es para un mensaje de  error
  // Mensaje:  depende del caso
  Toast_Resull(int Color,String Mensage )
  {
    FlutterFlexibleToast.showToast(
        message:Mensage,
        toastLength: Toast.LENGTH_LONG,
        toastGravity: ToastGravity.CENTER,
        icon:Color==1? ICON.SUCCESS:ICON.CLOSE,
        //radius: 100,
        elevation: 10,
        textColor: Colors.white,
        backgroundColor:Color==1? Colors.green:Colors.red,

        timeInSeconds: 4
    );
  }


}