import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int _counter1 = 0;
  int _counter2 = 0;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _counter1 = 131;
        _counter2 = 369;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 35,
      height: MediaQuery.of(context).size.height * .16,
      decoration: BoxDecoration(
        color: Colors.blue.shade800.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(children: [
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Analytics",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                        'This Week',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        CupertinoIcons.chevron_down,
                        size: 18,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.person_2,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Stack(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 25,
                                width: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 25,
                                width: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 25,
                                width: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          AnimatedFlipCounter(
                            value: _counter1,
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                letterSpacing: 15),
                            duration: Duration(seconds: 2),
                            curve: Curves.easeOut,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60.0),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Stack(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 25,
                                width: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 25,
                                width: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 25,
                                width: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          AnimatedFlipCounter(
                            value: _counter2,
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                letterSpacing: 15),
                            duration: Duration(seconds: 2),
                            curve: Curves.easeOut,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: Icon(
                    CupertinoIcons.arrow_right,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.0),
                  child: Text(
                    'Profile visits',
                    style: TextStyle(height: -1.0, color: Colors.white70),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Search appearance',
                    style: TextStyle(height: -1.0, color: Colors.white70),
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
