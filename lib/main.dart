import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Demo());
  }
}

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  double circleRadius = 50.0;
  int count = 0;
  double height = 0.0, width = 0.0;
  bool firstRender = true;
  double right = 0.0;
  double bottom = 0.0;
  double top = 0.0;
  double left = 0.0;
  late List<Widget> orderList;
  late Widget a;
  late Widget b;

  bool isVertical = true;

  @override
  void initState() {
    a = Container(
      alignment: Alignment.center,
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: circleRadius,
      ),
    );
    b = Container(
      height: 100.0,
      width: 100.0,
      color: Colors.green,
    );
    orderList = [a, b];
    startAnimation();
    super.initState();
  }

  void startAnimation() async {
    await Future.delayed(Duration(milliseconds: 700));
    print("Hight ${height}");
    if (count == 0) {
      setState(() {
        isVertical = !isVertical;
        left = width * .5 - circleRadius;
        top = 0.0;
        bottom = 0.0;
        right = 0.0;
      });
    } else if (count == 1) {
      setState(() {
        orderList = [b, a];
        isVertical = !isVertical;
        top = height * .5 - circleRadius * 3;
        left = 0.0;
        right = 0.0;
      });
    } else if (count == 2) {
      setState(() {
        isVertical = !isVertical;
        top = 0.0;
        left = width*.5-150.0;
        // right = 0.0;
        // top = 0.0;
        // left = width*0.5-150.0;
        // bottom = height*.5-100.0;
      });
      // count -=1;
    } else if (count == 3) {
      setState(() {
        orderList = [a,b];
        top = height*.5-circleRadius;
        isVertical = !isVertical;
        bottom = 0.0;
        left = 0.0;
        right = 0.0;
      });
    }
    count += 1;
    if(count == 4){
      count = 0;
    }
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    if (firstRender) {
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
      top = height * .5 - circleRadius;
      bottom = 0.0;
      left = 0.0;
      right = 0.0;

      firstRender = false;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.only(
                top: top, bottom: bottom, left: left, right: right),
            height: 180.0,
            child: Center(
              child: isVertical
                  ? Column(
                      children: orderList,
                    )
                  : Row(
                      children: orderList,
                    ),
            ),
          ),
        ));
  }
}
