
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';

class AllMusicList {
  final List<MusicListModule>? MusicListData;

  AllMusicList({this.MusicListData});

  factory AllMusicList.fromJson(List<dynamic> json) {
    
    List<MusicListModule> MusicListData = <MusicListModule>[];
    
    MusicListData =  json.map((music) => MusicListModule.fromMap(music)).toList();
  
    return AllMusicList(MusicListData: MusicListData);
  }


  factory AllMusicList.fromJson2(List<dynamic> json) {
    
    List<MusicListModule> MusicListData = <MusicListModule>[];
    
    MusicListData =  json.map((music) => MusicListModule.fromMap2(music)).toList();
  
    return AllMusicList(MusicListData: MusicListData);
  }


  factory AllMusicList.fromJson3(List<dynamic> json) {
    
    List<MusicListModule> MusicListData = <MusicListModule>[];
    
    MusicListData =  json.map((music) => MusicListModule.fromMap3(music)).toList();
  
    return AllMusicList(MusicListData: MusicListData);
  }
}
