import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/common/constants.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:glory_vansales_app/models/model.company.dart';
import 'package:glory_vansales_app/ui/views/company/company_cap_table.dart';
import 'package:glory_vansales_app/ui/views/company/company_info_table.dart';
import 'package:glory_vansales_app/ui/views/company/company_member.dart';
import 'package:glory_vansales_app/ui/views/_layout.dart';
import 'package:stacked/stacked.dart';

import 'company_viewmodel.dart';

class CompanyView extends StackedView<CompanyViewModel> {
  final int tabIndex;
  const CompanyView({Key? key, int? tabIndex})
      : tabIndex = (tabIndex ?? 0),
        super(key: key);

  @override
  void onViewModelReady(CompanyViewModel viewModel) {}

  @override
  Widget builder(BuildContext context, CompanyViewModel viewModel, Widget? child) {
    Utils.log("tabIndex $tabIndex");

    final l = Layout01Scaffold(
      body: DefaultTabController(
          initialIndex: tabIndex,
          length: 3,
          child: Builder(builder: (context) {
            final TabController controller = DefaultTabController.of(context);
            controller.addListener(() {
              if (!controller.indexIsChanging) {
                viewModel.tabIndex = controller.index;
                Utils.log("TabController ${controller.index}");
              }
            });
            return Column(children: [
              TabBar(tabs: [
                Text(
                  "Company Information",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Members / Officers",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Cap Table",
                  textAlign: TextAlign.center,
                ),
              ]),
              Expanded(
                //height: MediaQuery.of(context).size.height,
                child: TabBarView(children: [
                  tabCompanyInfo(context, viewModel.company).paddingOnly(top: 12),
                  tabCompanyMembers(context, viewModel.company).paddingOnly(top: 0),
                  tabCapTable(context, viewModel.company).paddingOnly(top: 12),
                ]),
              )
            ]);
          })),
    );

    return l;
  }

  @override
  CompanyViewModel viewModelBuilder(BuildContext context) => CompanyViewModel();

  Widget tabCompanyInfo(BuildContext context, Company? company) {
    final w = SingleChildScrollView(child: wCompanyInfoTable(company: company, isCompact: false));
    return w;
  }

  Widget tabCompanyMembers(BuildContext context, Company? company) {
    final w2 = Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyUi.hs_sm(),
        wCompanyMember(header: "Contact(s)", company: company, roles: [MemberType.CONTACT]),
        wCompanyMember(header: "Company Officer(s)", company: company, roles: MemberType.officerTypes),
        wCompanyMember(header: "Auditor(s)", company: company, roles: [MemberType.AUDITOR]),
        wCompanyMember(header: "Manager(s)", company: company, roles: [MemberType.MANAGER]),
        wCompanyMember(header: "Controller(s)", company: company, roles: [MemberType.CONTROLLER]),
        wCompanyMember(header: "Representative(s)", company: company, roles: [MemberType.REPRESENTATIVE]),
      ],
    );

    return w2;
  }

  Widget tabCapTable(BuildContext context, Company? company) {
    final w = SingleChildScrollView(
      child: Column(
        children: [
          wCompanyCapTable(company: company),
        ],
      ),
    );
    return w;
  }
}
