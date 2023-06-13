import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/commons/Models/request.dart';
import 'package:appba/screens/employee_management/accept_deny_request/accept_deny_request.dart';
import 'package:appba/screens/employee_management/accept_deny_request/accept_deny_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchEmployeeDelegate extends SearchDelegate<Request> {
  final List<Request> requests;
  final AcceptDenyRequestController _controller;
  List<Request> _filter = [];

  SearchEmployeeDelegate(this.requests, this._controller);

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
    int? n;
    if (query.isNotEmpty) {
      n = int.tryParse(query.characters.first);
    }

    _filter = requests.where(
      (request) {
        if (n == null) {
          return (request.empleado?.nombre
              ?.toLowerCase()
              .contains(query.trim().toLowerCase()))!;
        }
        return (request.empleado?.dni?.contains(query.trim()))!;
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
              child: RequestTile(
                  controller: _controller, request: _filter[index]));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    int? n;
    if (query.isNotEmpty) {
      n = int.tryParse(query.characters.first);
    }

    _filter = requests.where(
      (request) {
        if (n == null) {
          return (request.empleado?.nombre
              ?.toLowerCase()
              .contains(query.trim().toLowerCase()))!;
        }
        return (request.empleado?.dni?.contains(query.trim()))!;
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
              child: RequestTile(
                  controller: _controller, request: _filter[index]));
        });
  }
}
