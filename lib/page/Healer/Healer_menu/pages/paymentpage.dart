import 'package:trendy_chikitsa/global/global.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: 50,
          buttonBackgroundColor: Colors.blue,
          color: Colors.lightGreen,
          items:   const [
            Icon(Icons.home, size: 30,),
            Icon(Icons.list, size: 30,),
            Icon(Icons.compare_arrows,),
          ],
          onTap: (index) {
            //Handle button tap
            // if(index == 0){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (_) =>  PaymentPage()));
            // } else if (index == 1){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (_) =>  Appointments()));
            // } else if(index == 2){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (_) =>  social_media()));
            // }
          },
        ),
      ),
      // drawer: Drawer(),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 14),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Flexible(
                  //   child: Container(
                  //     height: 56,
                  //     padding: const EdgeInsets.only(
                  //       right: 8,
                  //       left: 16,
                  //       bottom: 5,
                  //       top: 6,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       color: kGreyColor500,
                  //     ),
                  //     child: TextField(
                  //       style: TextStyle(
                  //           fontSize: 16, color: AppColors.colorbargandi),
                  //       cursorHeight: 18,
                  //       decoration: InputDecoration(
                  //         suffixIcon: const Icon(
                  //           Icons.search,
                  //           color: kBlackColor900,
                  //         ),
                  //         suffixIconConstraints: const BoxConstraints(
                  //           maxHeight: 24,
                  //         ),
                  //         hintText: 'Search doctor, medicines etc',
                  //         hintStyle: TextStyle(
                  //             fontSize: 16, color: AppColors.colorbargandi),
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: FractionalOffset.topRight,
                        end: FractionalOffset.bottomLeft,
                        colors: [
                          AppColors.colorlal,
                          AppColors.colorJambli,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                'Quick Access',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: AppColors.colorWhite,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 90,
                              width: 90,
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.schedule,color: Colors.white,size: 35,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: const Text(
                                          'Schedule',
                                          style: TextStyle(
                                            fontSize: 14,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 90,
                              width: 90,
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.green
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.date_range,color: Colors.white,size: 35,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: const Text(
                                          'Appointment',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 90,
                              width: 90,
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.green
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.account_circle_rounded,color: Colors.white,size: 35,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: const Text(
                                          'Profile',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child:  Text("WHO WE ARE",style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.colorbargandi,
                          decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text('Hola healers!!!!! Trendy Chikitsa facilitates healers to focus on their aim to heal as many souls as '
                            'possible. We at Trendy Chikitsa, are committed to bring seekers to your doorstep. We will leave no stone '
                            'unturned in order to fulfil this objective. We need to ensure that alternative healing therapies are'
                            'propagated positively to the farthest habitat. So Healers, join us and make this world more beautiful.',
                          style: TextStyle(fontSize: 14,color: AppColors.colorBlack),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient:  LinearGradient(
                        begin: FractionalOffset.topRight,
                        end: FractionalOffset.bottomLeft,
                        colors: [
                          Colors.red.shade300,
                          Colors.yellow.shade500,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text("WHY CHOOSE TRENDY CHIKITSA",style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorJambli),
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 10,),
                            Column(
                              children:  [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /4,
                                  child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.asset('assets/images/handshake.png')
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:   [
                                SizedBox(
                                width: MediaQuery.of(context).size.width /2,
                                  child: const Center(
                                    child: Text("Connect with Seekers",style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black
                                    ),),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width /1.7,
                                  child: const Center(
                                    child: Text("Find and help believers with your healing abilities via Trendy Chikitsa.",style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black
                                    ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 10,),
                            Column(
                              children:  [
                                const SizedBox(height: 10,),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /4,
                                  child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.asset('assets/images/home.png')
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:   [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /2,
                                  child: const Center(
                                    child: Text("Sharpen your Healing Skills",style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black
                                    ),),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width /1.7,
                                  child: const Center(
                                    child: Text("Trendy Chikitsa brings you in contact with a wide "
                                        "variety of seekers who motivate you to stay updated in your field and enhance your expertise.",style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black
                                    ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 10,),
                            Column(
                              children:  [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /4,
                                  child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.asset('assets/images/hong.png')
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:   [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /2,
                                  child: const Center(
                                    child: Text("Showcase your Therapy",style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black
                                    ),),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width /1.7,
                                  child: const Center(
                                    child: Text("Find success through Trendy Chikitsa. Heal our esteemed clients and become a master of your trade.",style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black
                                    ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 10,),
                            Column(
                              children:  [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /4,
                                  child: SizedBox(
                                      height: 90,
                                      width: 90,
                                      child: Image.asset('assets/images/box.png')
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:   [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /2,
                                  child: const Center(
                                    child: Text("Choose your own Working Hours",style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black
                                    ),),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width /1.7,
                                  child: const Center(
                                    child: Text("Be your own boss and heal seekers in your own time. No pressure!",style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.black
                                    ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),


                ],
              ),
            )),
      ),
    );
  }
}
