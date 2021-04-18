import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_learning_x/configs/config.dart';
import 'package:o_learning_x/cores/context.dart';
import 'package:o_learning_x/pages/base_page.dart';
import 'package:o_learning_x/repositories/page_repository.dart';
import 'package:o_learning_x/styles/colors.dart';
import 'package:o_learning_x/widgets/commons/loading_stack.dart';
import 'package:o_learning_x/widgets/score_summaries/score_summary_result.dart';

class ScoreSummaryFeature extends StatefulWidget {
  final IContext context;
  final IConfig config;

  ScoreSummaryFeature({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return _ScoreSummaryFeature();
  }
}

class _ScoreSummaryFeature extends State<ScoreSummaryFeature> {
  late PageRepository pageRepository;

  @override
  void initState() {
    this.pageRepository = PageRepository();
    this.pageRepository.initial();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [],
        children: () => [
          Container(
            margin: MediaQuery.of(context).padding.copyWith(
                  bottom: 32,
                ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: BasePage(
                      pageRepository: this.pageRepository,
                      widgets: [
                        ScoreSummaryResult(
                          context: widget.context,
                          config: widget.config,
                          parentPageRepository: this.pageRepository,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
