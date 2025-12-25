// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/app/app.dialogs.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/app/app.router.dart';
import 'package:m360_app_corpsec/common/theme.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/helpers/life_cycle.dart';
import 'package:m360_app_corpsec/models/model.company.dart';
import 'package:m360_app_corpsec/services/authentication_service.dart';
import 'package:m360_app_corpsec/services/company_service.dart';
import 'package:m360_app_corpsec/services/test_service.dart';
import 'package:m360_app_corpsec/ui/components/company_name.dart';
import 'package:m360_app_corpsec/ui/views/_layout_inactive_wrapper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:m360_app_central/main.dart' as central;
import 'package:m360_app_central/app/app.router.dart' as central_router;
import 'package:m360_app_corpsec/main.dart' as corpsec;



//layout01 is company appbar, menu & drawer
class Layout01Scaffold extends StatelessWidget {
  static final _authenticationService = locator<AuthenticationService>();
  static final _navigationService = locator<NavigationService>();
  static final _testService = locator<TestService>(instanceName: 'corpsec');
  static final _dialogService = locator<DialogService>();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final EdgeInsets padding;
  final Widget body;
  final dynamic leading; // "drawer", "back-button", Widget
  final dynamic title; // "company-selector", Widget
  final dynamic trailing; // "profile", Widget

  Layout01Scaffold(
      {super.key,
      required this.body,
      bool? backBtnFlag,
      EdgeInsets? padding,
      dynamic leading,
      dynamic title,
      dynamic trailing})
      : leading = (leading ?? "drawer"),
        title = (title ?? "company-selector"),
        trailing = (trailing ?? "profile"),
        padding = (padding ?? EdgeInsets.all(16));

