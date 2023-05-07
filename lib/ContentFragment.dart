import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player_better_player/video_player_with_tab.dart';

class ContentFragment extends StatefulWidget {
  const ContentFragment({Key? key}) : super(key: key);

  @override
  State<ContentFragment> createState() => _ContentFragmentState();
}

class _ContentFragmentState extends State<ContentFragment> {

  final List<String> items = ['http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            var list = [
              BetterPlayerDataSource(
                BetterPlayerDataSourceType.network,
                items[index],
                // placeholder: Image.network(
                //   Constants.catImageUrl,
                //   fit: BoxFit.cover,
                // ),
              )
            ];
            betterPlayerPlaylistController?.setupDataSourceList(list);
            // Perform action on item click
            print('Item ${index + 1} clicked');
          },
          child: Text(items[index]),
        );
      },
    );
  }
}
