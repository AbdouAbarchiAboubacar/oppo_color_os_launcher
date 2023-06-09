import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:oppo_launcher/ui/widgets/time.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherHome extends StatefulWidget {
  final List<Application>? launcherHomeApps;
  const LauncherHome({Key? key, required this.launcherHomeApps})
      : super(key: key);

  @override
  State<LauncherHome> createState() => _LauncherHomeState();
}

class _LauncherHomeState extends State<LauncherHome>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - (kToolbarHeight * 1.8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Time(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Material(
                  elevation: 2,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: Container(
                      height: kToolbarHeight,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(8.0),
                              height: kToolbarHeight * 0.4,
                              width: kToolbarHeight * 0.4,
                              child: Image.asset(
                                "assets/images/google.png",
                                fit: BoxFit.cover,
                              )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              enabled: true,
                              style: const TextStyle(fontSize: 20),
                              decoration:
                                  const InputDecoration(hintText: "Search"),
                              onTap: () {
                                canLaunchUrl(Uri.parse('https://google.com'))
                                    .then((bool result) {
                                  launchUrl(Uri.parse('https://google.com'));
                                });
                              },
                            ),
                          )),
                          Container(
                              margin: const EdgeInsets.all(8.0),
                              height: kToolbarHeight * 0.4,
                              width: kToolbarHeight * 0.3,
                              child: Image.asset(
                                "assets/images/google_mic2.png",
                                fit: BoxFit.cover,
                              )),
                          Container(
                              margin: const EdgeInsets.all(8.0),
                              height: kToolbarHeight * 0.4,
                              width: kToolbarHeight * 0.4,
                              child: Image.asset(
                                "assets/images/google_lens.png",
                                fit: BoxFit.cover,
                              )),
                        ],
                      )),
                ),
              ),
              widget.launcherHomeApps != null
                  ? SizedBox(
                      height: kToolbarHeight * 1.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.launcherHomeApps!
                            .map((e) => Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      DeviceApps.openApp(e.packageName);
                                      Navigator.pop(context, [e]);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        e is ApplicationWithIcon
                                            ? SizedBox(
                                                height: kToolbarHeight * 0.9,
                                                width: kToolbarHeight * 0.9,
                                                child: Image.memory(
                                                  e.icon,
                                                  fit: BoxFit.cover,
                                                ))
                                            : const SizedBox(
                                                child: Text('color'),
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            e.appName,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
