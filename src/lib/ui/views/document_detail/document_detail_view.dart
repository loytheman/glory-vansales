import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:glory_vansales_app/services/_webapi.dart';
import 'package:glory_vansales_app/ui/views/_layout.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:stacked/stacked.dart';
import 'document_detail_viewmodel.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';

class DocumentDetailView extends StackedView<DocumentDetailViewModel> {
  final String filename;
  final String path;
  const DocumentDetailView({Key? key, required this.filename, required this.path}) : super(key: key);

  @override
  Widget builder(BuildContext context, DocumentDetailViewModel viewModel, Widget? child) {
    Widget previewer;
    previewer = Text("Preview not available");
    if (Utils.checkFileExtension(filename, "pdf")) {
      //previewer = PdfViewer.asset('assets/dummy.pdf');
      previewer = PdfViewer.uri(Uri.parse(path), headers: WebApi.getAuthHeader());
      // previewer = PdfViewer.uri(Uri.parse(path), headers: WebApi.getAuthHeader());
    } else {
      //previewer = Text(path);
      previewer = PhotoView(imageProvider: NetworkImage(path));
    }

    final btn = IconButton(
        icon: Icon(Icons.ios_share),
        onPressed: () async {
          // Share.share('check out my website https://example.com');
          final res = await WebApi.call("GET", path, {}, WebApi.getAuthHeader(), ResponseType.bytes);
          final dir = await getTemporaryDirectory();
          final temp = "${dir.path}/$filename";
          File(temp).writeAsBytesSync(res.data);
          await Share.shareXFiles([XFile(temp)]);
          //Utils.log("onpress share");
        });

    final l = Layout01Scaffold(
        leading: "back-btn", title: Text(filename), body: previewer, padding: EdgeInsets.all(0), trailing: btn);

    return l;
    //return previewer;
  }

  @override
  DocumentDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DocumentDetailViewModel();
}
