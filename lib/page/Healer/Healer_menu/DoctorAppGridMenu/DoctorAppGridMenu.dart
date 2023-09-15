import 'package:flutter/material.dart';

class DoctorAppGridMenu extends StatelessWidget {
  const DoctorAppGridMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisSpacing: 10,crossAxisSpacing: 10),
      children: [

        Container(
          decoration: BoxDecoration(
              color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Icons.home,size: 50,color: Colors.white,),
              Text('Home',style: TextStyle(fontSize: 16,color: Colors.white),)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home,size: 50,color: Colors.white,),
              Text('Home',style: TextStyle(fontSize: 16,color: Colors.white),)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home,size: 50,color: Colors.white,),
              Text('Home',style: TextStyle(fontSize: 16,color: Colors.white),)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home,size: 50,color: Colors.white,),
              Text('Home',style: TextStyle(fontSize: 16,color: Colors.white),)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home,size: 50,color: Colors.white,),
              Text('Home',style: TextStyle(fontSize: 16,color: Colors.white),)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home,size: 50,color: Colors.white,),
              Text('Home',style: TextStyle(fontSize: 16,color: Colors.white),)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home,size: 50,color: Colors.white,),
              Text('Home',style: TextStyle(fontSize: 16,color: Colors.white),)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home,size: 50,color: Colors.white,),
              Text('Home',style: TextStyle(fontSize: 16,color: Colors.white),)
            ],
          ),
        ),
      ],
    );
  }
}
