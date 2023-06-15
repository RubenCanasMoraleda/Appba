// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/payslip_model.dart';
import 'package:appba/commons/custom_widgets/loading_list.dart';
import 'package:appba/screens/payslips/payslips_list/payslips_list_cotroller.dart';
import 'package:appba/screens/payslips/payslips_list/search_payslips_delegate.dart';
import 'package:flutter/material.dart';

import 'package:appba/commons/Models/employee.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PayslipList extends StatefulWidget {
  final Employee employee;

  const PayslipList(
    this.employee, {
    super.key,
  });

  @override
  State<PayslipList> createState() => _PayslipListState();
}

class _PayslipListState extends State<PayslipList>
    with AutomaticKeepAliveClientMixin<PayslipList> {
  late PayslipListController _controller;
  late Future<List<Payslip>> _payslips;

  @override
  void initState() {
    super.initState();
    _controller = PayslipListController(widget.employee);
    loadPayslips();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: ApbaColors.semanticBackgroundHighlight1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Mes nomina",
                style: ApbaTypography.body2,
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.magnifyingGlass),
                onPressed: () async {
                  showSearch(
                      context: context,
                      delegate: SearchPayslipDelegate(
                          await _payslips, _controller, widget.employee));
                },
              ),
              const Text(
                "Descargar",
                style: ApbaTypography.body2,
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            color: ApbaColors.semanticHighlight2,
            onRefresh: loadPayslips,
            child: FutureBuilder(
                future: _payslips,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Payslip>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
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
                                      Text(snapshot.data![index].fecha!),
                                      SizedBox(
                                        width: size.width / 5,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              _controller.downloadPayslip(
                                                  snapshot.data![index],
                                                  widget.employee);
                                            },
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
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("No se ha emitido ninguna nómina todavía"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 48,
                            child: ElevatedButton(
                                style: ApbaButtonStyle.secondaryButton,
                                onPressed: loadPayslips,
                                child:
                                    const Icon(FontAwesomeIcons.arrowsRotate)),
                          )
                        ],
                      ));
                    }
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
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> loadPayslips() async {
    setState(() {
      _payslips = _controller.getPayslips();
    });
  }
}
