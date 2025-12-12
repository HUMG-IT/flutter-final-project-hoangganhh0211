import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/expense_provider.dart';
import 'package:flutter_project/widgets/common/loading_widget.dart';
import 'package:flutter_project/widgets/common/empty_state_widget.dart';
import 'package:flutter_project/widgets/expense/expense_card.dart';
import 'package:flutter_project/widgets/statistics/summary_card.dart';
import 'package:flutter_project/utils/constants.dart';
import 'package:flutter_project/utils/currency_formatter.dart';
import 'package:flutter_project/config/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseProvider>().loadExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
          if (expenseProvider.isLoading) {
            return const LoadingWidget();
          }

          final expenses = expenseProvider.expenses;
          final totalAmount = expenseProvider.totalAmount;

          return RefreshIndicator(
            onRefresh: () => expenseProvider.loadExpenses(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SummaryCard(
                                title: 'Tổng chi tiêu',
                                value: CurrencyFormatter.format(totalAmount),
                                icon: Icons.account_balance_wallet,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Expanded(
                              child: SummaryCard(
                                title: 'Giao dịch',
                                value: '${expenses.length}',
                                icon: Icons.receipt_long,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.paddingLarge),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Giao dịch gần đây',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Xem tất cả'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (expenses.isEmpty)
                  const SliverFillRemaining(
                    child: EmptyStateWidget(
                      message: 'Chưa có giao dịch nào',
                      icon: Icons.receipt_long_outlined,
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final expense = expenses[index];
                        return ExpenseCard(
                          expense: expense,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.expenseDetail,
                              arguments: expense,
                            );
                          },
                          onEdit: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.editExpense,
                              arguments: expense,
                            );
                          },
                          onDelete: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Xác nhận'),
                                content: const Text('Bạn có chắc muốn xóa?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Hủy'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Xóa'),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await expenseProvider.deleteExpense(expense.id);
                            }
                          },
                        );
                      },
                      childCount: expenses.length,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addExpense);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.statistics);
          } else if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.profile);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Thống kê',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}
