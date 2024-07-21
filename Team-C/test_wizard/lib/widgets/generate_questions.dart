import 'package:flutter/material.dart';
import 'package:test_wizard/models/question_generation_detail.dart';
import 'package:test_wizard/services/llm_service.dart';
import 'package:test_wizard/widgets/tw_app_bar.dart';

class QuestionGenerateForm extends StatefulWidget {
  // This class is the configuration for the state.
  // It holds the values (in this case nothing) provided
  // by the parent and used by the build  method of the
  // State. Fields in a Widget subclass are always marked
  // "final"
  const QuestionGenerateForm({super.key});

  @override
  State<StatefulWidget> createState() => QuestionGenerateFormState();
}

class QuestionGenerateFormState extends State<QuestionGenerateForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final LLMService llmService = LLMService();
  final textEditingController = TextEditingController();

  QuestionGenerationDetail questionGenerationDetail =
      QuestionGenerationDetail();

  String prompt = "";

  void setTopic(String topic) {
    setState(() {
      questionGenerationDetail.topic = topic;
    });
  }

  void setSubject(String subject) {
    setState(() {
      questionGenerationDetail.subject = subject;
    });
  }

  void setNumberOfAssessment(int numberOfAssessments) {
    setState(() {
      questionGenerationDetail.numberOfAssessments = numberOfAssessments;
    });
  }

  void setAdditionalDetail(String additionalDetail) {
    setState(() {
      questionGenerationDetail.additionalDetail = additionalDetail;
    });
  }

  void setAssessmentType(String assessmentType) {
    setState(() {
      questionGenerationDetail.assessmentType = assessmentType;
    });
  }

  void setIsMathQuiz() {
    setState(() {
      //the value assigned here is not used in setting the state. Inverse is used. Dart Set methods require a param
      questionGenerationDetail.isMathQuiz = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TWAppBar(
        context: context,
        screenTitle: 'Testing',
        implyLeading: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      setSubject(value);
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      setTopic(value);
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Topic',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      setAdditionalDetail(value);
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Additional Detail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      setAssessmentType(value);
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Assessment Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Checkbox(
                      value: questionGenerationDetail.isMathQuiz,
                      onChanged: (value) {
                        setIsMathQuiz();
                      }),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO add Addtional Details and Question Type Count
                        questionGenerationDetail.prompt =
                            llmService.buildPrompt(
                                questionGenerationDetail.numberOfAssessments,
                                questionGenerationDetail.assessmentType,
                                questionGenerationDetail.topic);
                        textEditingController.text =
                            questionGenerationDetail.prompt;
                      }
                    },
                    child: const Text('Generate'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Generated Prompt will go here'),
                    controller: textEditingController,
                    onChanged: (value) {
                      questionGenerationDetail.prompt = value;
                    },
                    minLines: 4,
                    maxLines: 10,
                    // controller: textEditingController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
