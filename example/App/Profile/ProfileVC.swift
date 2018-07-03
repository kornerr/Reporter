
import UIKit

class ProfileVC: UIViewController
{

    // MARK: - SETUP

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.updateLoading()
    }

    // MARK: - LOADING

    @IBOutlet private var loadingView: UIView?

    var isLoading = false
    {
        didSet
        {
            self.updateLoading()
        }
    }

    private func updateLoading()
    {
        self.loadingView?.isHidden = !self.isLoading
    }

    // MARK: - PROFILE ITEM

    @IBOutlet private var imageView: UIImageView?
    @IBOutlet private var usernameValueLabel: UILabel?
    
    var item = ProfileItem("")
    {
        didSet
        {
            self.usernameValueLabel?.text = self.item.username
            self.imageView?.image = self.item.image
        }
    }
    
}
