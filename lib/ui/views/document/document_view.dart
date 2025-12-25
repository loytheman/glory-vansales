import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/app/app.router.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/services/_webapi.dart';
import 'package:m360_app_corpsec/services/company_service.dart';
import 'package:m360_app_corpsec/ui/views/_layout.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'document_viewmodel.dart';

class DocumentView extends StackedView<DocumentViewModel> {
  const DocumentView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(DocumentViewModel viewModel) {
    viewModel.init();
  }

  @override
  Widget builder(BuildContext context, DocumentViewModel viewModel, Widget? child) {
    final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);

    final l = Layout01Scaffold(
        body: CustomMaterialIndicator(
            triggerMode: IndicatorTriggerMode.anywhere,
            onRefresh: viewModel.refreshData,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Document", style: headerStyle),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        MyUi.hs_sm(),
                        viewModel.isBusy ? MyUi.loadingList() : docOverview(context, viewModel),
                      ],
                    )),
                  )
                ])));

    return l;
  }

  @override
  DocumentViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DocumentViewModel();
}

Widget docOverview(BuildContext context, DocumentViewModel viewModel) {
  List<Widget> rows = [];
  final l = viewModel.documentList;

  for (final d in l) {
    //final w = Text(d.fileName);
    List<Widget> labels = [];
    for (final label in d.labels) {
      final txt = Container(padding: EdgeInsets.fromLTRB(0, 0, 4, 0), child: MyUi.tag(label));
      labels.add(txt);
    }

    Widget thumbnail;
    if (Utils.checkFileExtension(d.fileName, "pdf")) {
      //preview =   PdfViewer.openFuture(getFuture, futureToDocument)
      //preview = Icon(Icons.file_copy);
      thumbnail = SizedBox(
          width: 36,
          //height: 40,
          child: Image.asset("assets/icon/pdf.png", width: 64));
    } else {
      //final url = "${u}/site/preview/${key}?token=${token}";
      //previewCompanyDocument
      final companyService = locator<CompanyService>();
      final url = companyService.getPreviewCompanyDocumentUrl(d.fileLocation.path, d.sessionAccessToken);

      thumbnail = Container(
          width: 36,
          //height: 40,
          decoration: BoxDecoration(
              color: Colors.grey.shade500,
              //shape: BoxShape.circle,
              boxShadow: [MyUi.shadow()]),
          child: Image.network(
            // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
            url,
            headers: WebApi.getAuthHeader(),
          ));
    }

    final w = Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Row(children: [
        thumbnail,
        MyUi.vs_sm(),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(d.fileName, style: context.bodyLarge),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: labels),
        ]),
      ]),
    );
    final g = GestureDetector(
        onTap: () {
          final navigationService = locator<NavigationService>();
          navigationService.navigateToDocumentDetailView(filename: d.fileName, path: d.url);
        },
        child: w);
    rows.add(g);
    rows.add(MyUi.hs_md());

    // final t = SelectableText(d.url);
    // rows.add(t);
  }

  if (rows.isEmpty) {
    rows.add(MyUi.hs_lg());
    rows.add(Text("There are no data available.", style: context.bodySmall).italic().alignAtCenter());
  }

  final w =
      Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  return w;
}
