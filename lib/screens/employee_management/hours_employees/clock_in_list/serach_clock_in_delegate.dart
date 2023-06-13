import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/clock_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchClockInDelegate extends SearchDelegate<ClockIn> {
  final List<ClockIn> clockins;
  List<ClockIn> _filter = [];

  SearchClockInDelegate(this.clockins);

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
          close(context, ClockIn(id: 1));
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    _filter = clockins.where(
      (clockin) {
        return (clockin.fechaHora
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
                    Text(_filter[index].fechaHora!),
                    Text(
                      _filter[index].tipo!.value,
                      style: TextStyle(
                          fontSize: ApbaTypography.body2.fontSize,
                          color: _filter[index].tipo!.color),
                    ),
                  ]),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = clockins.where(
      (clockin) {
        return (clockin.fechaHora
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
                    Text(_filter[index].fechaHora!),
                    Text(
                      _filter[index].tipo!.value,
                      style: TextStyle(
                          fontSize: ApbaTypography.body2.fontSize,
                          color: _filter[index].tipo!.color),
                    ),
                  ]),
            ),
          );
        });
  }
}
