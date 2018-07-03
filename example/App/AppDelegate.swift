
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    // MARK: - SETUP

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        // Create main window.
        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.setupExample()

        // Configure and display main window.
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        return true
    }

    // MARK: - EXAMPLE

    private var coordinator: ProfileCoordinator!

    private func setupExample()
    {
        self.coordinator = ProfileCoordinator()
        self.window!.rootViewController = self.coordinator.rootVC

        // Refresh root VC if changed.
        self.coordinator.rootVCChanged.subscribe { [weak self] in
            guard let this = self else { return }
            this.window!.rootViewController = this.coordinator.rootVC
        }
    }

}

