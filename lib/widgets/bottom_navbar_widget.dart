part of 'widget.dart';

class NavBarWidget extends StatefulWidget {
  final BuildContext context;
  const NavBarWidget(this.context);

  @override
  _NavBarWidgetState createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  @override
  Widget build(BuildContext context) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(
      context,
      listen: false,
    );

    return MultiProvider(
      providers: appProvider,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: baseColor,
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.12),
                blurRadius: 16,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            currentIndex: navigation.index,
            type: BottomNavigationBarType.fixed,
            items: [
              _buildBottomNavigationBarItems(
                context,
                label: 'Psikiater',
                icon: 'assets/images/',
                activeIcon: 'assets/images/',
              ),
              _buildBottomNavigationBarItems(
                context,
                label: 'Psikiater',
                icon: 'assets/images/',
                activeIcon: 'assets/images/',
              ),
              _buildBottomNavigationBarItems(
                context,
                label: 'Psikiater',
                icon: 'assets/images/',
                activeIcon: 'assets/images/',
              ),
              _buildBottomNavigationBarItems(
                context,
                label: 'Psikiater',
                icon: 'assets/images/',
                activeIcon: 'assets/images/',
              ),
            ],
            onTap: (index) {
              navigation.changeIndex(index);
            },
            selectedLabelStyle: mediumBaseFont.copyWith(
              color: accentColor,
              fontSize: 10,
            ),
            unselectedLabelStyle: mediumBaseFont.copyWith(
              color: navInactiveColor,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}

BottomNavigationBarItem _buildBottomNavigationBarItems(
  BuildContext context, {
  required String label,
  required String icon,
  required String activeIcon,
}) {
  return BottomNavigationBarItem(
    label: label,
    icon: (label == 'Profile')
        ? Consumer<NavigationProvider>(
            builder: (
              context,
              navigationProvider,
              _,
            ) {
              return Stack(
                children: <Widget>[
                  Container(
                    height: 25,
                    margin: EdgeInsets.only(bottom: 6),
                    child: Image.asset(
                      icon,
                    ),
                  )
                ],
              );
            },
          )
        : Container(
            height: 25,
            margin: EdgeInsets.only(bottom: 6),
            child: Image.asset(
              icon,
            ),
          ),
    activeIcon: (label == 'Profile')
        ? Consumer<NavigationProvider>(
            builder: (
              context,
              navigationProvider,
              _,
            ) {
              return Stack(
                children: <Widget>[
                  Container(
                    height: 25,
                    margin: EdgeInsets.only(bottom: 6),
                    child: Image.asset(
                      activeIcon,
                    ),
                  )
                ],
              );
            },
          )
        : Container(
            height: 24,
            margin: EdgeInsets.only(bottom: 6),
            child: Image.asset(
              activeIcon,
            ),
          ),
  );
}
