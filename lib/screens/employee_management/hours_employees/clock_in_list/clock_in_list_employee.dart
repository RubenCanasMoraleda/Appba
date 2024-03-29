// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/navigation/apba_apbar.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/custom_widgets/loading_list.dart';
import 'package:appba/screens/employee_management/hours_employees/clock_in_list/clock_in_list_controller.dart';
import 'package:appba/screens/employee_management/hours_employees/clock_in_list/serach_clock_in_delegate.dart';
import 'package:flutter/material.dart';

import 'package:appba/commons/Models/employee.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClockInListEmployee extends StatefulWidget {
  final Employee employee;

  const ClockInListEmployee(
    this.employee, {
    super.key,
  });

  @override
  State<ClockInListEmployee> createState() => _ClockInListState();
}

class _ClockInListState extends State<ClockInListEmployee>
    with AutomaticKeepAliveClientMixin<ClockInListEmployee> {
  late ClockInListController _controller;
  late Future<List<ClockIn>> _clocks;
  late Future<List<int>> _hoursMoth;

  @override
  void initState() {
    super.initState();
    _controller = ClockInListController(widget.employee);
    loadClocks();
  }

  Future<void> loadClocks() async {
    setState(() {
      _clocks = _controller.getClocksIn();
      _hoursMoth = _controller.getHoursMonth();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    const double bottomNavigationBarHeight = kBottomNavigationBarHeight;
    const double androidNavBarHeight = 32;
    final double height = size.height -
        ApbaApbarStyle.theme.toolbarHeight! -
        bottomNavigationBarHeight -
        androidNavBarHeight;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "lib/assets/png/Algeciras_Port.png",
          width: 100,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height / 5,
            width: size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Marcajes de ${widget.employee.nombre}",
                    style: ApbaTypography.textTheme.titleLarge,
                  ),
                  FutureBuilder<List<int>>(
                      future: _hoursMoth,
                      builder: (context, AsyncSnapshot<List<int>> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "Lleva ${snapshot.data![0]} de ${snapshot.data![1]} este mes",
                            style: ApbaTypography.textTheme.titleLarge,
                          );
                        } else {
                          return Text(
                            "Cargando",
                            style: ApbaTypography.textTheme.titleLarge,
                          );
                        }
                      })
                ]),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: ApbaColors.semanticBackgroundHighlight1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Fecha y hora",
                        style: ApbaTypography.body2,
                      ),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.magnifyingGlass),
                        onPressed: () async {
                          showSearch(
                              context: context,
                              delegate: SearchClockInDelegate(await _clocks));
                        },
                      ),
                      const Text(
                        "Entrada/Salida",
                        style: ApbaTypography.body2,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    color: ApbaColors.semanticHighlight2,
                    onRefresh: loadClocks,
                    child: FutureBuilder(
                        future: _clocks,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ClockIn>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.length > 60
                                    ? 60
                                    : snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  Color background = index % 2 == 0
                                      ? ApbaColors.background1
                                      : ApbaColors.background2;
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: background,
                                        border: const Border(
                                            bottom: BorderSide(
                                                color: ApbaColors.border1))),
                                    child: ListTile(
                                      title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot
                                                .data![index].fechaHora!),
                                            Text(
                                              snapshot.data![index].tipo!.value,
                                              style: TextStyle(
                                                  fontSize: ApbaTypography
                                                      .body2.fontSize,
                                                  color: snapshot.data![index]
                                                      .tipo!.color),
                                            ),
                                          ]),
                                    ),
                                  );
                                });
                          } else {
                            return LoadingList.of(
                                60,
                                ListTile(
                                  title: Container(
                                    height: 15,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ));
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
