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
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (_) {
          if (controller.cashFlowList.hasError) {
            return Center(
              child: RaisedButton(
                onPressed: controller.getList(),
                child: Text('Ops...'),
              ),
            );
          }

          if (controller.cashFlowList == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<CashFlowModel> list = controller.cashFlowList.data;
          
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
            CashFlowModel model = list[index];
              return CheckboxListTile(
                title: Text(model.title),
                value: model.check,
                onChanged: (check) {
                  model.check = check;
                });
            },
        );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
}
