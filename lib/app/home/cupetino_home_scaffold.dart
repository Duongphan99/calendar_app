import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_app/app/home/jobs/job_page.dart';
import 'package:flutter_time_app/app/home/tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold(
      {Key key,
      @required this.currentTab,
      @required this.onSelectTab,
      @required this.WidgetBuilders,
      @required this.navigatorKeys})
      : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> WidgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            _buildItem(TabItem.jobs),
            _buildItem(TabItem.entries),
            _buildItem(TabItem.account),
          ],
          onTap: (index) => onSelectTab(TabItem.values[index]),
        ),
        tabBuilder: (context, index) {
          final item = TabItem.values[index];
          return CupertinoTabView(
              navigatorKey: navigatorKeys[item],
              builder: (context) => WidgetBuilders[item](context));
        });
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
        icon: Icon(
          itemData.icon,
          color: color,
        ),
        label: itemData.title);
  }
}