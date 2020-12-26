import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/tab/tab_column.dart';
import 'package:flutter_aoya_news/tab/tab_quotes.dart';
import 'package:flutter_aoya_news/tab/tab_home.dart';
import 'package:flutter_aoya_news/tab/tab_mine.dart';
import 'package:flutter_aoya_news/tab/tab_news.dart';
import 'package:flutter_aoya_news/utils/bus.dart';
import 'package:flutter_aoya_news/value/colors.dart';

class CenterPage extends StatefulWidget {
  @override
  _CenterPageState createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {

  List<Widget> pages; // 存放tab页面的数组

  int myIndex;

  int _selectIndex = 0; // 当前tab的索引

  final defaultItemColor = Color.fromARGB(255, 125, 125, 125);

  final itemNames = [
    _Item('首页', 'images/tab_home_sel.png','images/tab_home.png'),
    _Item('快讯', 'images/tab_news_sel.png','images/tab_news.png'),
    _Item('行情', 'images/tab_policy_sel.png','images/tab_policy.png'),
    _Item('专栏', 'images/tab_topic_sel.png','images/tab_topic.png'),
    _Item('我的', 'images/tab_mine_sel.png','images/tab_mine.png'),
  ];

  List<BottomNavigationBarItem> itemList;
  Future _future;

  List wallets = [];

  // 构造函数
  // _ContainerPageState({Key key, @required this.myIndex,}) : super(key: key);

  @override
  void initState() {
    super.initState();
    // 将四个tab页面初始化为一个数组pages
    if(pages == null){
      pages = [
        new TabHomePage(),
        new TabNewsPage(),
        new TabQuotesPage(),
        new TabColumnPage(),
        new TabMinePage()
      ];
    }
    if(itemList == null){
      this.itemList = itemNames.map((item) =>
          BottomNavigationBarItem(
              icon: Image.asset(
                item.normalIcon,
                width: 24.0,
                height: 24.0,
              ),
              title: Text(
                item.name,
                style: TextStyle(fontSize: 9.0),
              ),
              activeIcon: Image.asset(item.activeIcon, width: 24.0, height: 24.0,))
      ).toList();
    }

    eventBus.on<TabChangeEvent>().listen((event) {
      setState(() {
        _selectIndex = event.index;
      });
    });

  }

//Stack（层叠布局）+ Offstage组合,解决状态被重置的问题
  Widget _getPagesWidget(int index) {
    // print(index);
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }


  @override
  void didUpdateWidget(CenterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
//    List wallets = Provider.of<Wallet>(context).items;
//    if (wallets.length == 0) {
//      Navigator.pushNamed(context, "wallet_guide");
//    }
    return Scaffold(
      body: new Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
          _getPagesWidget(3),
          _getPagesWidget(4),
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (int index) {
          eventBus.fire(TabChangeEvent(index));
          setState(() {
            _selectIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        selectedLabelStyle: TextStyle(fontSize: 9,color: MyColors.THEME_COLORS),
        unselectedLabelStyle: TextStyle(fontSize: 9,color: MyColors.BLACK_TEXT_22),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
        // fixedColor: Colors.lightBlue,
      ),
    );
  }
}

class _Item {
  String name, activeIcon, normalIcon;
  _Item(this.name, this.activeIcon, this.normalIcon);
}