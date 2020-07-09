import 'package:flutter/material.dart';
import 'package:moneto2/utils/Const.dart';


class Drawer_admin extends StatefulWidget {
  final BuildContext  title;

  Drawer_admin(this.title );

  @override
  State<StatefulWidget> createState() => new _Drawer_repartidorState();
}

class _Drawer_repartidorState extends State<Drawer_admin> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.

      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,


        children: <Widget>[
         /*  Container(
            height: MediaQuery.of(context).size.height/2.7,
            width: MediaQuery.of(context).size.width,
           margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: Constants.darkPrimary,
                image: DecorationImage(image: AssetImage("assets/Logo.png"),fit: BoxFit.fill )),
          ), */

         /*  Column(
            children: <Widget>[
              MaterialButton(
                //minWidth: MediaQuery.of(context).size.width,
                height: 40.0,
                onPressed: () {

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Usuario_Libros()));
                },
                //color: Constants.Button,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Política de privacidad',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              MaterialButton(
                //minWidth: MediaQuery.of(context).size.width,
                height: 40.0,
                onPressed: () {
                  Navigator.pop(context);

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Usuario_Libros()));
                },
                //color: Constants.Button,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cerrar sesión',

                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),


            ],
          ),
 */
        ],
      ),
elevation: 20,

    );
  }
}
