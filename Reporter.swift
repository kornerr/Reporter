
/*
This file is part of Reporter:
  https://github.com/kornerr/Reporter

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

/**
An object that controls subscription lifetime:
when the object is deallocated, all subscriptions get deallocated, too.
*/
public class ReporterBag
{
    
    /**
    Create ReporterBag instance.
    */
    public init() { }

    deinit
    {
        for subscription in self.subscriptions
        {
            subscription.reporter?.removeSubscription(id: subscription.id)
        }
    }

    private var subscriptions = [ReporterSubscription]()

    func addSubscription(_ subscription: ReporterSubscription)
    {
        self.subscriptions.append(subscription)
    }

}

/**
Simple no-argument closure
*/
public typealias ReporterCallback = () -> Void

/**
Internal structure to manage subscriptions.
*/
public struct ReporterSubscription
{

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

    public func disposed(by bag: ReporterBag)
    {
        bag.addSubscription(self)
    }

}

/**
An object that reports (broadcasts) to any number of subscribers.
You can think of Reporter as multidelegate pattern implementation.
*/
public class Reporter
{

    /**
    Name might be helpful in telling different instances apart
    */
    public var name: String

    /**
    Create Reporter instance.

     - parameter name: might be helpful in telling different instances apart
    */
    public init(name: String = "")
    {
        self.name = name
    }

    private var subscriptions = [String: ReporterSubscription]()
    private var oneTimeSubscriptions = [String: ReporterSubscription]()

    /**
    Report (broadcast) a change to all subscribers on the main queue
    */
    public func report()
    {
        DispatchQueue.main.async {
            for (_, subscription) in self.subscriptions
            {
                subscription.callback()
            }

            // Call one-time subscribers.
            for (_, subscription) in self.oneTimeSubscriptions
            {
                subscription.callback()
            }
            // Clear.
            self.oneTimeSubscriptions = [:]
        }
    }

    /**
    Subscribe a callback to be executed each time this instances reports (broadcasts).

    You may want to append `.disposed(by:)` to control this subscription's lifetime.
    See ReporterBag for details.

    - parameter callback: Simple no-argument closure to execute
    */
    @discardableResult
    public func subscribe(
        _ callback: @escaping ReporterCallback
    ) -> ReporterSubscription {
        let id = UUID().uuidString
        self.subscriptions[id] = ReporterSubscription(id, callback, self)
        return self.subscriptions[id]!
    }

    /**
    Subscribe a callback to be executed only once.

    You may want to append `.disposed(by:)` to control this subscription's lifetime.
    See ReporterBag for details.

    - parameter callback: Simple no-argument closure to execute
    */
    @discardableResult
    public func subscribeOnce(
        _ callback: @escaping ReporterCallback
    ) -> ReporterSubscription {
        let id = UUID().uuidString
        self.oneTimeSubscriptions[id] = ReporterSubscription(id, callback, self)
        return self.oneTimeSubscriptions[id]!
    }

    func removeSubscription(id: String)
    {
        self.subscriptions[id] = nil
    }

}