  @override
  Widget build(BuildContext context) {
    VoidCallback? f2() {
      _dialogService.showCustomDialog(
        barrierDismissible: true,
        variant: DialogType.companySelector,
      );
      return null;
    }

    Widget l = Container();
    if (leading == "drawer") {
      l = IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _key.currentState?.openDrawer();
          });
    } else if (leading == "back-btn") {

      l = IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            print('back btn');
            print(LifeCycleHelper.scopeName);
            print(Routes.all);
            // Navigator.push(context, Routes.dashboardView);
            _navigationService.navigateToDashboardView();
            // Navigator.pop(context);
          });
    } else if (leading is Widget) {
      l = leading;
    }

    Widget t = Container();
    if (title == "company-selector") {
      t = ViewModelBuilder<LayoutViewModel>.reactive(
          builder: (context, viewModel, child) {
            final c = viewModel.company;
            final d = {"companyName": c?.companyName ?? "-"};
            final w = wCompanyName(onClickFunc: f2, coData: d, scrollFlag: true);
            return w;
          },
          viewModelBuilder: () => LayoutViewModel());
    } else if (title is Widget) {
      t = title;
    }

    Widget tt = Container();
    if (trailing == "profile") {
      final u = _authenticationService.user;
      if (u?.displayPicture != null) {
        tt = CircleAvatar(radius: 16, backgroundImage: NetworkImage(u!.displayPicture));
        //IconButton(icon: const Icon(CupertinoIcons.profile_circled),onPressed: () => {},);
      } else {
        final str = "${u?.firstName[0]}${u?.lastName[0]}";
        tt = CircleAvatar(radius: 16, backgroundColor: Colors.blue.shade100, child: Text(str));
      }
      tt = GestureDetector(
          child: tt,
          onTap: () async {
            _testService.log();
             print(Routes.all);
            // LifeCycleBlurWrapperState().dispose();
            // StackedLocator.instance.pushNewScope(
            //     scopeName: 'central',
            //     dispose: () async {
            //       // await locator.reset();
            //       await corpsec.reInitRoot();
            //     });
            // await central.init();
            // await central.main();
            // LifeCycleHelper.scopeName = 'central';
            // final exitCentral = await _navigationService.navigateToView(central.MainApp());
            // await _navigationService.navigateTo(central_router.Routes.testView);
            // await exitCentral;
            // print('after exit central module pop right ..');
            // LifeCycleHelper.scopeName = null;
            // await StackedLocator.instance.popScope();
            // LifeCycleHelper.scopeName = null;
            _navigationService.navigateTo(Routes.centralView);
            // await _navigationService.navigateTo(central_router.Routes.testView);
          });
    } else if (trailing is Widget) {
      tt = trailing;
    }

    final ab = MyAppBar(leading: l, title: t, trailing: tt.paddingLTRB(0, 0, 8, 0));

    final s = Scaffold(
      key: _key,
      appBar: ab,
      drawer: NavDrawer(onShowCompanySelector: f2, closeDrawer: () => {_key.currentState?.closeDrawer()}),
      body: Container(padding: padding, child: body),
    );
    return s;
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 56;

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;

  const MyAppBar({super.key, this.leading, this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    final r = ViewModelBuilder<LayoutViewModel>.reactive(
        builder: (context, viewModel, child) {
          final w = Column(
            children: [
              AppBar(
                leading: leading,
                titleSpacing: 0,
                title: title,
                actions: [trailing ?? nil],
              ),
            ],
          );

          return w;
        },
        viewModelBuilder: () => LayoutViewModel());

    return r;
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class NavDrawer extends StatelessWidget {
  final VoidCallback onShowCompanySelector;
  final VoidCallback closeDrawer;

  const NavDrawer({super.key, required this.onShowCompanySelector, required this.closeDrawer});

  @override
  Widget build(BuildContext context) {
    final r = ViewModelBuilder<LayoutViewModel>.reactive(
        builder: (context, viewModel, child) {
          final myStyle = Theme.of(context).extension<MyCustomStyle>();

          final _authenticationService = locator<AuthenticationService>();
          final _dialogService = locator<DialogService>();
          final _navigationService = locator<NavigationService>();
          final d = {"companyName": viewModel.company?.companyName};

          void onClickLogout() {
            _authenticationService.logout();
          }

          final w = Drawer(
              child: Column(
            children: [
              Container(
                height: 100,
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(24, 32, 0, 0),
                child: Image.asset("assets/icon/g-black.png", width: 48),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                width: double.infinity,
                //decoration: BoxDecoration(color: Colors.red),
                child:
                    Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.max, children: [
                  // Container( height: 10, decoration: BoxDecoration(color: Colors.red),),
                  // Container( height: 10, decoration: BoxDecoration(color: Colors.red),),
                  // Container( height: 10, decoration: BoxDecoration(color: Colors.red),),
                  wCompanyName(coData: d, onClickFunc: onShowCompanySelector, scrollFlag: true),
                  MyUi.hs_lg(),

                  TextButton.icon(
                      icon: const Icon(CupertinoIcons.home),
                      onPressed: () {
                        _navigationService.navigateTo(Routes.dashboardView);
                        closeDrawer.call();
                      },
                      label: const Text("Home"),
                      style: TextButton.styleFrom(alignment: Alignment.centerLeft)),

                  TextButton.icon(
                      icon: const Icon(CupertinoIcons.briefcase),
                      onPressed: () {
                        _navigationService.navigateTo(Routes.companyView);
                        closeDrawer.call();
                      },
                      label: const Text("Company"),
                      style: TextButton.styleFrom(alignment: Alignment.centerLeft)),

                  // TextButton.icon(
                  //     icon: const Icon(CupertinoIcons.doc_on_clipboard),
                  //     onPressed: () {
                  //       _navigationService.navigateTo(Routes.requestView);
                  //     },
                  //     label: const Text("Request"),
                  //     style: TextButton.styleFrom(alignment: Alignment.centerLeft)),

                  TextButton.icon(
                      icon: const Icon(CupertinoIcons.folder),
                      onPressed: () {
                        _navigationService.navigateTo(Routes.documentView);
                        closeDrawer.call();
                      },
                      label: const Text("Document"),
                      style: TextButton.styleFrom(alignment: Alignment.centerLeft)),

                  TextButton.icon(
                      icon: const Icon(Icons.history_outlined),
                      onPressed: () {
                        _navigationService.navigateTo(Routes.timelineView);
                        closeDrawer.call();
                      },
                      label: const Text("Timeline"),
                      style: TextButton.styleFrom(alignment: Alignment.centerLeft)),
                ]),
              ),
              MyUi.hs_sm(),
              Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: InkWell(
                      child: Text("  Log out  ", style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
                      onTap: () => {
                            _dialogService.showCustomDialog(
                                barrierDismissible: true,
                                variant: DialogType.confirmation,
                                title: "LOGOUT",
                                description: 'Do you really want to log out?',
                                data: {
                                  "yesFunc": onClickLogout,
                                  "noFunc": null,
                                })
                          })),
              const Spacer(),
              Container(
                height: 148,
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/img/glory.png", height: 36),
                    MyUi.hs_md(),
                    Text("www.meyzer360.com", style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
                    Row(
                      children: [
                        Text("About", style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
                        MyUi.vs_sm(),
                        Text("Terms", style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
                        MyUi.vs_sm(),
                        Text("Privacy", style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
                        MyUi.vs_sm(),
                        MyUi.vs_sm(),
                        IconButton(
                          icon: Icon(Icons.manage_accounts_outlined),
                          onPressed: () {
                            _navigationService.navigateTo(Routes.devDebugView);
                          },
                        )
                      ],
                    ),
                    MyUi.hs_xs(),
                    Text("© 2025 MEYZER360", style: context.bodySmall),
                  ],
                ),
              ),
            ],
          ));

          return w;
        },
        viewModelBuilder: () => LayoutViewModel());

    return r;
  }
}

class LayoutViewModel extends ReactiveViewModel {
  final _companyService = locator<CompanyService>();

  Company? get company => _companyService.currentCompany;

  @override
  List<ListenableServiceMixin> get listenableServices => [_companyService];
}
