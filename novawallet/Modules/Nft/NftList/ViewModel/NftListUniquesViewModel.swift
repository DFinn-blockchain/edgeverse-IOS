import Foundation
import RobinHood
import SubstrateSdk

final class NftListUniquesViewModel {
    let metadataReference: String
    let metadataService: NftFileDownloadServiceProtocol

    private var loadingOperation: CancellableCall?

    init(
        metadataReference: String,
        metadataService: NftFileDownloadServiceProtocol
    ) {
        self.identifier = identifier
        self.metadataReference = metadataReference
        self.metadataService = metadataService
    }

    func provideData(from json: JSON, to view: NftListItemViewProtocol) {
        let name = json.name?.stringValue
        view.setName(name)

        let label = json.label?.stringValue
        view.setName(label)
    }

    private func handle(result: Result<JSON, Error>, on view: NftListItemViewProtocol, completion: ((Error?) -> Void)?) {
        switch result {
        case let .success(json):
            provideData(from: json, to: view)
            completion?(nil)
        case let .failure(error):
            completion?(error)
        }
    }
}

extension NftListUniquesViewModel: NftListMetadataViewModelProtocol {
    func load(on view: NftListItemViewProtocol, completion: ((Error?) -> Void)?) {
        guard loadingOperation == nil else {
            return
        }

        let mediaViewModel = NftMediaViewModel(
            metadataReference: metadataReference,
            downloadService: metadataService
        )

        view.setMedia(mediaViewModel)

        loadingOperation = metadataService.downloadMetadata(
            for: metadataReference,
            dispatchQueue: .main
        ) { [weak self, weak view] result in
            guard self?.loadingOperation != nil else {
                return
            }

            self?.loadingOperation = nil

            guard let strongView = view else {
                return
            }

            self?.handle(result: result, on: strongView, completion: completion)
        }
    }

    func cancel(on view: NftListItemViewProtocol) {
        let operationToCancel = loadingOperation
        loadingOperation = nil
        operationToCancel?.cancel()
    }
}
