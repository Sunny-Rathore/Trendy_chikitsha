import 'package:doctor/global/global.dart';
import 'package:doctor/page/Healer/Choose%20Your%20Expertise/Choose_your_expertise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Payment_price extends StatefulWidget {
  const Payment_price({Key? key}) : super(key: key);

  @override
  State<Payment_price> createState() => _Payment_priceState();
}

class _Payment_priceState extends State<Payment_price> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF091E3E),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "FREETRAIL",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            const Center(
              child: Text(
                "(1 MONTH)",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.1,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorWhite)),
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Fee',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Free Workshops',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Priority Listing',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Advertising',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Facilitation Charges',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Multiple Expertise',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.1,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorWhite)),
                    child: Column(
                      children:  const [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'No Fee',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'x',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'x',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'x',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '10%',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '1',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 3.1,
                decoration: BoxDecoration(
                    color: AppColors.colortameti,
                    borderRadius: BorderRadius.circular(10)
                ),

                child: const Center(child: Text("Continue",style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),)),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChooseYourExpertise()),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
