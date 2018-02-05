
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - SETUP

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        // Create main window.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard
            let window = self.window
        else {
            fatalError("Could not create UIWindow!")
        }

        self.setupAppCoordinator(window: window)

        // Configure and display main window.
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        return true
    }

    // MARK: - APP COORDINATOR

    var appCoordinator: AppCoordinator!

    private func setupAppCoordinator(window: UIWindow) {
        self.appCoordinator = AppCoordinator(window: window)
    }

}

