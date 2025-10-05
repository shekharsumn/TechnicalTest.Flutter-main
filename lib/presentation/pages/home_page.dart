import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../i10n/app_localizations.dart';
import 'post_list_page.dart';
import 'saved_post_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    
    // TO:DO Get saved count, defaulting to 0 if loading/error
    const savedCount = 0;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.posts),
          bottom: TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context)!.all),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.saved),
                    if (savedCount > 0) ...[
                      const SizedBox(width: 6),
                      const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '$savedCount',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ListPage(),
            SavedPostPage(),
          ],
        ),
      ),
    );
  }
}