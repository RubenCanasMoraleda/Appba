import 'package:appba/commons/Models/employee.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../assets/apba_theme/colors/apba_colors.dart';
import '../../assets/apba_theme/navigation/apba_navigation_bar.dart';
import '../../commons/custom_widgets/confirmation_dialog.dart';
import '../../commons/custom_widgets/floating_action_button.dart';
import '../clock_in/clock_in_list/clock_in_list.dart';
import '../employee_management/employee_management.dart';
import '../payslips/payslips_list/payslips_list.dart';
import '../requests/requests_list/requests_list.dart';

class MainScreen extends StatefulWidget {
  final Employee employee;
  const MainScreen(this.employee, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static late List<Widget?> _buttonOptions;
  late PageController _pageController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(_selectedIndex);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<BottomNavigationBarItem> _listFromRol() {
    if (widget.employee.rol == "recursos humanos" ||
        widget.employee.rol == "jefe recursos humanos" ||
        widget.employee.rol == "jefe") {
      return <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Marcaje',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Solicitudes',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Nominas',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Empleados',
        ),
      ];
    }
    return <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Marcaje',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Solicitudes',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.school),
        label: 'Nominas',
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _buttonOptions = <Widget?>[
      ApbaFloatingActionButton(
          onPressed: () async {
            bool isEnable = await Geolocator.isLocationServiceEnabled();
            if (isEnable) {
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, "/createClockIn",
                  arguments: widget.employee);
            } else {
              // ignore: use_build_context_synchronously
              showAlertDialog(context,
                  title: "Acceso a la ubicación",
                  message:
                      "La ubicación del dispositivo no está activada, para poder marcar es necesario saber su unicación. \n ¿Deasea activarla?",
                  onConfirm: () {
                Geolocator.openLocationSettings()
                    .then((value) async => {
                          if (value)
                            {
                              isEnable =
                                  await Geolocator.isLocationServiceEnabled(),
                            },
                        })
                    .whenComplete(() => {
                          if (isEnable)
                            {
                              Navigator.pushNamed(context, "/createClockIn",
                                  arguments: widget.employee)
                            }
                        });
              });
            }
          },
          tooltip: "Marcar",
          icon: FontAwesomeIcons.plus),
      ApbaFloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/createRequest",
                arguments: widget.employee);
          },
          tooltip: "Marcar",
          icon: FontAwesomeIcons.plus),
      null,
      null
    ];

    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.xmark),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Image.asset(
          "lib/assets/png/Algeciras_Port.png",
          width: 100,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/notifications",
                    arguments: widget.employee);
              },
              icon: const Icon(FontAwesomeIcons.circleInfo))
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: getWidgetOptions(),
        onPageChanged: (value) => _onItemTapped(value),
      ),
      bottomNavigationBar: BottomNavigationBar(
          useLegacyColorScheme: false,
          selectedIconTheme: ApbaNavbarStyle.selectedIconThemeLabel,
          unselectedIconTheme: ApbaNavbarStyle.unSelectedIconThemeLabel,
          currentIndex: _selectedIndex,
          selectedItemColor: ApbaNavbarStyle.selectedItemColor,
          selectedLabelStyle: ApbaNavbarStyle.selectedLabelStyle,
          unselectedLabelStyle: ApbaNavbarStyle.unSelectedLabelStyle,
          unselectedItemColor: ApbaColors.textStateDisable,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: ApbaNavbarStyle.backgroundColor,
          items: _listFromRol()),
      floatingActionButton: _buttonOptions.elementAt(_selectedIndex),
    );
  }

  getWidgetOptions() {
    if (widget.employee.rol == "recursos humanos" ||
        widget.employee.rol == "jefe recursos humanos" ||
        widget.employee.rol == "jefe") {
      return <Widget>[
        ClockInList(widget.employee),
        RequestList(widget.employee),
        PayslipList(widget.employee),
        EmployeeManagement(widget.employee)
      ];
    } else {
      return <Widget>[
        ClockInList(widget.employee),
        RequestList(widget.employee),
        PayslipList(widget.employee),
      ];
    }
  }
}
