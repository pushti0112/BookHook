import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
  
}

class _DashboardScreenState extends State<DashboardScreen> {
  Card makeDashboardItem(String title, String img, int index) {
    return Card(
    
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Color(0xFF004B8D),
                    Color(0xFFffffff),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Colors.cyan,
                    Colors.amber,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //1.item
            }
            if (index == 1) {
              //2.item
            }
            if (index == 2) {
              //3.item
            }
            if (index == 3) {
              //4.item
            }
            if (index == 4) {
              //5.item
            }
            if (index == 5) {
              //6.item
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Container(
                  height: 50,
                  width: 50,
                  child: Text("5",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                    
                  ),),
                  
                ),
                // child: Image.asset(
                //   img,
                //   height: 50,
                //   width: 50,
                // ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
    title: Text('Dashboard'),
    backgroundColor: Colors.blueAccent,
  ),
      backgroundColor: Color.fromARGB(255, 246, 247, 248),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // children: <Widget>[
              //   Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: const <Widget>[
              //       Text(
              //         "Hello Aayushi!",
              //         style:
              //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(height: 4),
              //       Text(
              //         "Welcome to Book-Hook",
              //         style:
              //             TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //       ),
              //     ],
              //   ),
              // ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(2),
              children: [
                makeDashboardItem("Borrowed Book", "assets/calendar.png", 0),
                makeDashboardItem("Lended Book", "assets/festival.png", 1),
                // makeDashboardItem("Food", "assets/food.png", 2),
                // makeDashboardItem("Location", "assets/map.png", 3),
                // makeDashboardItem("Todo", "assets/todo.png", 4),
                // makeDashboardItem("Settings", "assets/setting.png", 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}