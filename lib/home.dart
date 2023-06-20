import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    DateTime sunday = now.subtract(Duration(days: now.weekday));

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  GreyContainer(
                    text: 'Total info of the week',
                    width: MediaQuery.of(context).size.width * .2,
                    isBold: true,
                  ),
                  ...kLabels.map(
                    (value) => GreyContainer(
                      text: value,
                      width: MediaQuery.of(context).size.width * .1,
                      isBold: true,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  GreyContainer(
                    text: '',
                    width: MediaQuery.of(context).size.width * .2,
                  ),
                  GreyContainer(
                    text: '',
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  ...List.generate(
                    7,
                    (index) => GreyContainer(
                      text: DateFormat('dd/MM/yyyy')
                          .format(sunday.add(Duration(days: index))),
                      width: MediaQuery.of(context).size.width * .1,
                    ),
                  ),
                ],
              ),
            ),
            CustomRowWidget(
              title: 'Running Time',
              valueList: kRunningTime,
            ),
            CustomRowWidget(
              title: 'Jogging Time',
              valueList: kJoggingTime,
            ),
            CustomRowWidget(
              title: 'Exercise Time',
              valueList: kExerciseTime,
            ),
            CustomRowWidget(
              title: 'Total Time\nRunning+Jogging+Exercise',
              valueList: List.generate(
                  kExerciseTime.length,
                  (index) =>
                      kRunningTime[index] +
                      kJoggingTime[index] +
                      kExerciseTime[index]),
            ),
            CustomRowWidget(
              noSum: true,
              title: 'Running Time Engagement %\n(Running / total time)',
              valueList: List.generate(
                  kExerciseTime.length,
                  (index) => ((kRunningTime[index] /
                              (kRunningTime[index] +
                                  kJoggingTime[index] +
                                  kExerciseTime[index])) *
                          100)
                      .toInt()),
            ),
            CustomRowWidget(
              noSum: true,
              title: 'Jogging Time Engagement %\n(Jogging / total time)',
              valueList: List.generate(
                  kExerciseTime.length,
                  (index) => ((kJoggingTime[index] /
                              (kRunningTime[index] +
                                  kJoggingTime[index] +
                                  kExerciseTime[index])) *
                          100)
                      .toInt()),
            ),
            CustomRowWidget(
              noSum: true,
              title: 'Exercise Time Engagement %\n(Exercise / total time)',
              valueList: List.generate(
                  kExerciseTime.length,
                  (index) => ((kExerciseTime[index] /
                              (kRunningTime[index] +
                                  kJoggingTime[index] +
                                  kExerciseTime[index])) *
                          100)
                      .toInt()),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRowWidget extends StatelessWidget {
  final String title;
  final List<int> valueList;
  final bool noSum;
  const CustomRowWidget({
    super.key,
    required this.title,
    required this.valueList,
    this.noSum = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          GreyContainer(
            text: title,
            width: MediaQuery.of(context).size.width * .2,
            isLeftAligned: true,
            isBold: true,
          ),
          GreyContainer(
            text: noSum
                ? '-'
                : valueList
                    .reduce((value, element) => value + element)
                    .toString(),
            width: MediaQuery.of(context).size.width * .1,
            color: Colors.white,
          ),
          ...List.generate(
            7,
            (index) => GreyContainer(
              text: valueList[index].toString(),
              width: MediaQuery.of(context).size.width * .1,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class GreyContainer extends StatelessWidget {
  final String text;
  final double width;
  final Color? color;
  final bool isBold;
  final bool isLeftAligned;
  const GreyContainer({
    super.key,
    required this.text,
    required this.width,
    this.color,
    this.isBold = false,
    this.isLeftAligned = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: double.infinity,
      alignment: isLeftAligned ? Alignment.centerLeft : Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(5),
          color: color ?? Colors.grey.shade100),
      child: Text(
        text,
        style: TextStyle(
            color: !isBold ? null : Colors.blue,
            fontSize: MediaQuery.of(context).size.shortestSide * 0.025,
            fontWeight: !isBold ? null : FontWeight.w900),
      ),
    );
  }
}
