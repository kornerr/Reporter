
import UIKit

class ProfileVC: UIViewController
{

    let presentDestinationVC = Reporter()
    
    @IBAction func present(_ sender: Any)
    {
        // Report outside.
        self.presentDestinationVC.report()
    }
    
}

