import SubstrateSdk

protocol DAppListViewProtocol: ControllerBackedProtocol {
    func didReceiveAccount(icon: DrawableIcon)
}

protocol DAppListPresenterProtocol: AnyObject {
    func setup()
    func activateAccount()
    func activateSubId()
}

protocol DAppListInteractorInputProtocol: AnyObject {
    func setup()
}

protocol DAppListInteractorOutputProtocol: AnyObject {
    func didReceive(accountIdResult: Result<AccountId, Error>)
}

protocol DAppListWireframeProtocol: AlertPresentable, ErrorPresentable, WebPresentable {
    func showWalletSelection(from view: DAppListViewProtocol?)
}
