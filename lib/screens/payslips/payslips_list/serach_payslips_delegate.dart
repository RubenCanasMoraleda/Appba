import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/payslip_model.dart';
import 'package:appba/screens/payslips/payslips_list/payslips_list_cotroller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPayslipDelegate extends SearchDelegate<Payslip> {
  final List<Payslip> payslips;
  List<Payslip> _filter = [];
  final PayslipListController _controller;

  Employee _employee;

  SearchPayslipDelegate(this.payslips, this._controller, this._employee);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(FontAwesomeIcons.xmark))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, Payslip(id: 1));
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _filter = payslips.where(
      (payslip) {
        return (payslip.fecha
            ?.toLowerCase()
            .contains(query.trim().toLowerCase()))!;
      },
    ).toList();
    return ListView.builder(
        itemCount: _filter.length > 60 ? 60 : _filter.length,
        itemBuilder: (context, index) {
          Color background =
              index % 2 == 0 ? ApbaColors.background1 : ApbaColors.background2;
          return Container(
            decoration: BoxDecoration(
                color: background,
                border: const Border(
                    bottom: BorderSide(color: ApbaColors.border1))),
            child: ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_filter[index].fecha!),
                    SizedBox(
                      width: size.width / 5,
                      child: ElevatedButton(
                          onPressed: () {
                            _controller.downloadPayslip(
                                _filter[index], _employee);
                          },
                          style: ApbaButtonStyle.secondaryIconBlueButton,
                          child: const FaIcon(FontAwesomeIcons.download)),
                    )
                  ]),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _filter = payslips.where(
      (payslip) {
        return (payslip.fecha
            ?.toLowerCase()
            .contains(query.trim().toLowerCase()))!;
      },
    ).toList();
    return ListView.builder(
        itemCount: _filter.length > 60 ? 60 : _filter.length,
        itemBuilder: (context, index) {
          Color background =
              index % 2 == 0 ? ApbaColors.background1 : ApbaColors.background2;
          return Container(
            decoration: BoxDecoration(
                color: background,
                border: const Border(
                    bottom: BorderSide(color: ApbaColors.border1))),
            child: ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_filter[index].fecha!),
                    SizedBox(
                      width: size.width / 5,
                      child: ElevatedButton(
                          onPressed: () {
                            _controller.downloadPayslip(
                                _filter[index], _employee);
                          },
                          style: ApbaButtonStyle.secondaryIconBlueButton,
                          child: const FaIcon(FontAwesomeIcons.download)),
                    )
                  ]),
            ),
          );
        });
  }
}
