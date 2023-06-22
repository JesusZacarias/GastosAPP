import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';

//  Buttom Sheet Numeric Keyboar
class BsNumKeyboard extends StatefulWidget {
  final CombinedModel cModel;
  const BsNumKeyboard({super.key, required this.cModel});

  @override
  State<BsNumKeyboard> createState() => _BsNumKeyboardState();
}

class _BsNumKeyboardState extends State<BsNumKeyboard> {
  String import = '0.00';

  @override
  void initState() {
    // TODO: implement initState
    import = widget.cModel.amount.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    

    String Function(Match) mathFunc;
    RegExp regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc = (Match match) => '${match[1]},';

    return GestureDetector(
      onTap: () {
        _numPad();
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text('Cantidad Ingresada'),
            Text(
              '\$ ${import.replaceAllMapped(regex, mathFunc)}',
              style: const TextStyle(
                fontSize: 30.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _numPad() {
    if (import == '0.00') import = '';

  _expensesChange(String amount) {
    if(amount == '') amount ='0.00';
    widget.cModel.amount = double.parse(amount);
  }

    _num(String _text, double _height) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            import += _text;
            widget.cModel.amount = double.parse(import);
          });
        },
        child: SizedBox(
          height: _height,
          child: Center(
            child: Text(
              _text,
              style: const TextStyle(fontSize: 35.0),
            ),
          ),
        ),
      );
    }

    showModalBottomSheet(
      //Evita que se cierre al hacer clicl fuera del BottomSheet
      isDismissible: false,

      //Evita el arrastrarlo hacia abajo y cerrarlo
      enableDrag: false,

      //Quita el limite de la altura
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          //En false Evita la funcion de regresar, por lo que 
          //el usuario se ve obligado a pulsar cancelar para regresar
          onWillPop: () async => false,
          child: SizedBox(
            height: 350.0,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constrains) {
                var _height = constrains.biggest.height / 5;
                return Column(
                  children: [
                    Table(
                      border: TableBorder.symmetric(
                        inside: const BorderSide(
                          width: 0.2,
                        ),
                      ),
                      children: [
                        TableRow(
                          children: [
                            _num('1', _height),
                            _num('2', _height),
                            _num('3', _height),
                          ],
                        ),
                        TableRow(
                          children: [
                            _num('4', _height),
                            _num('5', _height),
                            _num('6', _height),
                          ],
                        ),
                        TableRow(
                          children: [
                            _num('7', _height),
                            _num('8', _height),
                            _num('9', _height),
                          ],
                        ),
                        TableRow(
                          children: [
                            _num('.', _height),
                            _num('0', _height),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  if (import != null && import.length > 0.0) {
                                    import =
                                        import.substring(0, import.length - 1);
                                        _expensesChange(import);
                                  }
                                });
                              },
                              onLongPress: () {
                                setState(() {
                                  import = '';
                                  _expensesChange(import);
                                });
                              },
                              child: const SizedBox(
                                child: Icon(
                                  Icons.backspace,
                                  size: 35.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Constants.customButtom(
                              Colors.transparent,
                              Colors.red,
                              'Cancelar',
                            ),
                            onTap: () {
                              setState(() {
                                import = '0.00';
                                _expensesChange(import);
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Constants.customButtom(
                              Colors.transparent,
                              Colors.green,
                              'Aceptar',
                            ),
                            onTap: () {
                              setState(() {
                                if(import == 0.00) import = '0.00';
                                _expensesChange(import);
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
