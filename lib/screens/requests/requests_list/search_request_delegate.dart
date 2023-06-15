import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:appba/commons/Models/request.dart';
import 'package:appba/screens/requests/requests_list/request_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchRequestDelegate extends SearchDelegate<Request> {
  final List<Request> requests;
  List<Request> _filter = [];
  final RequestListController _controller;

  final Employee _employee;

  SearchRequestDelegate(this.requests, this._controller, this._employee);

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
          close(context, Request(id: 1));
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _filter = requests.where(
      (request) {
        return (request.fechaHoraInicio
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
                    Text(
                      _filter[index].fechaHora!,
                      style: TextStyle(
                        fontSize: ApbaTypography.caption.fontSize,
                      ),
                    ),
                    Text(
                      _filter[index].tipo!.value,
                      style: TextStyle(
                        fontSize: ApbaTypography.caption.fontSize,
                      ),
                    ),
                    Text(
                      _filter[index].estado!.value,
                      style: TextStyle(
                        color: _filter[index].estado!.color,
                        fontSize: ApbaTypography.caption.fontSize,
                      ),
                    ),
                  ]),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _filter = requests.where(
      (request) {
        return (request.fechaHoraInicio
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
                    Text(
                      _filter[index].fechaHora!,
                      style: TextStyle(
                        fontSize: ApbaTypography.caption.fontSize,
                      ),
                    ),
                    Text(
                      _filter[index].tipo!.value,
                      style: TextStyle(
                        fontSize: ApbaTypography.caption.fontSize,
                      ),
                    ),
                    Text(
                      _filter[index].estado!.value,
                      style: TextStyle(
                        color: _filter[index].estado!.color,
                        fontSize: ApbaTypography.caption.fontSize,
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
}
