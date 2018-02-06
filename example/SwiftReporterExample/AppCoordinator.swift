
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
        // Create another VC.
        let vc = AnotherViewController()
        // Present it.
        self.mainVC.present(vc, animated: true, completion: nil)
        // Hide another VC when it asks to do so.
        // This subscription lives while another VC lives.
        vc.closeReport.subscribe { [unowned vc] in
            vc.dismiss(animated: true, completion: nil)
        }
        .disposed(by: vc.reporterBag)
    }

}

