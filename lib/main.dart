import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utip/providers/ThemeProvider.dart';
import 'package:utip/providers/TipCalculatorModel.dart';
import 'package:utip/widgets/bill_amount_feild.dart';
import 'package:utip/widgets/person_counter.dart';
import 'package:utip/widgets/tip_count.dart';
import 'package:utip/widgets/tip_slider.dart';
import 'package:utip/widgets/total_per_person.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TipCalculatorModel()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'UTip App',
      theme: themeProvider.currentTheme,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //       seedColor: const Color.fromARGB(255, 174, 163, 192)),
      //   useMaterial3: true,
      // ),
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
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TipCalculatorModel>(context);
    double total = model.totalPerPerson;
    var theme = Theme.of(context);

    final themeProvider = Provider.of<ThemeProvider>(context);
    // print("Curent Theme: ${themeProvider.currentTheme.toString()}");
    final style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);
    return Scaffold(
        appBar: AppBar(
          title: const Text('UTip'),
          actions: [
            StatefulBuilder(
              builder: (context, setState) {
                return IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.sunny
                        : Icons.nightlight_round,
                    color: const Color.fromARGB(255, 209, 201, 201),
                  ),
                  iconSize: 30.0,
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                );
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TotalPerPerson(theme: theme, style: style, total: total),
            //form
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: theme.colorScheme.primary, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      BillAmountFeild(
                        billAmount: model.billTotal.toString(),
                        onChanged: (value) => {
                          // setState(() {
                          //   _billTotal = double.parse(value);
                          // })
                          model.updateBillTotal(double.parse(value))
                        },
                      ),
                      //split build area
                      PersonCounter(
                        theme: theme,
                        personCount: model.personCount,
                        onDecrenent: () => model.decrementPersonCount(),
                        onIncrement: () => model.incrementPersonCount(),
                      ),
                      //tip counter
                      TipCount(
                          theme: theme,
                          total: total,
                          personCount: model.personCount,
                          billTotal: model.billTotal),
                      //slider section
                      TipSlider(
                        tipPercentage: model.tipPercentage,
                        onChanged: (double value) {
                          // setState(() {
                          //   _tipPercentage = value;
                          // });
                          model.updateTipPercentage(value);
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
