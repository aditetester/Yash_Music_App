import 'package:flutter/material.dart';

class AddToPlaylistDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for the dialog box
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.teal[700], // Background color for the dialog
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Add to Playlist',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            // New Playlist Button
            ElevatedButton.icon(
              onPressed: () {
                // Handle New Playlist action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[900],
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'New Playlist',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            // Existing Playlist Item
            GestureDetector(
                onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("added to playlist'")),
                );
                Navigator.of(context).pop();

                },
                child:Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.teal[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child:  Row(
                  children: [
                    const Icon(Icons.queue_music, color: Colors.white),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Zoom',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '1 Song',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Cancel Button
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// To show the dialog
void showAddToPlaylistDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddToPlaylistDialog();
    },
  );
}
