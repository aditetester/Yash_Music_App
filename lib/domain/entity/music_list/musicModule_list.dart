
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';

class AllMusicList {
  final List<MusicListModule>? MusicListData;

  AllMusicList({this.MusicListData});

  factory AllMusicList.fromJson(List<dynamic> json) {
    
    List<MusicListModule> MusicListData = <MusicListModule>[];
    
     // Parse JSON string into a List of Map
    MusicListData =  json.map((music) => MusicListModule.fromMap(music)).toList();
  
    return AllMusicList(MusicListData: MusicListData);
  }
}
