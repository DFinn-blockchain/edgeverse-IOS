import SoraFoundation

protocol ControllerAccountViewProtocol: ControllerBackedProtocol, Localizable {
    func reload(with viewModel: ControllerAccountViewModel)
}

protocol ControllerAccountViewModelFactoryProtocol: AnyObject {
    func createViewModel(
        stashItem: StashItem,
        stashAccountItem: ChainAccountResponse?,
        chosenAccountItem: ChainAccountResponse?
    ) -> ControllerAccountViewModel
}

protocol ControllerAccountPresenterProtocol: AnyObject {
    func setup()
    func handleStashAction()
    func handleControllerAction()
    func selectLearnMore()
    func proceed()
}

protocol ControllerAccountInteractorInputProtocol: AnyObject {
    func setup()
    func estimateFee(for account: ChainAccountResponse)
    func fetchLedger(controllerAddress: AccountAddress)
    func fetchControllerAccountInfo(controllerAddress: AccountAddress)
}

protocol ControllerAccountInteractorOutputProtocol: AnyObject {
    func didReceiveStashItem(result: Result<StashItem?, Error>)
    func didReceiveStashAccount(result: Result<ChainAccountResponse?, Error>)
    func didReceiveControllerAccount(result: Result<ChainAccountResponse?, Error>)
    func didReceiveAccounts(result: Result<[ChainAccountResponse], Error>)
    func didReceiveFee(result: Result<RuntimeDispatchInfo, Error>)
    func didReceiveAccountInfo(result: Result<AccountInfo?, Error>, address: AccountAddress)
    func didReceiveStakingLedger(result: Result<StakingLedger?, Error>)
}

protocol ControllerAccountWireframeProtocol: WebPresentable,
    AddressOptionsPresentable,
    AccountSelectionPresentable,
    StakingErrorPresentable,
    AlertPresentable,
    ErrorPresentable {
    func showConfirmation(
        from view: ControllerBackedProtocol?,
        controllerAccountItem: ChainAccountResponse
    )
    func close(view: ControllerBackedProtocol?)
}
