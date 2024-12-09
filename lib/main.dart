import 'package:flutter/material.dart';
import 'package:utip/widgets/bill_amount_feild.dart';
import 'package:utip/widgets/person_counter.dart';
import 'package:utip/widgets/tip_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTip App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UTip(),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  int _personCount = 1;
  double _tipPercentage = 0.0;
  double _billTotal = 0.0;

  double totalPerPerson() {
    return ((_billTotal * _tipPercentage) + (_billTotal)) / _personCount;
  }

  //methods
  void increment() {
    setState(() {
      _personCount++;
    });
  }

  void decrement() {
    setState(() {
      if (_personCount > 1) {
        _personCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = totalPerPerson();
    var theme = Theme.of(context);
    final style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);
    return Scaffold(
        appBar: AppBar(
          title: const Text('UTip'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total per person",
                        style: style,
                      ),
                      Text(
                        "$total",
                        style: style.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontSize: theme.textTheme.displaySmall!.fontSize),
                      ),
                    ],
                  )),
            ),
            //form
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: theme.colorScheme.primary, width: 2)),
                child: Column(
                  children: [
                    BillAmountFeild(
                      billAmount: _billTotal.toString(),
                      onChanged: (value) => {
                        setState(() {
                          _billTotal = double.parse(value);
                        })
                      },
                    ),
                    //split build area
                    PersonCounter(
                      theme: theme,
                      personCount: _personCount,
                      onDecrenent: decrement,
                      onIncrement: increment,
                    ),
                    //tip counter
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tip',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          'xyz',
                          style: theme.textTheme.titleMedium,
                        )
                      ],
                    ),
                    // slider Text
                    Text(
                      '${(_tipPercentage * 100).round()}%',
                      style: theme.textTheme.titleMedium,
                    ),
                    //slider section
                    TipSlider(
                      tipPercentage: _tipPercentage,
                      onChanged: (double value) {
                        setState(() {
                          _tipPercentage = value;
                        });
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
