import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  String selected = "";
  double totalInterest = 0;
  double monthlyInterest = 0;
  double montlyInstallment = 0;

  void loancalculation() {
    final amount = int.parse(_controller1.text) - int.parse(_controller2.text);
    final tinterest =
        amount * (double.parse(_controller3.text) / 100) * int.parse(selected);
    final mininterest = tinterest / (int.parse(selected) * 12);
    final minstall = (amount + tinterest) / (int.parse(selected) * 12);

    setState(() {
      totalInterest = tinterest;
      monthlyInterest = mininterest;
      montlyInstallment = minstall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.notes,
          size: 38,
          color: Colors.black,
        ),
        toolbarHeight: 30,
        backgroundColor: Colors.yellow,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.info,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      color: Colors.green[100],
      child: Column(
        children: [
          Container(
            height: 170,
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Car Loan",
                        //style: GoogleFonts.robotoMono(fontSize: 35),
                        style: GoogleFonts.robotoMono(fontSize: 35),
                      ),
                      Text(
                        "Calculator",
                        style: GoogleFonts.robotoMono(fontSize: 35),
                      ),
                    ]),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputForm(
                    title: "Price",
                    hint: "e.g 3500000",
                    controller: _controller1),
                inputForm(
                    title: "Down Payment",
                    hint: "e.g 9000",
                    controller: _controller2),
                inputForm(
                    title: "Interest rate",
                    hint: "e.g 3.5",
                    controller: _controller3),
                Text(
                  "Loan Period",
                  style: GoogleFonts.robotoMono(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    loanPeriod("1"),
                    loanPeriod("2"),
                    loanPeriod("3"),
                    loanPeriod("4"),
                    loanPeriod("5")
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    loanPeriod("6"),
                    loanPeriod("7"),
                    loanPeriod("8"),
                    loanPeriod("9"),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    loancalculation();
                    Future.delayed(Duration.zero);
                    showModalBottomSheet(
                        isDismissible: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 400,
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20, 30, 0, 0), // change
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Result",
                                    style: GoogleFonts.robotoMono(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  result(
                                      title: "Total Interest",
                                      amount: totalInterest),
                                  result(
                                      title: "Montrly Interest",
                                      amount: monthlyInterest),
                                  result(
                                      title: "Total Installment",
                                      amount: montlyInstallment),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Center(
                                          child: Text(
                                            "Recalculate",
                                            style: GoogleFonts.robotoMono(
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        "Calculate",
                        style: GoogleFonts.robotoMono(fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget result({required String title, required double amount}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Text(
          "RM${amount.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 19),
        ),
      ),
    );
  }

  Widget loanPeriod(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = title;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 20, 0),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            border: title == selected
                ? Border.all(color: Colors.red, width: 2)
                : null,
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }

  Widget inputForm(
      {required String title,
      required String hint,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.robotoMono(fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: hint,
              )),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
