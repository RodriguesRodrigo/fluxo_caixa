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
        leading: IconButton(
          icon: Icon(Icons.highlight_off),
          onPressed: controller.logoff,
        ),
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
              return ListTile(
                title: Text(model.title),
                onTap: () {
                  _showDialog(model);
                },
                leading: IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  onPressed: model.delete,
                ),
                trailing: Checkbox(
                  value: model.check,
                  onChanged: (check) {
                    model.check = check;
                    model.save();
                  },
                ),
              );
            },
        );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog([CashFlowModel model]) {
    model ??= CashFlowModel();
    
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(model.title.isEmpty ? 'Adicionar' : 'Atualizar'),
          content: TextFormField(
            initialValue: model.title,
            onChanged: (value) => model.title = value,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Preencha o campo',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () async {
                await model.save();
                Modular.to.pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      }
    );
  }

}
