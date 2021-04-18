import 'package:flutter/cupertino.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/models/question_model.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/widgets/quizs/quiz_item_choice.dart';
import 'package:o_learning_x/widgets/quizs/quiz_item_essay.dart';
import 'package:o_learning_x/widgets/quizs/quiz_item_reading.dart';
import 'package:o_learning_x/widgets/quizs/quiz_item_text.dart';

class QuizItem extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final QuestionModel questionItem;

  QuizItem({
    required this.context,
    required this.config,
    required this.questionItem,
  });

  @override
  State<StatefulWidget> createState() {
    return _QuizItemState();
  }
}

class _QuizItemState extends State<QuizItem> {
  Widget component() {
    switch (widget.questionItem.type) {
      case ChoiceType.READING:
        return QuizItemReading(
          questionItem: widget.questionItem,
        );
      case ChoiceType.CHOICE:
        return QuizItemChoice(
          context: widget.context,
          config: widget.config,
          questionItem: widget.questionItem,
        );
      case ChoiceType.ESSAY:
        return QuizItemEssay(
          context: widget.context,
          config: widget.config,
          questionItem: widget.questionItem,
        );
      case ChoiceType.TEXT:
        return QuizItemText(
          questionItem: widget.questionItem,
        );
      default:
        return QuizItemReading(
          questionItem: widget.questionItem,
        );
    }
  }

  @override
  void initState() {
    widget.context.repositories().quizRepository().currentQuestionId = widget.questionItem.Id;
    widget.context.repositories().quizRepository().forceValueNotify();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorGrayLighter.withOpacity(0.25),
      child: this.component(),
    );
  }
}
