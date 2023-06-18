import 'package:anglara/cart_view.dart';
import 'package:anglara/home_view.dart';
import 'package:anglara/user_profile_view.dart';
import 'package:flutter/material.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  int pageIndex=0;
  final pagelist=[
    const HomeView(),
    const Cartview(),
    const MyProfileView()
  ];
  PageController pageController=PageController(initialPage: 0,keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: pageController,onPageChanged: (value) {
        pageChanged(value);
      },
      children:const [
        HomeView(),
        Cartview(),
        MyProfileView()
      ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
  type: BottomNavigationBarType.fixed,
  backgroundColor: Colors.indigo.shade500,
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white.withOpacity(.60),
  selectedFontSize: 20,
  unselectedFontSize: 14,
  onTap: (value) {
    setState(() {
    pageIndex = value;
    pageController.animateToPage(value, duration:const Duration(milliseconds: 500), curve: Curves.ease);
  });
  },
  items:const [
    BottomNavigationBarItem(
      label:'Home',
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label:'Cart',
      icon: Icon(Icons.shopping_cart),
    ),
    BottomNavigationBarItem(
      label:'My profile',
      icon: Icon(Icons.person),
    ),
    
  ],
),
    );
  }
  void pageChanged(int index) {
  setState(() {
    pageIndex = index;
  });
}
}