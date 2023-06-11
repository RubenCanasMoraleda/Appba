import 'package:appba/assets/apba_theme/button_style/apba_buttons_style.dart';
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/commons/Models/employee.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchEmployeeDelegate extends SearchDelegate<Employee> {
  final List<Employee> employees;
  List<Employee> _filter = [];

  SearchEmployeeDelegate(this.employees);

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
          close(context, Employee(id: 1));
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    int? n;
    if (query.isNotEmpty) {
      n = int.tryParse(query.characters.first);
    }

    _filter = employees.where(
      (employee) {
        if (n == null) {
          return (employee.nombre
              ?.toLowerCase()
              .contains(query.trim().toLowerCase()))!;
        }
        return (employee.dni?.contains(query.trim()))!;
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
                leading: Text(_filter[index].dni!),
                title: Text(_filter[index].nombre!),
                subtitle: Text(
                    "Lleva ${_filter[index].hours!} horas trabajadas este mes"),
              ));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    int? n;
    if (query.isNotEmpty) {
      n = int.tryParse(query.characters.first);
    }

    _filter = employees.where(
      (employee) {
        if (n == null) {
          return (employee.nombre
              ?.toLowerCase()
              .contains(query.trim().toLowerCase()))!;
        }
        return (employee.dni?.contains(query.trim()))!;
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
                leading: Text(_filter[index].dni!),
                title: Text(_filter[index].nombre!),
                subtitle: Text(
                    "Lleva ${_filter[index].hours!} horas trabajadas este mes"),
              ));
        });
  }
}
