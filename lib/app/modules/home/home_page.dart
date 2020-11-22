import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/modules/home/models/cash_flow_model.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.auth.user.email),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: controller.logoff,
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.blue[600],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _header(),
          Padding(padding: EdgeInsets.only(bottom: 32.0)),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Últimas transações',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          _sectionObserver(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushReplacementNamed('/createFlux'),
        child: Icon(Icons.add),
      ),
    );
  }

  _header() {
    return Container(
      width: double.infinity,
      height: 160,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
        color: Colors.blue[600],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Saldo Atual',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'R10.000,00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 46.0,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                ),
                iconSize: 36.0,
                onPressed: () => null,
              ),
            ],
          )
        ],
      ),
    );
  }

  _sectionObserver() {
    return Observer(
      builder: (_) {
        if (controller.cashFlowList.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<CashFlowModel> list = controller.cashFlowList.data;

        return Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
            CashFlowModel model = list[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 8.0,
                ),

                child: ListTile(
                  tileColor: Colors.grey[200],

                  leading: Container(
                    child: Icon(
                      model.type.toLowerCase() == 'entrada' ?
                      Icons.trending_up_sharp:
                      Icons.trending_down_sharp,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: model.type.toLowerCase() == 'entrada' ?
                        Colors.green : Colors.red,
                    ),
                  ),

                  title: Text(
                    model.description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),

                  trailing: Text(
                    r'R$ ' + model.value,
                    style: TextStyle(
                      color: model.type.toLowerCase() == 'entrada' ?
                        Colors.green : Colors.red,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  onTap: () {
                    Modular.to.pushReplacementNamed(
                      '/detailFlux',
                      arguments: index
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

}
