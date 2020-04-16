import 'package:flutter/material.dart';
import 'package:moneto2/models/moneda.dart';
import 'package:moneto2/models/user.dart';
import 'package:moneto2/vistas/moneda/servicio.dart';

class ListMoneda extends StatefulWidget {
  User data_user;
  ListMoneda(this.data_user);

  @override
  _ListMonedaState createState() => _ListMonedaState();
}

class _ListMonedaState extends State<ListMoneda> with WidgetsBindingObserver {
  ServicioMoneda apiService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(
                future: apiService.getMonedas(widget.data_user.Token),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  return Container(
                    height: 200.0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                })));
  }

  Widget _buildListView(List<Moneda> profiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Moneda profile = profiles[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*      Text(
                      profile.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(profile.email),
                    Text(profile.age.toString()), */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            // TODO: do something in here
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            // TODO: do something in here
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: profiles.length,
      ),
    );
  }
}
