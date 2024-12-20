import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/loan_approval_status/bloc/loan_approval_status_bloc.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/all_applications.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/approved_applicatins.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/new_applications.dart';

class LoanListScreen extends StatefulWidget {
  const LoanListScreen({super.key});

  @override
  State<LoanListScreen> createState() => _LoanListScreenState();
}

class _LoanListScreenState extends State<LoanListScreen> {
  final _selectedSegment = ValueNotifier('new');
  List<StatusProductListModel> _loanList = [];

  @override
  void initState() {
    super.initState();
    _fetchLoanList();
  }

  void _fetchLoanList() {
    context.read<LoanApprovalStatusBloc>().add(FetchLoanApprovalStatusList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Loan Requests",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocListener<LoanApprovalStatusBloc, LoanApprovalStatusState>(
        listener: (context, state) {
          if (state is LoanApprovalListFetchedLoading) {
            // Show loading indicator if needed
          } else if (state is LoanApprovalListFetchedSuccess) {
            setState(() {
              _loanList = state.productList;
            });
          } else if (state is LoanApprovalListFetchedFailure) {
            // Show error message
            displaySnack(context, state.errorMessage, Colors.red);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Column(
              children: [
                Text(
                  "Fill a Form",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // _buildLabel('Multiple Items'),
                    AdvancedSegment(
                      activeStyle: const TextStyle(
                          color: AppColors.bgColor,
                          fontWeight: FontWeight.w700),
                      inactiveStyle: const TextStyle(
                          color: AppColors.bgColor,
                          fontWeight: FontWeight.w500),
                      itemPadding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      backgroundColor: AppColors.iconColor,
                      sliderColor: AppColors.primaryDarkColor,
                      controller: _selectedSegment,
                      segments: const {
                        'new': 'New',
                        'all': 'All',
                        'approved': 'Approved',
                      },
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder<String>(
                      valueListenable: _selectedSegment,
                      builder: (_, selectedSegment, __) {
                        if (selectedSegment == 'new') {
                          return NewLoanApplications(
                            loanformList: _loanList,
                          );
                        } else if (selectedSegment == 'all') {
                          return AllLoanApplications(
                            loanformList: _loanList,
                          );
                        } else if (selectedSegment == 'approved') {
                          return ApprovedLoanApplicatins(
                            loanformList: _loanList,
                          );
                        }
                        return const SizedBox
                            .shrink(); // Empty widget if no match
                      },
                    ),
                    // SizedBox(
                    //   height: 100,
                    //   child: ListView(
                    //     children: loanformList.map((transaction) {
                    //       return LoanListScreenWidget(
                    //         name: transaction["name"],
                    //         amount: transaction["amount"],
                    //         description: transaction["description"],
                    //         date: transaction["date"],
                    //         icon: transaction["icon"],
                    //         iconColor: transaction["iconColor"],
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
