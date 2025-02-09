import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/screen/loan_approval_murabaha_screen.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/screen/loan_approval_status.dart';
import 'package:intl/intl.dart';

class LoanListWidget extends StatelessWidget {
  final String id;
  final String name;
  final String amount;
  final String description;
  final String date;
  final String status;
  final IconData icon;
  final Color iconColor;
  final String? promiseToPurchaseDocument;
  final String? murabahaAgreementDocument;
  final String? agentAgreementDocument;
  final String? undertakingAgreementtDocument;
  final String? rejectionReason;

  const LoanListWidget({
    super.key,
    required this.id,
    required this.name,
    required this.amount,
    required this.description,
    required this.date,
    required this.status,
    required this.icon,
    required this.iconColor,
    required this.promiseToPurchaseDocument,
    required this.murabahaAgreementDocument,
    required this.agentAgreementDocument,
    required this.undertakingAgreementtDocument,
    required this.rejectionReason,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (status == "ACCEPTED") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoanApprovalStatus(
                        id: id,
                        name: name,
                        promisePdfUrl: promiseToPurchaseDocument!,
                        agencyPdfUrl: agentAgreementDocument!,
                      )));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => LoanApprovedScreen(
          //               name: name,
          //               amount: amount,
          //             )));
        } else if (status == "LOAN_ACCEPTED") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Loan Accepted'.tr),
              content: Text('The loan application is accepted'.tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "PENDING") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Pending'.tr),
              content: Text(
                  'The loan application is pending approval from the merchant'
                      .tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "UNDER_REVIEW") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Under Review'.tr),
              content: Text(
                  'The loan application is under review by the Bank officers'
                      .tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "MURABAHA_AGREEMENT") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoanApprovalMurabahaScreen(
                        id: id,
                        murabahaAgreementDocument: murabahaAgreementDocument!,
                      )));
        } else if (status == "UNDER_TAKING") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Under Taking'.tr),
              content: Text(
                  'The finance application is approved and will be fulfilled once the product owner confirms it.'
                      .tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "AGREEMENT_ACCEPTED") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Agreements Accepted'.tr),
              content: Text('The Finance application is now approved.'.tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "CLOSED") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Closed'.tr),
              content: Text('The finance application is closed.'.tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "REJECTED") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Rejected'.tr),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height *
                      0.7, // Max 70% of screen height
                  maxWidth: MediaQuery.of(context).size.width *
                      0.8, // Max 80% of screen width
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Makes column wrap its content
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The finance application is rejected.'.tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      if (rejectionReason != null &&
                          rejectionReason!.isNotEmpty)
                        Text(
                          rejectionReason!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'.tr),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.2),
              radius: 24,
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM. dd yyyy').format(DateTime.parse(date)),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount != ""
                      ? "ETB ${NumberFormat('#,###').format(double.parse(amount))}"
                      : "",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
