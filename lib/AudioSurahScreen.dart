import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lecture02mushaf/DetailAudio.dart';
import 'package:quran/quran.dart' as quran;

class AudioSurahScreen extends StatefulWidget {
  const AudioSurahScreen({super.key});

  @override
  State<AudioSurahScreen> createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "القرآن الكريم بصوت العفاسي",
          style: GoogleFonts.amiri(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade800,
        elevation: 6,
      ),
      body: ListView.builder(
        itemCount: 114,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailAudio(
                      surahNum: index + 1,
                      startSurah: index - 1,
                      endSurah: index + 2,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade100,
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                quran.getSurahNameArabic(index + 1) +
                    " | " +
                    quran.getSurahName(index + 1),
                style: GoogleFonts.amiriQuran(
                  fontSize: 22,
                  color: Colors.teal.shade800,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  "شيخ مشاري راشد العفاسي",
                  style: TextStyle(
                    fontFamily: "jameelfont",
                    fontSize: 17,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  quran.getPlaceOfRevelation(index + 1) == "Makkah"
                      ? Image.asset(
                          "assets/images/kaaba.png",
                              width: 20,
                          height: 20,
                        )
                      : Image.asset(
                          "assets/images/madina.png",
                            width: 20,
                          height: 20,
                        ),
                  const SizedBox(height: 6),
                  Text(
                    "Verses: ${quran.getVerseCount(index + 1)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}