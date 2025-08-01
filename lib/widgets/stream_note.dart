import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/data/firebase_datasource.dart';
import 'package:to_do_app/widgets/task_widget.dart';

class StreamNote extends StatelessWidget {
  bool done;
  StreamNote(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseDatasource().stream(done),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final notesList = FirebaseDatasource().getNotes(snapshot);
        print("Số lượng note: ${notesList.length}");
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final note = notesList[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                FirebaseDatasource().deleteNote(note.id);
              },
              child: TaskWidget(note),
            );
          },
          itemCount: notesList.length,
        );
      },
    );
  }
}
