part of 'loan_approval_status_bloc.dart';

@immutable
sealed class LoanApprovalStatusEvent {}

final class FetchLoanApprovalStatusList extends LoanApprovalStatusEvent {
  FetchLoanApprovalStatusList();
}

final class OfferedProductsPriceFetch extends LoanApprovalStatusEvent {
  final String id;
  OfferedProductsPriceFetch({required this.id});
}

final class AcceptOffer extends LoanApprovalStatusEvent {
  final String id;
  final String status;
  final List<OfferedProductsPriceModel>? productList;
  AcceptOffer({required this.id, required this.status, this.productList});
}