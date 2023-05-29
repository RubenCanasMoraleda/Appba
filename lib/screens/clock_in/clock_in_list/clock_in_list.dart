// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/navigation/apba_apbar.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/custom_widgets/loading_list.dart';
import 'package:flutter/material.dart';

import 'package:appba/commons/Models/employee.dart';
import 'package:appba/screens/clock_in/clock_in_list/clock_in_list_controller.dart';

class ClockInList extends StatefulWidget {
  final Employee employee;

  const ClockInList(
    this.employee, {
    super.key,
  });

  @override
  State<ClockInList> createState() => _ClockInListState();
}

class _ClockInListState extends State<ClockInList> {
  late ClockInListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ClockInListController(widget.employee);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double bottomNavigationBarHeight = kBottomNavigationBarHeight;
    const double androidNavBarHeight = 32;
    final double height = size.height -
        ApbaApbarStyle.theme.toolbarHeight! -
        bottomNavigationBarHeight -
        androidNavBarHeight;
    return Column(
      children: [
        SizedBox(
          height: height / 5,
          width: size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Bienvenido ${widget.employee.nombre}",
                  style: ApbaTypography.textTheme.titleLarge,
                ),
                Text(
                  "Llevas ${_controller.horasRealizadas} de ${_controller.horasTotales} este mes",
                  style: ApbaTypography.textTheme.titleLarge,
                )
              ]),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: ApbaColors.semanticBackgroundHighlight1,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fecha y hora",
                      style: ApbaTypography.body2,
                    ),
                    Text(
                      "Entrada/Salida",
                      style: ApbaTypography.body2,
                    ),
                  ],
                ),
              ),
              Expanded(
                // height: (height / 5) * 4 - 56,
                child: FutureBuilder(
                    future: _controller.getClocksIn(),
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
                                        Text(snapshot.data![index].fechaHora!),
                                        Text(
                                          snapshot.data![index].tipo!.value,
                                          style: TextStyle(
                                              fontSize:
                                                  ApbaTypography.body2.fontSize,
                                              color: snapshot
                                                  .data![index].tipo!.color),
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
            ],
          ),
        ),
      ],
    );
    // )
    // );
  }
}
