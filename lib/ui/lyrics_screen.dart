import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/constants/constants.dart';
import 'package:spotify_clone/widgets/stream_buttons.dart';

import '../data/datasource/podcast_datasource.dart';

class LyricsScreen extends StatelessWidget {
  const LyricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff2b8094),
      body: Column(
        children: [
          _Header(),
          SizedBox(height: 20),
          _Lyrics(),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ActionButtons(),
          ),
        ],
      ),
    );
  }
}

class _Lyrics extends StatelessWidget {
  const _Lyrics();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 310,
        width: MediaQuery.of(context).size.width,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              Text(
                """
The club isn't the best place to find a lover
So the bar is where I go
Me and my friends at the table doing shots
Drinking faster and then we talk slow
Come over and start up a conversation with just me
And trust me I'll give it a chance now
Take my hand, stop
Put Van The Man on the jukebox
And then we start to dance
And now I'm singing like""",
                style: TextStyle(
                  color: MyColors.whiteColor,
                  fontFamily: "AM",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              Text(
                """
' [Pre-Chorus] Girl, you know I want your love
Your love was handmade for somebody like me
Come on now, follow my lead
I may be crazy, don't mind me
Say, boy, let's not talk too much
Grab on my waist and put that body on me
Come on now, follow my lead
Come, come on now, follow my lead
[Chorus]
I'm in love with the shape of you
We push and pull like a magnet do
Although my heart is falling too
I'm in love with your body
And last night you were in my room
And now my bedsheets smell like you
Every day discovering something brand new
I'm in love with your body
Oh—i—oh—i—oh—i—oh—i
I'm in love with your body
Oh—i—oh—i—oh—i—oh—i
I'm in love with your body
Oh—i—oh—i—oh—i—oh—i
I'm in love with your body
Every day discovering something brand new
I'm in love with the shape of you
""",
                style: TextStyle(
                  color: MyColors.blackColor,
                  fontFamily: "AM",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff000000).withOpacity(0.4),
              ),
              child: const Center(
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ),
          const Column(
            children: [
              Text(
                "Shape of you",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "AM",
                  color: MyColors.whiteColor,
                  fontSize: 18,
                ),
              ),
              Text(
                "Ed Sheeran",
                style: TextStyle(
                  fontFamily: "AM",
                  fontSize: 12,
                  color: Color.fromARGB(255, 253, 239, 239),
                ),
              ),
            ],
          ),
          Image.asset(
            'images/icon_flag.png',
            height: 24,
            width: 24,
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatefulWidget {
  const _ActionButtons();

  @override
  State<_ActionButtons> createState() => __ActionButtonsState();
}

class __ActionButtonsState extends State<_ActionButtons> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // Thêm AudioPlayer
  double _currentNumber = 0; // Đặt giá trị ban đầu
  bool _isInPlay = false; // Trạng thái phát nhạc

  @override
  void initState() {
    super.initState();
    _loadAudio(); // Tải nhạc khi khởi tạo
  }

  Future<void> _loadAudio() async {
    final datasource = PodcastFirebaseDatasource();

    try {
      // Lấy URL bài hát từ Firebase
      final url = await datasource.getSongUrl("Ed Sheeran - Shape Of You.mp3");
      await _audioPlayer.setUrl(url);
    } catch (e) {
      print("Lỗi khi tải audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Giải phóng AudioPlayer khi không cần nữa
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SliderTheme(
            data: const SliderThemeData(
              trackHeight: 2,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Slider(
                min: 0,
                max: 100,
                activeColor: const Color.fromARGB(255, 230, 229, 229),
                inactiveColor: const Color.fromARGB(255, 199, 196, 196),
                value: _currentNumber,
                onChanged: (value) {
                  setState(() {
                    _currentNumber = value; // Cập nhật vị trí
                    _audioPlayer.seek(Duration(milliseconds: value.toInt() * 100)); // Di chuyển đến vị trí mới
                  });
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "0:00",
                  style: TextStyle(
                    fontFamily: "AM",
                    fontSize: 12,
                    color: Color.fromARGB(255, 230, 229, 229),
                  ),
                ),
                Text(
                  "3:53",
                  style: TextStyle(
                    fontFamily: "AM",
                    fontSize: 12,
                    color: Color.fromARGB(255, 230, 229, 229),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'images/icon_sing.png',
                height: 20,
                width: 20,
                color: Colors.white,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isInPlay = !_isInPlay; // Đổi trạng thái phát nhạc
                  });
                  _isInPlay ? _audioPlayer.play() : _audioPlayer.pause();
                },
                child: (_isInPlay)
                    ? const PauseButton(
                        iconWidth: 5,
                        color: MyColors.whiteColor,
                        height: 60,
                        width: 60,
                        iconHeight: 20,
                      )
                    : const PlayButton(
                        color: MyColors.whiteColor,
                        height: 60,
                        width: 60,
                      ),
              ),
              Image.asset(
                'images/share.png',
                color: Colors.white,
                height: 20,
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
