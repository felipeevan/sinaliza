import 'package:aplicativo_libras/configuration.dart';
import 'package:aplicativo_libras/pages/aprender.dart';
import 'package:aplicativo_libras/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin{
  int _currentIndex = 0;
  final List<Widget> _tabList = [
    //HomePage(),
    AprenderPage(),
    Container(color: Colors.blue,),
    Container(color: Colors.amber,)
  ];
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(vsync: this, length: _tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child:
            TabBarView(
                controller: _tabController,
                children: _tabList,
                physics: const NeverScrollableScrollPhysics()
            ),
          ),
          bottomNavigationBar: Theme(
          data: ThemeData(
                splashColor: Colors.transparent
            ),
            child: Container(
            decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Config.COR_TERCIARIA, width: 2))),
            child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                fixedColor: Config.COR_SECUNDARIA,
                unselectedItemColor: Config.COR_NEUTRA,
                selectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 12, color: Config.COR_SECUNDARIA,height: 10/12,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 12, color: Config.COR_SECUNDARIA,height: 10/12,
                  fontWeight: FontWeight.w500,
                ),
                currentIndex: _currentIndex,
                iconSize: 30,
                onTap: (index){
                  setState(() {
                    _currentIndex = index;
                    _tabController.animateTo(_currentIndex);
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      label: "HOME",
                      icon: Icon(Icons.home)
                  ),
                  /*BottomNavigationBarItem(
                      label: "APRENDER",
                      icon: Icon(Icons.menu_book_rounded)
                  ),*/
                  BottomNavigationBarItem(
                      label: "GRUPOS",
                      icon: Icon(Icons.forum)
                  ),
                  BottomNavigationBarItem(
                      label: "PERFIL",
                      icon: Icon(Icons.person)
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}