import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videoslider extends StatefulWidget {
  const Videoslider({super.key});

  @override
  State<Videoslider> createState() => _VideosliderState();
}

class _VideosliderState extends State<Videoslider> {
  // Video controller jo video ko control karega (play, pause, volume etc.)
  late VideoPlayerController controller;

  // Player state track karne ke liye
  bool isPlaying = false;
  bool isMuted = false;

  // List of network video URLs
  List<String> videos = [
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://media.w3.org/2010/05/sintel/trailer.mp4",
    "https://media.w3.org/2010/05/bunny/movie.mp4",
    "https://download.blender.org/peach/trailer/trailer_480p.mov",
    "https://download.blender.org/durian/trailer/sintel_trailer-480p.mp4",
  ];

  // Current video ka index track karega
  int currentIndex = 0;

  // InitState me first video load karte hain
  @override
  void initState() {
    super.initState();
    loadVideo();
  }

  // Ye function controller ko initialize karta hai aur video load karta hai
  void loadVideo() {
    controller =
        VideoPlayerController.networkUrl(Uri.parse(videos[currentIndex]))
          ..initialize().then((_) {
            setState(() {}); // video ready hone ke baad UI update
          });

    isPlaying = false;
    isMuted = false;
  }

  // Next video button ka logic
  void nextVideo() {
    if (currentIndex < videos.length - 1) {
      controller.dispose(); // purana controller remove

      setState(() {
        currentIndex++; // next video index
      });

      loadVideo(); // new video load
    }
  }

  // Previous video button ka logic
  void previousVideo() {
    if (currentIndex > 0) {
      controller.dispose(); // purana controller remove

      setState(() {
        currentIndex--; // previous video index
      });

      loadVideo(); // new video load
    }
  }

  // Screen close hone par controller memory free karta hai
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video Slider"), centerTitle: true),

      body: Column(
        children: [
          const SizedBox(height: 40),

          // Container jisme video show hogi
          Center(
            child: Container(
              width: 400,
              height: 225,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(18),
              ),

              // Agar video load ho gayi hai to video show karo
              child: controller.value.isInitialized
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: VideoPlayer(controller),
                    )
                  : const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
            ),
          ),

          const SizedBox(height: 15),

          // DOT INDICATORS (video position show karne ke liye)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              videos.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: currentIndex == index ? 12 : 8,
                height: currentIndex == index ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex == index ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Previous aur Next video buttons
          Padding(
            padding: const EdgeInsets.all(15),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                // Previous Video Button
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),

                  child: IconButton(
                    onPressed: previousVideo,
                    icon: const Icon(Icons.arrow_left),
                    iconSize: 40,
                    color: Colors.white,
                  ),
                ),

                // Next Video Button
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),

                  child: IconButton(
                    onPressed: nextVideo,
                    icon: const Icon(Icons.arrow_right),
                    iconSize: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Player control buttons
          Padding(
            padding: const EdgeInsets.all(15),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                // Pause button -> video ko pause karega
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),

                  child: IconButton(
                    onPressed: () {
                      controller.pause();

                      setState(() {
                        isPlaying = false;
                      });
                    },
                    icon: const Icon(Icons.pause_circle),
                    iconSize: 35,
                    color: !isPlaying ? Colors.red : Colors.white,
                  ),
                ),

                // Play button -> video start karega
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),

                  child: IconButton(
                    onPressed: () {
                      controller.play();

                      setState(() {
                        isPlaying = true;
                      });
                    },
                    icon: const Icon(Icons.play_circle_fill),
                    iconSize: 35,
                    color: isPlaying ? Colors.green : Colors.white,
                  ),
                ),

                // Mute button -> volume 0 kar dega
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),

                  child: IconButton(
                    onPressed: () {
                      controller.setVolume(0);

                      setState(() {
                        isMuted = true;
                      });
                    },
                    icon: const Icon(Icons.music_off_outlined),
                    iconSize: 35,
                    color: isMuted ? Colors.red : Colors.white,
                  ),
                ),

                // Unmute button -> volume normal kar dega
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),

                  child: IconButton(
                    onPressed: () {
                      controller.setVolume(1);

                      setState(() {
                        isMuted = false;
                      });
                    },
                    icon: const Icon(Icons.speaker),
                    iconSize: 35,
                    color: !isMuted ? Colors.green : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
