import 'package:flutter/material.dart';
import 'package:project_tpm1/controllers/uang_control.dart';
import 'package:project_tpm1/model/uang_model.dart';

class KonversiUang extends StatefulWidget {
  @override
  _KonversiUangState createState() => _KonversiUangState();
}

class _KonversiUangState extends State<KonversiUang> {
  final TextEditingController _amountController = TextEditingController();
  Currency _fromCurrency = Currency.IDR;
  Currency _toCurrency = Currency.USD;
  String _result = '';
  final CurrencyConversionController _controller = CurrencyConversionController();

  void _convertCurrency() {
    double? amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      setState(() {
        _result = 'Must enter a positive number.';
      });
      return;
    }

    try {
      double convertedAmount = _controller.convertCurrency(
        fromCurrency: _fromCurrency,
        toCurrency: _toCurrency,
        amount: amount,
      );
      setState(() {
        _result = 'Converted Amount: ${convertedAmount.toStringAsFixed(2)} ${_toCurrency.toString().split('.').last}';
      });
    } catch (e) {
      setState(() {
        _result = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Conversion',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCurrencyDropdown('From Currency', _fromCurrency, (newValue) {
              setState(() {
                _fromCurrency = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildAmountTextField(),
            SizedBox(height: 16),
            _buildCurrencyDropdown('To Currency', _toCurrency, (newValue) {
              setState(() {
                _toCurrency = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildConvertButton(),
            SizedBox(height: 16),
            _buildResultCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(String labelText, Currency value, ValueChanged<Currency?> onChanged) {
    return DropdownButtonFormField<Currency>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money),
      ),
      items: Currency.values.map((Currency currency) {
        return DropdownMenuItem<Currency>(
          value: currency,
          child: Text(currency.toString().split('.').last),
        );
      }).toList(),
    );
  }

  Widget _buildAmountTextField() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Amount',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.attach_money),
      ),
    );
  }

  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convertCurrency,
      child: Text('Convert'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      color: Colors.redAccent[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          _result,
          style: TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
