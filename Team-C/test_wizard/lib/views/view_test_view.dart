import 'package:flutter/material.dart';
import 'package:test_wizard/widgets/tw_app_bar.dart';
import 'package:test_wizard/widgets/view_assessment_page.dart';

class CreateViewTest extends StatelessWidget {
  final String assessmentName;
  final String courseName;
  const CreateViewTest({
    super.key,
    required this.assessmentName,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TWAppBar(
        context: context,
        screenTitle: 'View $assessmentName Versions',
        implyLeading: true,
        assessment: assessmentName,
        className: courseName,
      ),
      body: ViewAssessmentPage(
        assessmentName: assessmentName,
        course: courseName,
        assessmentId: 'MQ1V1',
      ),
    );
  }
}
