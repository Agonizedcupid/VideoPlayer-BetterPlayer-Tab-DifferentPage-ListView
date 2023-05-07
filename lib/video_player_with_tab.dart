import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player_better_player/ContentFragment.dart';
import 'package:video_player_better_player/FlexibleTabs.dart';

class VideoPlayerWithTab extends StatefulWidget {
  const VideoPlayerWithTab({Key? key}) : super(key: key);

  @override
  State<VideoPlayerWithTab> createState() => _VideoPlayerWithTabState();
}



final GlobalKey<BetterPlayerPlaylistState> _betterPlayerPlaylistStateKey =
GlobalKey();

BetterPlayerPlaylistController? get betterPlayerPlaylistController =>
    _betterPlayerPlaylistStateKey
        .currentState!.betterPlayerPlaylistController;

class _VideoPlayerWithTabState extends State<VideoPlayerWithTab> {


  List<BetterPlayerDataSource> _dataSourceList = [];
  late BetterPlayerConfiguration _betterPlayerConfiguration;
  late BetterPlayerPlaylistConfiguration _betterPlayerPlaylistConfiguration;


  _VideoPlayerWithTabState() {
    _betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 1,
      fit: BoxFit.cover,
      autoPlay: true,
      placeholderOnTop: true,
      showPlaceholderUntilPlay: true,
      subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(fontSize: 10),
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    _betterPlayerPlaylistConfiguration = const BetterPlayerPlaylistConfiguration(
      loopVideos: true,
      nextVideoDelay: Duration(seconds: 3),
    );
  }

  Future<List<BetterPlayerDataSource>> setupData() async {
    _dataSourceList.add(
      BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          //"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
          "",
          // subtitles: BetterPlayerSubtitlesSource.single(
          //   type: BetterPlayerSubtitlesSourceType.file,
          //   url: await Utils.getFileUrl(Constants.fileExampleSubtitlesUrl),
          // ),
          placeholder: Image.network(
            "https://picsum.photos/200/300",
            fit: BoxFit.cover,
          )
      ),
    );

    return _dataSourceList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlist"),
      ),
      body: FutureBuilder<List<BetterPlayerDataSource>> (
        future: setupData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("No data found");
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child:AspectRatio(
                    aspectRatio: 1,
                    child: BetterPlayerPlaylist(
                      key: _betterPlayerPlaylistStateKey,
                      betterPlayerConfiguration: _betterPlayerConfiguration,
                      betterPlayerPlaylistConfiguration:
                      _betterPlayerPlaylistConfiguration, betterPlayerDataSourceList: _dataSourceList,
                    ),
                  ),
                ),

                FlexibleTabs().createFlexibleTabs(context),

               // const ContentFragment(),

              ],
            );
          }
        },
      ),

    );
  }


}
