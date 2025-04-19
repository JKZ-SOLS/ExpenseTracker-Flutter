import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker/utils/app_colors.dart';



class AddTransactionScreen extends StatefulWidget {
  final bool isIncome; // true for Income, false for Expense
  const AddTransactionScreen({super.key, this.isIncome = false});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool isIncome = false;
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedCategory;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    isIncome = widget.isIncome;
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.green,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
     const Color green = AppColors.green;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Add Transaction', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.greenAccent),
            onPressed: () {
              // handle voice input here
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Transaction Type", style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 10),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isIncome = false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isIncome ? green : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: Text('Expense', style: TextStyle(color: !isIncome ? Colors.black : Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isIncome = true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isIncome ? green : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: Text('Income', style: TextStyle(color: isIncome ? Colors.black : Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildInputField("Amount (PKR)", "Rs. 0.00", amountController, TextInputType.number),
            const SizedBox(height: 15),

            _buildDropdownField("Category", ["Salary", "Bonus", "Freelance", "Other"]),
            const SizedBox(height: 15),

            _buildInputField("Description", "Enter description", descriptionController),
            const SizedBox(height: 15),

            const Text("Date", style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () => _pickDate(context),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: green),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat('dd/MM/yyyy').format(selectedDate),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Save logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text("Save Transaction", style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, [TextInputType? type]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.greenAccent),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            value: selectedCategory,
            dropdownColor: Colors.black,
            isExpanded: true,
            underline: const SizedBox(),
            hint: const Text("Select a category", style: TextStyle(color: Colors.greenAccent)),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (value) => setState(() => selectedCategory = value),
          ),
        ),
      ],
    );
  }
}


