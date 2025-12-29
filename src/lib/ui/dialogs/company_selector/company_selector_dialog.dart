import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.company.dart';
import 'package:glory_vansales_app/ui/components/company_name.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'company_selector_dialog_model.dart';

class CompanySelectorDialog extends StackedView<CompanySelectorDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const CompanySelectorDialog({super.key, required this.request, required this.completer});

  // @override
  // void onViewModelReady(CompanySelectorDialogModel viewModel) async {
  //   super.onViewModelReady(viewModel);
  //   // await viewModel.refreshData();
  // }

  @override
  Widget builder(BuildContext context, CompanySelectorDialogModel viewModel, Widget? child) {
    var l = viewModel.isBusy ? viewModel.mockCompanyArr : viewModel.companyArr;

    onSelectCompany(i) {
      //Utils.log("onSelectCompany $i");
      viewModel.onSelectCompany(l[i]);
      completer(DialogResponse(confirmed: true));
    }

    final d = MyUi.dialog(
      child: CustomMaterialIndicator(
        onRefresh: viewModel.refreshData,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select company:", style: context.bodyMedium),
            MyUi.hs_sm(),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 350, minHeight: 300),
              child: viewModel.isBusy
                  ? MyUi.loadingListIcon()
                  : buildCompanyList(list: l, onSelectCompany: onSelectCompany),
            )
          ],
        ),
      ),
    );

    return d;
  }

  @override
  CompanySelectorDialogModel viewModelBuilder(BuildContext context) => CompanySelectorDialogModel();
}

Widget buildCompanyList({List<Company>? list, Function(int i)? onSelectCompany}) {
  final w = ListView.builder(
      shrinkWrap: true,
      itemCount: list?.length,
      itemBuilder: (context, index) {
        final c = list?[index];
        final d = {
          "companyName": c?.companyName ?? "",
          "registeredNumber": c?.registeredNumber ?? "",
        };

        final w = wCompanyName(
                onClickFunc: () {
                  onSelectCompany?.call(index);
                },
                coData: d)
            .paddingLTRB(0, 0, 0, 0);
        return w;
      });

  return w;
}
