import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:taxi_admin/ui/showTaxiDriver.dart';

import 'addTaxiDriver.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height:30.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/adminHome.jpg'),
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight:  Radius.circular(50),),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.h),
                  child: GestureDetector(
                    onTap:() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Driver()));
                    },
                    child: Container(
                      height: 12.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(10)
                          ,bottomRight:  Radius.circular(50),bottomLeft: Radius.circular(10)),
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(child: ListTile(
                            leading: Icon(Icons.person_add,
                            size: 25.sp,
                            color: Colors.blue[900],),
                            trailing: Text(" إضافة سائق",
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold
                            ),
                            ))),
                      ),
                    ),
                  ),
                ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.h),
                    child: GestureDetector(
                      onTap:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Show()));
                      },
                      child: Container(
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(50)
                              ,bottomRight:  Radius.circular(10),bottomLeft: Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(child: ListTile(
                              leading: Icon(Icons.person_search,
                                size: 25.sp,
                                color: Colors.blue[900],),
                              trailing: Text("عرض السائقين",
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold
                                ),
                              ))),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
    ),
    );
  }
}
