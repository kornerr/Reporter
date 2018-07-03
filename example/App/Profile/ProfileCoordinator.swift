
import UIKit

class ProfileCoordinator
{
    
    var rootVC: UIViewController!
    let rootVCChanged = Reporter()

    var profileVC: ProfileVC!
    var profileController: ProfileController!

    init()
    {
        let vcId = "ProfileVC"
        let storyboard = UIStoryboard(name: vcId, bundle: nil)
        self.profileVC = storyboard.instantiateViewController(withIdentifier: vcId) as! ProfileVC
        self.rootVC = self.profileVC
        self.profileController = ProfileController()

        // Set loading state while profile is refreshing.
        self.profileController.refreshIsExecutingChanged.subscribe { [weak self] in
            guard let this = self else { return }
            this.profileVC.isLoading = this.profileController.refreshIsExecuting
        }

        // Update displayed profile item when it's updated.
        self.profileController.itemChanged.subscribe { [weak self] in
            guard
                let this = self,
                let item = this.profileController.item
            else
            {
                return
            }
            this.profileVC.item = item
        }

        // Refresh profile.
        self.profileController.refresh()
    }

}

