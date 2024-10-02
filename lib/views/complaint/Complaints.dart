// import 'dart:convert';

import 'dart:convert';
import 'dart:developer';

import '/exports/exports.dart';
import 'ViewComplaint.dart';

class Complaint extends StatefulWidget {
  const Complaint({super.key});

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  @override
  void initState() {
    super.initState();
    // context.read<MainController>().fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserdataController>(context).getUserData();
    BlocProvider.of<TenantController>(context)
        .fetchTenants(BlocProvider.of<UserdataController>(context).state);
    log(BlocProvider.of<TenantController>(context).state.toString());
    // Provider.of<MainController>(context, listen: true).fetchComplaints();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaints"),
        titleTextStyle: TextStyles(context).getTitleStyle().apply(
              color: Colors.white,
            ),
        actions: [
          BlocBuilder<TenantController, Map<String, dynamic>>(
            builder: (context, state) {
              return Text.rich(
                TextSpan(
                  children: [
                    // TextSpan(
                    //   text: "\n  Welcome, ",
                    //   style: Theme.of(context).textTheme.bodyLarge,
                    // ),
                    TextSpan(
                      text: state['name'],
                      style: TextStyles(context).getRegularStyle().copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                    ),
                    const TextSpan(text: "    "),
                  ],
                ),
                style: TextStyles(context).getRegularStyle(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TapEffect(
              onClick: () {
                Routes.push(const ProfileScreen(), context);
              },
              child: CircleAvatar(
                radius: 23,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColorDark,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 20, bottom: 20),
        child: BlocBuilder<TenantController, Map<String, dynamic>>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("complaints")
                          .where(
                            'tenantId',
                            isEqualTo:
                                BlocProvider.of<UserdataController>(context)
                                    .state,
                          )
                          .orderBy("date", descending: true)
                          .snapshots(),
                      builder: (context, s) {
                        var data = s.data;
                        // return s.hasData == false
                        return s.hasData == false
                            ? const Loader(
                                text: "Complaints",
                              )
                            : s.data!.docs.isEmpty
                                ? const NoDataWidget(
                                    text: "No Complaints",
                                  )
                                : ListView.builder(
                                    itemCount: data?.docs.length,
                                    itemBuilder: (ctx, i) {
                                      var t = data?.docs[i];
                                      return ListTile(
                                        onTap: () {
                                          Routes.push(
                                            ViewComplaint(
                                              title: t?['title'],
                                              description: t?['description'],
                                              status: t?['status'],
                                              image: t?['image'],
                                              date: t?['date'],
                                            ),
                                            context,
                                          );
                                        },
                                        leading: CircleAvatar(
                                          radius: 40,
                                          backgroundImage: MemoryImage(
                                            base64.decode(
                                              t?['image'],
                                            ),
                                          ),
                                        ),
                                        title: Text("${t?['title']}",
                                            style: TextStyles(context)
                                                .getRegularStyle()),
                                        subtitle: Text(
                                            getTimeAgo(
                                              DateTime.parse(t?['date'])
                                                  .subtract(
                                                Duration(seconds: 1),
                                              ),
                                            ),
                                            style: TextStyles(context)
                                                .getDescriptionStyle()),
                                        trailing: Text(
                                            "${t?['status']}"
                                                    .characters
                                                    .first
                                                    .toUpperCase() +
                                                "${t?['status']}".substring(1),
                                            style: TextStyles(context)
                                                .getDescriptionStyle()),
                                      );
                                    });
                      }),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Routes.push(const AddComplaint(), context),
        icon: const Icon(Icons.add),
        label: const Text("Add Complaint"),
      ),
    );
  }
}
