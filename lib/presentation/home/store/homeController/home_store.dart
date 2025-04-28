import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';

import '../../../../core/stores/error/error_store.dart';
import '../../../../domain/repository/setting/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeControllerStore = _HomeControllerStore with _$HomeControllerStore;

abstract class _HomeControllerStore with Store {
  final String TAG = "_HomeStore";

  // store variables:-----------------------------------------------------------
  @observable
  bool _isSearching = false;

  @observable
  // List<MusicListModule> _recentlyPlayedSongs = [];
  List<String> _recentlyPlayedSongs = [
    'Song A',
    'Song B',
    'Song C',
    'Song D',
    'Song E',
  ];

  // getters:-------------------------------------------------------------------
  @computed
  bool get isSearching => _isSearching;

  @computed
  //  List<MusicListModule> get recentlyPlayedSongs => _recentlyPlayedSongs;
  List<String> get recentlyPlayedSongs => _recentlyPlayedSongs;

  _HomeStore() {
    init();
  }

  // actions:-------------------------------------------------------------------
  @action
  Future changeIsSearch(bool value) async {
    _isSearching = value;
    
  }

  @action
  // Future addRecentPlay(MusicListModule value) async {
  Future addRecentPlay(String value) async {

    _recentlyPlayedSongs.add(value);
    
  }
  // general methods:-----------------------------------------------------------
  Future init() async {
    _isSearching = false;
  }
}
