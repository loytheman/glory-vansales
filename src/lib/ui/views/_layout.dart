// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/app/app.dialogs.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/app/app.router.dart';
import 'package:glory_vansales_app/common/theme.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.company.dart';
import 'package:glory_vansales_app/services/authentication_service.dart';
import 'package:glory_vansales_app/services/company_service.dart';
import 'package:glory_vansales_app/ui/components/company_name.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

//layout01 is company appbar, menu & drawer
class Layout01Scaffold extends StatelessWidget {
  static final _authenticationService = locator<AuthenticationService>();
  static final _navigationService = locator<NavigationService>();
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
        title = (title ?? "Glory Vansales"),
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
            Navigator.pop(context);
          });
    } else if (leading is Widget) {
      l = leading;
    }

    Widget t = Container();
    t = Text(title);

    Widget tt = Container();
    if (trailing == "profile") {
      final u = _authenticationService.user;
      // if (u?.displayPicture != null) {
      //   tt = CircleAvatar(radius: 16, backgroundImage: NetworkImage(u!.displayPicture));
      //   //IconButton(icon: const Icon(CupertinoIcons.profile_circled),onPressed: () => {},);
      // } else {
      final str = "${u?.name}";
      tt = CircleAvatar(radius: 16, backgroundColor: Colors.blue.shade100, child: Text(str));
      // }
      tt = GestureDetector(
          child: tt,
          onTap: () {
            _navigationService.navigateTo(Routes.accountView);
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
                // child: Image.asset("assets/icon/g-black.png", width: 48),
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
                  // wCompanyName(coData: d, onClickFunc: onShowCompanySelector, scrollFlag: true),
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
                      icon: const Icon(CupertinoIcons.map),
                      onPressed: () {
                        // _navigationService.navigateTo(Routes.timelineView);
                        closeDrawer.call();
                      },
                      label: const Text("Route Planning"),
                      style: TextButton.styleFrom(alignment: Alignment.centerLeft)),

                  TextButton.icon(
                      icon: const Icon(CupertinoIcons.cube_box),
                      onPressed: () {
                        closeDrawer.call();
                      },
                      label: const Text("Stock Requisition"),
                      style: TextButton.styleFrom(alignment: Alignment.centerLeft)),

                  TextButton.icon(
                      icon: const Icon(CupertinoIcons.doc_plaintext),
                      onPressed: () {
                        closeDrawer.call();
                      },
                      label: const Text("Orders"),
                      style: TextButton.styleFrom(alignment: Alignment.centerLeft)),

                  TextButton.icon(
                      icon: const Icon(CupertinoIcons.doc_text_search),
                      onPressed: () {
                        closeDrawer.call();
                      },
                      label: const Text("Stock Balance"),
                      style: TextButton.styleFrom(alignment: Alignment.centerLeft)),

                  TextButton.icon(
                      icon: const Icon(CupertinoIcons.tray_arrow_down),
                      onPressed: () {
                        closeDrawer.call();
                      },
                      label: const Text("Cash Collectiom"),
                      style: TextButton.styleFrom(alignment: Alignment.centerLeft)),

                  TextButton.icon(
                      icon: const Icon(CupertinoIcons.tray_full),
                      onPressed: () {
                        closeDrawer.call();
                      },
                      label: const Text("Outstanding Invoices"),
                      style: TextButton.styleFrom(alignment: Alignment.centerLeft)),

                  TextButton.icon(
                      icon: const Icon(CupertinoIcons.printer),
                      onPressed: () {
                        closeDrawer.call();
                      },
                      label: const Text("Invoice Print"),
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
                    Text("www.gloryfood.com.sg", style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
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
                    Text("Copyright © GLORY 2026", style: context.bodySmall),
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
