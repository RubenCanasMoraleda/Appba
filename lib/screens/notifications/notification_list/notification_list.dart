import 'package:appba/assets/apba_theme/colors/apba_colors.dart';
import 'package:appba/assets/apba_theme/typography/apba_typography.dart';
import 'package:appba/commons/Models/notification.dart';
import 'package:appba/commons/custom_widgets/floating_action_button.dart';
import 'package:appba/commons/custom_widgets/loading_list.dart';
import 'package:appba/screens/notifications/notification_list/notification_list_cotroller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late NotificationListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NotificationListController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ApbaFloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/createNotification");
          },
          tooltip: "Marcar",
          icon: FontAwesomeIcons.plus),
      appBar: AppBar(
        title: const Center(child: Text("Notificaciones")),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            color: ApbaColors.semanticBackgroundHighlight1,
            child: const Center(
              child: Text(
                "Notificaciones",
                style: ApbaTypography.body2,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: _controller.getNotifications(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Notificacion>> snapshot) {
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
                            child: ExpansionTile(
                              title: Center(
                                  child: Text(snapshot.data![index].title!)),
                              leading: const Icon(FontAwesomeIcons.circleInfo),
                              subtitle: Text(snapshot.data![index].date!),
                              children: [
                                Text(snapshot.data![index].description!)
                              ],
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
    );
  }
}
