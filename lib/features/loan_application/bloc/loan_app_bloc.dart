import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/loan_application/data/repository/loan_app_repository.dart';
import 'package:ifb_loan/features/loan_application/models/products_request_model.dart';
part 'loan_app_event.dart';
part 'loan_app_state.dart';

class LoanAppBloc extends Bloc<LoanAppEvent, LoanAppState> {
  final LoanAppRepository loanAppRepository;
  List<Map<String, String>> myProviders = [];
  LoanAppBloc(this.loanAppRepository) : super(LoanAppInitial()) {
    on<SectorsFetch>(_fetchSectors);
    on<RepaymentsFetch>(_fetchRepayments);
    on<UnitofMeasurementsFetch>(_fetchUnitofMeasurements);
    on<UpdateProvidersEvent>(_updateProviders);
    on<ProductsRequestSent>(_sentProductsRequest);
  }

  void _fetchSectors(SectorsFetch event, Emitter<LoanAppState> emit) async {
    emit(SectorFetchLoading());
    try {
      final sectors = await loanAppRepository.fetchSectors();
      emit(SectorFetchSuccess(sectors: sectors));
    } catch (e) {
      emit(SectorFetchFailure(e.toString()));
    }
  }

  void _fetchRepayments(
      RepaymentsFetch event, Emitter<LoanAppState> emit) async {
    emit(RepaymentFetchLoading());
    try {
      final repayment = await loanAppRepository.fetchRepayment();
      emit(RepaymentFetchSuccess(repayments: repayment));
    } catch (e) {
      emit(RepaymentFetchFailure(e.toString()));
    }
  }

  void _fetchUnitofMeasurements(
      UnitofMeasurementsFetch event, Emitter<LoanAppState> emit) async {
    emit(UnitofMeasurementsFetchLoading());
    try {
      final unitofMeasurements =
          await loanAppRepository.fetchtUnitofMeasurement();
      emit(UnitofMeasurementsFetchSuccess(
          unitofMeasurement: unitofMeasurements));
    } catch (e) {
      emit(UnitofMeasurementsFetchFailure(e.toString()));
    }
  }

  void _sentProductsRequest(
      ProductsRequestSent event, Emitter<LoanAppState> emit) async {
    emit(ProductsSentLoading());
    try {
      // final unitofMeasurements =
      await loanAppRepository.sendProductRequest(event.products);
      emit(ProductsSentSuccess());
    } catch (e) {
      emit(ProductsSentFailure(e.toString()));
    }
  }

  void _updateProviders(
      UpdateProvidersEvent event, Emitter<LoanAppState> emit) {
    myProviders = event.providers; // Update providers list
    emit(ProvidersUpdatedState(providers: myProviders)); // Emit updated state
  }
}
