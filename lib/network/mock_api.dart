import "package:store/network/dtos/app_listing_dto.dart";
import "package:store/network/dtos/featured_app_dto.dart";

class MockApi {
  MockApi._();

  static Future<List<FeaturedAppDto>> fetchFeaturedApps() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      FeaturedAppDto(
        id: 0,
        keywords: "5k, 10k, Half, Marathon, Ultra",
        descriptionHeader: "APPS WE LOVE",
        descriptionContent: "Hit the Ground Running with Runna",
        descriptionFooter: "Training plans for your next marathin or run around the park.",
        iconUrl: "assets/images/runna_icon.png",
        imageUrl: "assets/images/runna_hero.png",
        title: "Runna: Running Training Plans",
        hasInappPurchases: true,
        prefersDarkText: true,
      ),
      FeaturedAppDto(
        id: 1,
        keywords: "RPG Fantasy & Live PvP Arena",
        descriptionHeader: "NEW CHARACTERS",
        descriptionContent: "He-Man and Skeletor enter Raid",
        descriptionFooter: "Power up your fights by unlocking new champions.",
        iconUrl: "assets/images/raid_icon.png",
        imageUrl: "assets/images/raid_hero.png",
        title: "RAID: Shadow Legends",
        hasInappPurchases: false,
        prefersDarkText: false,
      ),
    ];
  }

  static Future<AppListingDto> fetchAppListing(int id) async {
    await Future.delayed(const Duration(seconds: 2));

    switch (id) {
      case 0:
        return AppListingDto(
          longDescriptionPre: [
            "<b>Whether you're an</b> ultramarathoner, a triathlete, or a total beginner, this virtual running coach can help you find your stride— and a supportive community.",
            "<b>What we love</b>: The holistic approach of Runna's personalized fitness plans. Get realtime audio tips on pace and gait as you run as well as reminders to rest. When you're not on the move, the app may offer nutrition guidance or suggest cross-training workouts, like strength-building or Pilates.",
            "<b>Why it's worth it</b>: With easy-to-follow plans tailored to your fitness level, Runna keeps you motivated and progressing towards your goals. The interactive interface ensures you’re always engaged, whether you're setting new personal bests or just starting out.",
            "<b>Community matters</b>: Share your progress and connect with other runners through the app's social features. Celebrate milestones together and gain insights from experienced athletes.",
            "<b>Stay consistent</b>: The app provides gentle nudges to keep you on track, including daily reminders and motivational quotes to power through tough days.",
            "<b>Expert-backed</b>: All training plans are created by certified coaches and sports scientists, ensuring a safe and effective journey toward your goals."
          ],
          longDescriptionPost: [
            "<b>Quick tip</b>: When you select an upcoming race as your overall goal in Runna—say, the Honolulu Marathon—you'll gain access to a dedicated page on the Community tab connecting you to others training for the same race.",
            "<b>Don't miss</b>: Explore the app's curated playlists to keep you energized during your runs. From upbeat tracks to serene background music, there's something for every mood.",
            "<b>Pro insight</b>: Sync Runna with your smartwatch to track stats like heart rate, stride length, and elevation changes in real time. Use these metrics to refine your performance with expert-backed recommendations.",
            "<b>Fun extras</b>: Enjoy challenges and gamified goals that keep running exciting. Unlock badges, streak rewards, and milestones to celebrate your progress.",
            "<b>Stay in the loop</b>: Access the News tab to stay updated on upcoming races, new features, and training tips shared by the community and experts."
          ],
          screenshotUrls: [
            "assets/images/runna_demo_1.png",
            "assets/images/runna_demo_2.png",
          ],
          storyUrl: "https://apps.apple.com/in/story/id1771580875",
        );
      case 1:
        return AppListingDto(
          longDescriptionPre: [
            "<b>Enter the world of</b> RAID: Shadow Legends, where legendary champions await your command. Assemble your team, battle through epic campaigns, and conquer your enemies in stunningly rendered 3D battles.",
            "<b>What we love</b>: The deep strategy and customization options. Choose from over 700 champions, each with unique abilities, to build the ultimate squad. Equip artifacts, develop skills, and tailor your champions to dominate every challenge.",
            "<b>Immersive experience</b>: Dive into rich storylines, cinematic visuals, and intense PvP battles. Whether you're forging alliances in a clan or raiding dungeons for epic loot, there's always something exciting happening."
          ],
          longDescriptionPost: [
            "<b>Quick tip</b>: Don't miss the daily login rewards! Each day you log in brings valuable resources, rare shards, and even new champions to bolster your team.",
            "<b>Stay ahead</b>: Participate in limited-time events and tournaments to earn exclusive rewards and climb the leaderboards. Keep an eye on the Events tab to never miss an opportunity.",
            "<b>Pro insight</b>: Experiment with team compositions in the Arena to find the perfect synergy. Combining champions with complementary abilities can turn the tide of battle in your favor."
          ],
          screenshotUrls: [
            "assets/images/raid_demo_1.png",
          ],
          storyUrl: "https://apps.apple.com/in/story/id1771580875",
        );
    }

    throw UnimplementedError();
  }
}
