
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

    // MARK: - REFRESH

    var refreshIsExecutingChanged = Reporter()
    var refreshIsExecuting = false
    {
        didSet
        {
            self.refreshIsExecutingChanged.report()
        }
    }

    func refresh()
    {
        // Ignore additional attempts if we are refreshing.
        if (self.refreshIsExecuting)
        {
            return
        }

        self.fakeLoadItem()
    }

    // MARK: - STUBS

    private func fakeLoadItem()
    {
        self.refreshIsExecuting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.item = ProfileItem("Sup3r1337Guy")
            self.refreshIsExecuting = false
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

