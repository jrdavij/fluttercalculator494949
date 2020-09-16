import 'package:flutter/material.dart';

int indexColor = 2;

void main() {
  runApp(MyApp());
}

class SquareButton extends StatelessWidget {
  const SquareButton({
    this.child,
    this.size,
    this.onPressed,
  });
  final Widget child;
  final double size;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        child: RaisedButton(
          color: Cores.Weak[indexColor],
          onPressed: onPressed,
          child: child,
        )
    );
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String stored = "";
  String display = "0";
  String operator = "";
  bool fim = false;

  static List<String> values = [
    "7", "8", "9", "+",
    "4", "5", "6", "-",
    "3", "2", "1", "*",
    "0", ".", "=", "/"
  ];

  updateDisplay(value){setState(() {display=value;});}
  updateStored(value){setState(() {stored=value;});}
  updateOperator(value){setState(() {operator=value;});}


  @override
  Widget build(BuildContext context) {
    Container btlimpar(txt) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Cores.Strong[indexColor],
          boxShadow: [BoxShadow(color: Colors.black45, offset: Offset(0, 3))]
      ),
      width: 70,
      height: 30,
      child: FlatButton(onPressed: (){
        updateDisplay(txt == "C"? "0" : display.length>1 ? display.substring(0,display.length-1) : "0");
        updateStored(txt == "C" ? "" : stored);
        updateOperator(txt == "C" ? "" : operator);
      },child: Text(txt, style: TextStyle(fontSize: 20, color: Cores.Background[indexColor]))),
      alignment: Alignment.center,);

    List<Widget> allbutton = List<Widget>.generate(values.length, (i) =>
        SquareButton(
            size: 100,
            child: Text(values[i], style: TextStyle(fontSize: 40, color: Cores.Font[indexColor]),),
            onPressed: ()
            {
              update(){updateOperator(values[i]); updateStored(display); updateDisplay("");}
              switch(values[i]){
                case "+": {update();} break;
                case "-": {update();} break;
                case "/": {update();} break;
                case "*": {update();} break;
                case "=": {
                  switch (operator){
                    case "+": {updateDisplay((double.parse(stored) + double.parse(display)).toString()); updateStored(""); updateOperator(""); fim = true;} break;
                    case "-": {updateDisplay((double.parse(stored) - double.parse(display)).toString()); updateStored(""); updateOperator(""); fim = true;} break;
                    case "/": {updateDisplay((double.parse(stored) / double.parse(display)).toString()); updateStored(""); updateOperator(""); fim = true;} break;
                    case "*": {updateDisplay((double.parse(stored) * double.parse(display)).toString()); updateStored(""); updateOperator(""); fim = true;} break;
                    default: {} break;
                  }
                } break;
                default: {
                  if (display.contains(".") && values[i] == "."){
                    print('dois pontos');
                  }
                  else{
                    updateDisplay(display == "0" || fim ? values[i] : display + values[i]);}

                  fim = false;
                } break;
              }
            }
        )
    );
    setColor(index){
      setState(() {
        indexColor = index;
      });
    }

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Cores.Strong[indexColor],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          backgroundColor: Cores.Background[indexColor],
            appBar: AppBar(
              title: Text("HP-01a", style: TextStyle(fontSize: 30, color: Cores.Background[indexColor])),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.all(20),
                  height: 75,
                  decoration: new BoxDecoration(
                    color: Cores.Weak.elementAt(indexColor),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("$stored$operator$display", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Cores.Font[indexColor]))
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    spacing: 10,
                    children: [
                      btlimpar("C"),
                      btlimpar("CE"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: allbutton,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Wrap(
                    //spacing: 10,
                    children: [
                      bolinha(tamanho: 30, color: Colors.red, onPressed: (){setColor(0);}),
                      bolinha(tamanho: 30, color: Colors.orange, onPressed: (){setColor(1);}),
                      bolinha(tamanho: 30, color: Colors.yellow, onPressed: (){setColor(2);}),
                      bolinha(tamanho: 30, color: Colors.green, onPressed: (){setColor(3);}),
                      bolinha(tamanho: 30, color: Colors.blue, onPressed: (){setColor(4);}),
                    ],
                  ),
                )
              ])
        )
    );
  }
}
class Cores {
  static List<Color> Background = [
    Colors.white, Colors.white, Colors.white, Colors.white, Colors.white
  ];
  static List<Color> Weak = [
    Colors.redAccent[100], Colors.orangeAccent[100], Colors.yellow[300], Colors.greenAccent[100], Colors.blueAccent[100]
  ];
  static List<Color> Strong = [
    Colors.red[800], Colors.orange[400], Colors.yellow[800], Colors.green[400], Colors.blue[400]
  ];
  static List<Color> Font = [
    Colors.white, Colors.white, Colors.black, Colors.black, Colors.white
  ];
}

class bolinha extends StatelessWidget {
  bolinha({this.tamanho, this.color, this.onPressed});
  final double tamanho;
  final Color color;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      highlightColor: Colors.white,
      splashColor: color,
      onPressed: onPressed,
      child: Icon(Icons.color_lens, color: color, size: tamanho),
    );
  }
}
