import 'package:erouteadmin/components/mytext_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssigningDialog extends StatefulWidget {
  final TextEditingController busNamecontroller;
  final TextEditingController placeNamecontroller;
  final VoidCallback onOK;
  final VoidCallback onExit;

  AssigningDialog({
    super.key,
    required this.busNamecontroller,
    required this.placeNamecontroller,
    required this.onOK,
    required this.onExit,
  });

  @override
  State<AssigningDialog> createState() => _AssigningDialogState();
}

class _AssigningDialogState extends State<AssigningDialog> {
  List<String> allBuses = ["MONIR-1", "MONIR-2", "MONIR-3", "MONIR-4", "APORAJITA-1", "APORAJITA-2", "APORAJITA-3","3 STAR"];
  List<String> allRoutes = ["MIRPUR", "MIRPUR 10", "DHANMONDI", "ECB", "TONGI", "GAZIPUR", "UTTORA", "SAVAR", "NARAYANGANJ"];
  List<String> busSuggestions = [];
  List<String> routeSuggestions = [];

  @override
  void initState() {
    super.initState();

    // Listeners to update suggestions based on user input
    widget.busNamecontroller.addListener(() {
      setState(() {
        // Only show suggestions if the input text is not empty
        if (widget.busNamecontroller.text.isNotEmpty) {
          busSuggestions = allBuses
              .where((bus) => bus
              .toLowerCase()
              .contains(widget.busNamecontroller.text.toLowerCase()))
              .toList();
        } else {
          busSuggestions.clear();
        }
      });
    });

    widget.placeNamecontroller.addListener(() {
      setState(() {
        // Only show suggestions if the input text is not empty
        if (widget.placeNamecontroller.text.isNotEmpty) {
          routeSuggestions = allRoutes
              .where((route) => route
              .toLowerCase()
              .contains(widget.placeNamecontroller.text.toLowerCase()))
              .toList();
        } else {
          routeSuggestions.clear();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 170),
      child: SingleChildScrollView(
        child: AlertDialog(
          scrollable: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .02),
          title: const Center(child: Text('Assign Bus')),
          titleTextStyle: TextStyle(
              color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 26),
          titlePadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          backgroundColor: Colors.grey[900],
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: widget.onExit,
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
                TextButton(
                  onPressed: widget.onOK,
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
          ],
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bus name input with suggestions
              MyTextField(
                obscureText: false,
                hintText: 'Bus name',
                controller: widget.busNamecontroller,
              ),
              if (busSuggestions.isNotEmpty)
                Container(
                  color: Colors.grey[800],
                  child: Column(
                    children: busSuggestions.map((bus) {
                      return ListTile(
                        title: Text(
                          bus,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            widget.busNamecontroller.text = bus;  // Set the selected bus
                            busSuggestions.clear();  // Clear suggestions after selection
                            FocusScope.of(context).unfocus();  // Remove focus
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 10),

              // Route input with suggestions
              MyTextField(
                obscureText: false,
                hintText: 'Route',
                controller: widget.placeNamecontroller,
              ),
              if (routeSuggestions.isNotEmpty)
                Container(
                  color: Colors.grey[800],
                  child: Column(
                    children: routeSuggestions.map((route) {
                      return ListTile(
                        title: Text(
                          route,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            widget.placeNamecontroller.text = route;  // Set the selected route
                            routeSuggestions.clear();  // Clear suggestions after selection
                            FocusScope.of(context).unfocus();  // Remove focus
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
