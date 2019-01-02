import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_flutter_bankyo/screen/homeScreen.dart';
import 'package:test_flutter_bankyo/resources/testPage.dart';

class CustomTab extends StatelessWidget {
  final Widget child;
  BuildContext tabContext;

  CustomTab({@required this.child});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        tabContext = context;
        return child;
      },
    );
  }
}

class Tabbed extends StatefulWidget {
  @override
  _TabbedState createState() => _TabbedState();
}

class _TabbedState extends State<Tabbed> {
  int _currentTab = 0;

  final List<CustomTab> tabs = <CustomTab>[
    CustomTab(
      child: HomeScreen(),
    ),
    CustomTab(
      child: Page(),
    ),
    CustomTab(
      child: Page(),
    ),
    CustomTab(
      child: Page(),
    ),
  ];

  Future<Null> _setTab(int index) async {



    if (_currentTab == index) {
      if (Navigator.of(tabs[index].tabContext).canPop()) {
        Navigator.of(tabs[index].tabContext)
            .popUntil((Route<dynamic> r) => r.isFirst);
      }
      return;
    }
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(

      child: Column(
        children: <Widget>[
          _buildStack(),
          _buildTabs(),
        ],
      ),
    );
  }

  Widget _buildStack() {
    return Expanded(

      child: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                const Color.fromRGBO(0, 0, 0, 0.0),
                const Color.fromRGBO(0, 0, 0, 0.0),
              ],
              stops: [0.0, 0.0],
            )),
        child: IndexedStack(

          sizing: StackFit.expand,
          index: _currentTab,
          children: tabs,
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return SafeArea(

      top: false,
      bottom: false,
      child: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                const Color.fromRGBO(174, 118, 206, 1.0),
                const Color.fromRGBO(237, 77, 185, 1.00),
              ],
              stops: [0.0, 1.0],
            )),
        height: 65.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: () =>  _setTab(0),
              child: Column(
                children: <Widget>[
                  Icon( Icons.home,
                    size: 30.0,
                    color: _currentTab == 0
                        ? Color.fromRGBO(255, 255, 255, 1.0)
                        : Color.fromRGBO(228, 196, 233, 1.0),),
                  Text("首頁",
                      style: TextStyle(color: _currentTab == 0
                          ? Color.fromRGBO(255, 255, 255, 1.0)
                          : Color.fromRGBO(228, 196, 233, 1.0))),
                ],
              ),),
            InkWell(
              onTap: () =>  _setTab(1),
              child: Column(
                children: <Widget>[
                  Icon( Icons.import_contacts,
                    size: 30.0,
                    color: _currentTab == 1
                        ? Color.fromRGBO(255, 255, 255, 1.0)
                        : Color.fromRGBO(228, 196, 233, 1.0),),
              Text("形容詞",
                style: TextStyle(color: _currentTab == 1
                    ? Color.fromRGBO(255, 255, 255, 1.0)
                    : Color.fromRGBO(228, 196, 233, 1.0))),
                ],
              ),),
            InkWell(
                onTap: () =>  _setTab(2),
                child: Column(
                  children: <Widget>[
                    Icon( Icons.laptop_windows,
                    size: 30.0,
                      color: _currentTab == 2
                          ? Color.fromRGBO(255, 255, 255, 1.0)
                          : Color.fromRGBO(228, 196, 233, 1.0),),
                    Text("新聞",
                        style: TextStyle(color: _currentTab == 2
                            ? Color.fromRGBO(255, 255, 255, 1.0)
                            : Color.fromRGBO(228, 196, 233, 1.0))),
                  ],
                ),),

            InkWell(
              onTap: () =>  _setTab(3),
              child: Column(
                children: <Widget>[
                  Icon( Icons.search,
                    size: 30.0,
                      color: _currentTab == 3
                  ? Color.fromRGBO(255, 255, 255, 1.0)
                  : Color.fromRGBO(228, 196, 233, 1.0),),
                  Text("翻譯",
                      style: TextStyle(color: _currentTab == 3
                          ? Color.fromRGBO(255, 255, 255, 1.0)
                          : Color.fromRGBO(228, 196, 233, 1.0))),
                ],
              ),),

//            IconButton(
//              iconSize: 20.0,
//              tooltip: '翻譯',
//              color: _currentTab == 3
//                  ? Color.fromRGBO(255, 255, 255, 1.0)
//                  : Color.fromRGBO(228, 196, 233, 1.0),
//              icon: const Icon(Icons.settings),
//              onPressed: () {
//                _setTab(3);
//              },
//            )
          ],
        ),
      ),
    );
  }
}