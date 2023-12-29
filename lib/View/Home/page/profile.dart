import 'package:flutter/material.dart';

import '../../../Model/profile_models.dart';

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do Duc Nam", style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),),
                  Text("dnam37035@gmail.com", style: TextStyle(
                    color: Colors.white,
                    fontSize: 13
                  ),)
                ],
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: profileModels.length,
              itemBuilder: (BuildContext, index){
                return Row(
                  children: [
                    GestureDetector(
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(56, 56, 67, 0.5),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Icon(iconMap[profileModels[index].icon], color: Colors.white,)),
                    ),
                    SizedBox(
                      width: 10,
                      height: 80,
                    ),
                    Text("${profileModels[index].text}", style: TextStyle(
                      color: Colors.white
                    ),)
                  ],
                );
              },
            ),
          ),
        ],
      ),),
    ));
  }
}
