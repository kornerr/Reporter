
/*
Copyright (C) 2018 Michael Kapelko <kornerr@gmail.com>

This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
*/

import Foundation

// Reporter bag controls life time of subscriptions:
// subscriptions of a bag are removed when the bag is deallocated.
public class ReporterBag {
    
    public init() { }

    deinit {
        for sub in self.subscriptions {
            sub.reporter?.removeSubscription(id: sub.id)
        }
    }

    private var subscriptions = [ReporterSubscription]()

    public func addSubscription(_ subscription: ReporterSubscription) {
        self.subscriptions.append(subscription)
    }

}

public typealias ReporterCallback = () -> Void

public struct ReporterSubscription {

    let id: String
    let callback: ReporterCallback
    weak var reporter: Reporter?

    init(
        _ id: String,
        _ callback: @escaping ReporterCallback,
        _ reporter: Reporter?
    ) {
        self.id = id
        self.callback = callback
        self.reporter = reporter
    }

    public func disposed(by bag: ReporterBag) {
        bag.addSubscription(self)
    }

}

// Reporter reports (broadcasts) to any number of subscriptions.
public class Reporter {

    public var name: String

    public init(name: String = "Noname") {
        self.name = name
    }

    private var subscriptions = [String: ReporterSubscription]()

    public func report() {
        let subs = self.subscriptions
        for (_, sub) in subs {
            sub.callback()
        }
    }

    @discardableResult
    public func subscribe(
        _ callback: @escaping ReporterCallback
    ) -> ReporterSubscription {
        let id = UUID().uuidString
        self.subscriptions[id] = ReporterSubscription(id, callback, self)
        return self.subscriptions[id]!
    }

    public func removeSubscription(id: String) {
        self.subscriptions[id] = nil
    }

}

