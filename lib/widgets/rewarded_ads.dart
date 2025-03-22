import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAds extends StatefulWidget {
  @override
  State<RewardedAds> createState() => _RewardedAdsState();
}

class _RewardedAdsState extends State<RewardedAds> {
  RewardedAd? _rewardedAd;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  Future<void> loadRewardedAd() async {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _rewardedAd?.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {});
        },
        onAdFailedToLoad: (error) {
          print('Rewarded ad failed to load: $error');
        },
      ),
    );
  }

  void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) => print('Rewarded ad shown.'),
        onAdDismissedFullScreenContent: (ad) {
          print('Rewarded ad dismissed.');
          ad.dispose(); // Dispose the ad object after it's dismissed
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('Failed to show rewarded ad: $error');
          ad.dispose(); // Dispose the ad object on failure
        },
      );
      _rewardedAd!
          .show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {});
      _rewardedAd = null; // Clear the reference after showing the ad
    } else {
      print('Rewarded ad is not ready yet.');
    }
  }

  void onRewarded(RewardItem reward) {
    // Handle the reward here
    print('Rewarded: ${reward.amount} ${reward.type}');
  }

  @override
  void initState() {
    // TODO: implement initState
    // loadRewardedAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Show Reward Ads'),
          onPressed: () {
            loadRewardedAd();
            // showRewardedAd();
          },
        ),
      ),
    );
  }
}
