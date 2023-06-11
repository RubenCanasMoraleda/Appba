// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/request.dart';
import 'package:appba/commons/custom_widgets/loading_list.dart';
import 'package:appba/screens/requests/requests_list/request_list_controller.dart';
import 'package:flutter/material.dart';

import 'package:appba/commons/Models/employee.dart';

class RequestList extends StatefulWidget {
  final Employee employee;

  const RequestList(
    this.employee, {
    super.key,
  });

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList>
    with AutomaticKeepAliveClientMixin<RequestList> {
  late RequestListController _controller;
  late Future<List<Request>> _requests;

  @override
  void initState() {
    super.initState();
    _controller = RequestListController(widget.employee);
    loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
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
                "Tipo",
                style: ApbaTypography.body2,
              ),
              Text(
                "Estado",
                style: ApbaTypography.body2,
              ),
            ],
          ),
        ),
        Expanded(
          // height: height - 56,
          child: FutureBuilder(
              future: _requests,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Request>> snapshot) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    color: ApbaColors.semanticHighlight2,
                    onRefresh: loadRequests,
                    child: ListView.builder(
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
                                    Text(
                                      snapshot.data![index].fechaHora!,
                                      style: TextStyle(
                                        fontSize:
                                            ApbaTypography.caption.fontSize,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![index].tipo!.value,
                                      style: TextStyle(
                                        fontSize:
                                            ApbaTypography.caption.fontSize,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![index].estado!.value,
                                      style: TextStyle(
                                        color:
                                            snapshot.data![index].estado!.color,
                                        fontSize:
                                            ApbaTypography.caption.fontSize,
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        }),
                  );
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

  @override
  bool get wantKeepAlive => true;

  Future<void> loadRequests() async {
    _requests = _controller.getRequests();
  }
}
