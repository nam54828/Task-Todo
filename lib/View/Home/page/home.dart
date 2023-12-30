import 'package:flutter/material.dart';
import 'package:task_todo/View/Home/widgets/add_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Lists",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32),
                    ),
                    Text(
                      "Good Morning",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.white,
                      )),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(28, 28, 30, 1),
                      borderRadius: BorderRadius.circular(12)),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [AddCart()],
            )
          ],
        ),
      ),
    ));
  }
}
