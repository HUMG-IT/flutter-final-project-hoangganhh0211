import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/models/expense.dart';
import 'package:flutter_project/providers/expense_provider.dart';
import 'package:flutter_project/widgets/common/custom_text_field.dart';
import 'package:flutter_project/widgets/common/custom_button.dart';
import 'package:flutter_project/widgets/expense/category_selector.dart';
import 'package:flutter_project/utils/constants.dart';
import 'package:flutter_project/utils/validators.dart';
import 'package:flutter_project/utils/date_formatter.dart';

class AddEditExpenseScreen extends StatefulWidget {
  final Expense? expense;

  const AddEditExpenseScreen({super.key, this.expense});

  @override
  State<AddEditExpenseScreen> createState() => _AddEditExpenseScreenState();
}

class _AddEditExpenseScreenState extends State<AddEditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _titleController.text = widget.expense!.title;
      _amountController.text = widget.expense!.amount.toString();
      _descriptionController.text = widget.expense!.description ?? '';
      _selectedCategoryId = widget.expense!.categoryId;
      _selectedDate = widget.expense!.date;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.expense != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Sửa chi tiêu' : 'Thêm chi tiêu'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          children: [
            CustomTextField(
              controller: _titleController,
              label: 'Tiêu đề',
              hint: 'Nhập tiêu đề',
              validator: Validators.validateTitle,
              prefixIcon: const Icon(Icons.title),
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            CustomTextField(
              controller: _amountController,
              label: 'Số tiền',
              hint: 'Nhập số tiền',
              validator: Validators.validateAmount,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.attach_money),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            CustomTextField(
              controller: TextEditingController(
                text: DateFormatter.formatDate(_selectedDate),
              ),
              label: 'Ngày',
              readOnly: true,
              onTap: _selectDate,
              prefixIcon: const Icon(Icons.calendar_today),
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            CategorySelector(
              selectedCategoryId: _selectedCategoryId,
              onCategorySelected: (categoryId) {
                setState(() => _selectedCategoryId = categoryId);
              },
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            CustomTextField(
              controller: _descriptionController,
              label: 'Ghi chú',
              hint: 'Nhập ghi chú (tùy chọn)',
              maxLines: 3,
              prefixIcon: const Icon(Icons.note),
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            CustomButton(
              text: isEdit ? 'Cập nhật' : 'Thêm',
              onPressed: _saveExpense,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _saveExpense() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn danh mục')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final amount = double.parse(_amountController.text);
      final expense = Expense(
        id: widget.expense?.id,
        title: _titleController.text,
        amount: amount,
        categoryId: _selectedCategoryId!,
        date: _selectedDate,
        description: _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        createdAt: widget.expense?.createdAt,
      );

      if (widget.expense != null) {
        await context.read<ExpenseProvider>().updateExpense(expense);
      } else {
        await context.read<ExpenseProvider>().addExpense(expense);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.expense != null
                ? 'Cập nhật thành công'
                : 'Thêm thành công'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
