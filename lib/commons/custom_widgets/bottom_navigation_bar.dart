import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/navigation/apba_navigation_bar.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/custom_widgets/floating_action_button.dart';
import 'package:appba/screens/clock_in/clock_in_list/clock_in_list.dart';
import 'package:appba/screens/payslips/payslips_list/payslips_list.dart';
import 'package:appba/screens/requests/requests_list/requests_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  static final Employee employee =
      Employee(id: 1, dni: "12345678L", nombre: "Rubén Caraculo");
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    ClockInList(employee),
    RequestList(employee),
    PayslipList(employee),
    const Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];
  static late List<Widget?> _buttonOptions;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _buttonOptions = <Widget?>[
      null,
      ApbaFloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/createRequest", arguments: employee);
          },
          tooltip: "Marcar",
          icon: FontAwesomeIcons.plus),
      null,
      null
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ApbaColors.primaryBlue100withOpacity20,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'APPBA',
          // style: TextStyle(color: Colors.black),
        )),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Marcaje',
            // backgroundColor: _background,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Solicitudes',
            // backgroundColor: _background,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Nominas',
            // backgroundColor: _background
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Empleados',
            // backgroundColor: _background,
          ),
        ],
      ),
      floatingActionButton: _buttonOptions.elementAt(_selectedIndex),
    );
  }
}
