import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Loads {
  BuildContext context;
  Loads(BuildContext context) {
    this.context = context;
  }

  ProgressDialog pr;

  void progressCarga(String mensaje) async {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
          message: mensaje,
        borderRadius: 5.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        insetAnimCurve: Curves.bounceIn,
        progressTextStyle:TextStyle(color: Colors.deepPurple) ,
        progress: 100.0,

        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600, )
    );
    pr.show();
  }

  cerrar() async {
     await pr.hide().then((isHidden) {
      pr.hide();
    });
  }

  toast(int color, String mensaje) {
    FlutterFlexibleToast.showToast(
        message: mensaje,
        toastLength: Toast.LENGTH_LONG,
        toastGravity: ToastGravity.CENTER,
        icon: color == 1 ? ICON.SUCCESS : ICON.CLOSE,
        //radius: 100,
        elevation: 10,
        textColor: Colors.white,
        backgroundColor: color == 1 ? Colors.green : Colors.red,
        timeInSeconds: 4);
  }
}
