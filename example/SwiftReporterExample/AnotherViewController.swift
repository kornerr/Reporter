
import UIKit

class AnotherViewController: UIViewController {

    // MARK: - SETUP

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - CLOSE
    
    // Report to the outside world that VC wants out using this variable.
    let closeReport = Reporter()
    
    // React to button click.
    @IBAction func close(_ sender: Any) {
        // Report to the outside world that VC wants out.
        self.closeReport.report()
    }
    
}

