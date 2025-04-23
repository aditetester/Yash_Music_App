import 'package:flutter/material.dart';
class TopPlaylistCard extends StatelessWidget {
  final List<String> imageUrls; // Pass up to 4 URLs
  final int songCount;
  final VoidCallback onPlay;

  const TopPlaylistCard({
    super.key,
    required this.imageUrls,
    required this.songCount,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    List<String> displayImages = List.from(imageUrls);
    while (displayImages.length < 4) {
      displayImages.add(''); // Fill with empty strings to maintain grid
    }

    return Container(
      width: 140,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 80,
              child: GridView.builder(
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  final imageUrl = displayImages[index];
                  return imageUrl.isNotEmpty
                      ? Image.asset(imageUrl, fit: BoxFit.cover)
                      : Container(color: Colors.transparent); // placeholder
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$songCount Songs',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: onPlay,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF3B8BFF),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
