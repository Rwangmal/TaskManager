import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ cubit/task_cubit.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final String projectId;

  const AddTaskBottomSheet({
    super.key,
    required this.projectId,
  });

  @override
  State<AddTaskBottomSheet> createState() =>
      _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState
    extends State<AddTaskBottomSheet> {

  final titleController = TextEditingController();

  String status = "Pending";
  String priority = "Medium";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Text(
              "Add Task",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Task Title",
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: status,
              decoration: const InputDecoration(
                labelText: "Status",
              ),
              items: const [
                DropdownMenuItem(
                  value: "Pending",
                  child: Text("Pending"),
                ),
                DropdownMenuItem(
                  value: "In Progress",
                  child: Text("In Progress"),
                ),
                DropdownMenuItem(
                  value: "Done",
                  child: Text("Done"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  status = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: priority,
              decoration: const InputDecoration(
                labelText: "Priority",
              ),
              items: const [
                DropdownMenuItem(
                  value: "Low",
                  child: Text("Low"),
                ),
                DropdownMenuItem(
                  value: "Medium",
                  child: Text("Medium"),
                ),
                DropdownMenuItem(
                  value: "High",
                  child: Text("High"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  priority = value!;
                });
              },
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.trim().isEmpty) return;

                await context.read<TaskCubit>().addTask(
                  projectId: widget.projectId,
                  title: titleController.text.trim(),
                  status: status,
                  priority: priority,
                );

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Add Task"),
            ),
          ],

        ),

      ),

    );

  }
}