
import UIKit

class AppCoordinator {

    // MARK: - SETUP

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.setupMainVC()
        self.setupAnotherVCPresentation()
    }

    // MARK: - MAIN VC

    private var mainVC: MainViewController!

    private func setupMainVC() {
        self.mainVC = MainViewController()
        self.window.rootViewController = mainVC
    }

    // MARK: - ANOTHER VC

    private func setupAnotherVCPresentation() {
        // Present Another VC when Main VC says so.
        // This subscription lives while application lives.
        self.mainVC.presentAnotherVCReport.subscribe { [unowned self] in
            self.presentAnotherVC()
        }
    }

    private func presentAnotherVC() {
        let vc = AnotherViewController()
        // Present another VC.
        self.mainVC.present(vc, animated: true, completion: nil)

        // TODO: Hide another VC when it asks to do so.
    }

}

