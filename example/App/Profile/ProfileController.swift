
import UIKit

class ProfileController
{

    // MARK: - PROFILE ITEM

    var itemChanged = Reporter()
    var item: ProfileItem?
    {
        didSet
        {
            self.itemChanged.report()
        }
    }

    // MARK: - LOADING

    var isLoadingChanged = Reporter()
    var isLoading = false
    {
        didSet
        {
            self.isLoadingChanged.report()
        }
    }

    func load()
    {
        // Ignore additional attempts if we are already loading.
        if (self.isLoading)
        {
            return
        }
        self.fakeLoadItem()
    }

    // MARK: - STUBS

    private func fakeLoadItem()
    {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.item = ProfileItem("Sup3r1337Guy")
            self.isLoading = false
            self.fakeLoadImage()
        }
    }

    private func fakeLoadImage()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let nowItem = self.item else { return }
            var item = ProfileItem(nowItem.username)
            item.image = UIImage(named: "race.hanar.png")!
            self.item = item
        }
    }

}

