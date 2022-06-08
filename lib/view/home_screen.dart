import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../controller/data_service.dart';
import '../model/user_model.dart';
import '../provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: 500,
          child: Center(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    // ignore: unnecessary_new
                    Data user =
                        new Data(ID: 102, NAME: "Ashutosh", PASSWORD: "a1234");
                    // print(user.NAME);
                    dataService.addData(context, user);
                    // print("Added");
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Add Data",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    print("pressed");
                    userProvider.users = await DataService().getData();
                    userProvider.notifyListeners();
                    print(userProvider.users![0].NAME);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Get Data",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
