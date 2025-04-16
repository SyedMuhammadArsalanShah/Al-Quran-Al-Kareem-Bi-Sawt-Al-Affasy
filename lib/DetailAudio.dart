import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;

class DetailAudio extends StatefulWidget {
  final int surahNum;
  final int startSurah;
  final int endSurah;

  const DetailAudio({
    required this.surahNum,
    required this.startSurah,
    required this.endSurah,
    super.key,
  });

  @override
  State<DetailAudio> createState() => _DetailAudioState();
}

class _DetailAudioState extends State<DetailAudio> {
  late int currentSurah;
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  bool isRepeat = false;
  bool isShuffle = false;
  double playbackSpeed = 1.0;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool showAyahText = true;

  @override
  void initState() {
    super.initState();
    currentSurah = widget.surahNum;
    audioPlayer = AudioPlayer();
    _playSurah(currentSurah);
    audioPlayer.positionStream.listen((pos) {
      setState(() => _position = pos);
    });
    audioPlayer.durationStream.listen((dur) {
      if (dur != null) setState(() => _duration = dur);
    });
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (isRepeat) {
          _playSurah(currentSurah);
        } else if (isShuffle) {
          int randomSurah = widget.startSurah +
              (DateTime.now().millisecondsSinceEpoch %
                  (widget.endSurah - widget.startSurah + 1));
          _playSurah(randomSurah);
        } else if (currentSurah < widget.endSurah) {
          _playSurah(currentSurah + 1);
        }
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSurah(int surahNum) async {
    try {
      final url = await quran.getAudioURLBySurah(surahNum);
      await audioPlayer.setUrl(url);
      await audioPlayer.setSpeed(playbackSpeed);
      await audioPlayer.play();
      setState(() {
        currentSurah = surahNum;
        isPlaying = true;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _togglePlayPause() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    setState(() => isPlaying = !isPlaying);
  }

  void _playNext() {
    if (currentSurah < widget.endSurah) _playSurah(currentSurah + 1);
  }

  void _playPrevious() {
    if (currentSurah > widget.startSurah) _playSurah(currentSurah - 1);
  }

  String _formatTime(Duration d) {
    return "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> ayahs = [];
    for (int i = 1; i <= quran.getVerseCount(currentSurah); i++) {
      ayahs.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          quran.getVerse(currentSurah, i, verseEndSymbol: true),
          textAlign: TextAlign.center,
          style: GoogleFonts.amiriQuran(
            fontSize: 22,
            color: Color(0xFF00796B),
          ),
        ),
      ));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal[800],
          title: Text(
            quran.getSurahNameArabic(currentSurah),
            style: GoogleFonts.amiri(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SwitchListTile(
              // tileColor: Colors.teal,
              activeTrackColor: Colors.teal,
              title: Text(
                'Show Ayah Text',
                style: GoogleFonts.amiriQuran(fontSize: 18),
              ),
              value: showAyahText,
              onChanged: (bool value) {
                setState(() {
                  showAyahText = value;
                });
              },
            ),
          ),
          if (showAyahText)
            Expanded(
              flex: 3,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: ayahs,
              ),
            ),

          CircleAvatar(
            backgroundColor: Colors.teal[800],
            radius: 70,
            backgroundImage: AssetImage("assets/images/alaffasy.png"),
          ),
          SizedBox(height: 12),

          Column(
            children: [
              Slider(
                min: 0.0,
                max: _duration.inMilliseconds.toDouble(),
                value: _position.inMilliseconds
                    .clamp(0, _duration.inMilliseconds)
                    .toDouble(),
                activeColor: Colors.teal[800],
                onChanged: (val) {
                  setState(() {
                    _position = Duration(milliseconds: val.toInt());
                  });
                },
                onChangeEnd: (val) {
                  audioPlayer.seek(Duration(milliseconds: val.toInt()));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatTime(_position),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      _formatTime(_duration),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: Icon(Icons.skip_previous_rounded),
                    onPressed: _playPrevious,
                    iconSize: 36,
                    color: Colors.teal[800]),
                IconButton(
                    icon: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      size: 80,
                    ),
                    onPressed: _togglePlayPause,
                    color: Colors.teal[800]),
                IconButton(
                    icon: Icon(Icons.skip_next_rounded),
                    onPressed: _playNext,
                    iconSize: 36,
                    color: Colors.teal[800]),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    isRepeat ? Icons.repeat_on : Icons.repeat,
                    color: isRepeat ? Colors.teal : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => isRepeat = !isRepeat);
                  },
                ),
                IconButton(
                  icon: Icon(
                    isShuffle ? Icons.shuffle_on : Icons.shuffle,
                    color: isShuffle ? Colors.teal : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => isShuffle = !isShuffle);
                  },
                ),
                DropdownButton<double>(
                  value: playbackSpeed,
                  underline: SizedBox(),
                  items: [1.0, 1.2, 1.5, 2.0]
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text("${s}x"),
                          ))
                      .toList(),
                  onChanged: (s) {
                    if (s != null) {
                      audioPlayer.setSpeed(s);
                      setState(() => playbackSpeed = s);
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}