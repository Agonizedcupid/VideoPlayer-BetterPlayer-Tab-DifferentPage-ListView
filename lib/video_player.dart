import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

  final GlobalKey<BetterPlayerPlaylistState> _betterPlayerPlaylistStateKey =
  GlobalKey();
  List<BetterPlayerDataSource> _dataSourceList = [];
  late BetterPlayerConfiguration _betterPlayerConfiguration;
  late BetterPlayerPlaylistConfiguration _betterPlayerPlaylistConfiguration;

  _VideoPlayerState() {
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
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
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

    _dataSourceList.add(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
        placeholder: Image.network(
          "https://picsum.photos/seed/picsum/200/300",
          fit: BoxFit.cover,
        ),
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
      body: FutureBuilder<List<BetterPlayerDataSource>>(
        future: setupData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Building!");
          } else {
            return ListView(children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                    "Playlist widget will load automatically next video once current "
                        "finishes. User can't use player controls when video is changing."),
              ),
              AspectRatio(
                child: BetterPlayerPlaylist(
                  key: _betterPlayerPlaylistStateKey,
                  betterPlayerConfiguration: _betterPlayerConfiguration,
                  betterPlayerPlaylistConfiguration:
                  _betterPlayerPlaylistConfiguration,
                  betterPlayerDataSourceList: snapshot.data!,
                ),
                aspectRatio: 1,
              ),
              ElevatedButton(
                onPressed: () {
                  _betterPlayerPlaylistController!.setupDataSource(0);
                },
                child: Text("Change to first data source"),
              ),
              ElevatedButton(
                onPressed: () {
                  _betterPlayerPlaylistController!.setupDataSource(1);
                },
                child: Text("Change to last source"),
              ),
              ElevatedButton(
                onPressed: () {
                  print("Currently playing video: " +
                      _betterPlayerPlaylistController!.currentDataSourceIndex
                          .toString());
                },
                child: Text("Check currently playing video index"),
              ),
              ElevatedButton(
                onPressed: () {
                  _betterPlayerPlaylistController!.betterPlayerController!
                      .pause();
                },
                child: Text("Pause current video with BetterPlayerController"),
              ),
              ElevatedButton(
                onPressed: () {
                  var list = [
                    BetterPlayerDataSource(
                      BetterPlayerDataSourceType.network,
                      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
                      placeholder: Image.network(
                        "https://picsum.photos/200/300?grayscale",
                        fit: BoxFit.cover,
                      ),
                    )
                  ];
                  _betterPlayerPlaylistController?.setupDataSourceList(list);
                },
                child: Text("Setup new data source list"),
              ),
            ]);
          }
        },
      ),
    );
  }

  BetterPlayerPlaylistController? get _betterPlayerPlaylistController =>
      _betterPlayerPlaylistStateKey
          .currentState!.betterPlayerPlaylistController;
}
