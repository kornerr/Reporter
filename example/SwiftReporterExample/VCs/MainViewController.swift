
import SwiftReporter
import UIKit

class MainViewController: UIViewController {

    // MARK: - SETUP

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - PRESENT ANOTHER VC
    
    // Report to the outside world that VC wants to present another VC
    // using this variable.
    let presentAnotherVCReport = Reporter()
    
    // React to button click.
    @IBAction func presentAnotherVC(_ sender: Any) {
        // Report to the outside world that VC wants to present another VC.
        self.presentAnotherVCReport.report()
    }
    
}

