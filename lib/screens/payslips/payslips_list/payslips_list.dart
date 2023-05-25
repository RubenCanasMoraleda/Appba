// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/navigation/apba_apbar.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/payslip_model.dart';
import 'package:appba/commons/custom_widgets/loading_list.dart';
import 'package:appba/screens/payslips/payslips_list/payslips_list_cotroller.dart';
import 'package:flutter/material.dart';

import 'package:appba/commons/Models/employee.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PayslipList extends StatefulWidget {
  final Employee employee;

  const PayslipList({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  State<PayslipList> createState() => _PayslipListState();
}

class _PayslipListState extends State<PayslipList> {
  late PayslipListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PayslipListController(widget.employee);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: ApbaColors.semanticBackgroundHighlight1,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mes nomina",
                style: ApbaTypography.body2,
              ),
              Text(
                "Descargar",
                style: ApbaTypography.body2,
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: _controller.getPayslips(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Payslip>> snapshot) {
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
                                  bottom:
                                      BorderSide(color: ApbaColors.border1))),
                          child: ListTile(
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data![index].fecha!),
                                  SizedBox(
                                    width: size.width / 5,
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ApbaButtonStyle
                                            .secondaryIconBlueButton,
                                        child: const FaIcon(
                                            FontAwesomeIcons.download)),
                                  )
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
    );
    // )
    // );
  }
}
