// The MIT License
//
// Copyright 2012-2019 Werner Freytag
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import AppKit
import DockTimePlugin

@NSApplicationMain
class DockTimeAppDelegate: NSObject, NSApplicationDelegate {
    private let defaultBundleIdentifier = "io.pecora.DockTime-ClockBundle-White"

    private let clockBundles = Bundle.paths(forResourcesOfType: "clockbundle", inDirectory: Bundle.main.builtInPlugInsPath!)
        .compactMap { Bundle(path: $0) }
        .sorted(by: { $0.bundleIdentifier! < $1.bundleIdentifier! })

    private lazy var clockMenuItems: [NSMenuItem] = {
        clockBundles.enumerated()
            .map { index, bundle in
                let item = NSMenuItem(title: bundle.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String, action: #selector(didSelectClockMenuItem(_:)), keyEquivalent: String(index + 1))
                item.target = self
                item.state = bundle.bundleIdentifier == UserDefaults.standard.selectedClockBundle ? .on : .off
                return item
            }
    }()

    private lazy var showSecondsMenuItem: NSMenuItem = {
        let item = NSMenuItem(title: NSLocalizedString("Show seconds", comment: "Show seconds menu item title"), action: #selector(didSelectShowSecondsMenuItem(_:)), keyEquivalent: ",")
        item.target = self
        item.state = UserDefaults.shared.showSeconds ? .on : .off
        return item
    }()

    private lazy var menu: NSMenu = {
        let menu = NSMenu(title: NSLocalizedString("Model", comment: ""))
        for item in clockMenuItems {
            menu.addItem(item)
        }
        menu.addItem(.separator())
        menu.addItem(showSecondsMenuItem)

        return menu
    }()

    private var currentClockBundle: Bundle? {
        didSet {
            guard let principalClass = currentClockBundle?.principalClass else {
                return assertionFailure("Missing principalClass for bundle \(String(describing: currentClockBundle?.bundleIdentifier)).")
            }

            guard let clockViewClass = principalClass as? NSView.Type else {
                return assertionFailure("\(String(describing: principalClass)) is not a NSView.")
            }

            NSLog("Loading \(clockViewClass) of bundle \(currentClockBundle!.bundleIdentifier!)")

            let view = clockViewClass.init(frame: .zero)
            if var bundleAware = view as? BundleAware {
                bundleAware.bundle = currentClockBundle
            }

            dockTile.contentView = view
        }
    }

    private var refreshTimer: Timer!
    private var lastRefreshTime: TimeInterval!

    private let dockTile = NSApp.dockTile

    func applicationWillFinishLaunching(_: Notification) {
        let menuItem = NSMenuItem(title: "", action: nil, keyEquivalent: "")
        menuItem.submenu = menu
        NSApp.mainMenu?.addItem(menuItem)

        currentClockBundle = clockBundles.first(where: { $0.bundleIdentifier == UserDefaults.standard.selectedClockBundle }) ??
            clockBundles.first(where: { $0.bundleIdentifier == defaultBundleIdentifier }) ??
            clockBundles.first!

        refreshTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshDockTile), userInfo: nil, repeats: true)
    }

    func applicationDockMenu(_: NSApplication) -> NSMenu? {
        return menu
    }

    @objc func didSelectClockMenuItem(_ menuItem: NSMenuItem!) {
        guard let index = clockMenuItems.firstIndex(of: menuItem) else { return }
        UserDefaults.standard.selectedClockBundle = clockBundles[index].bundleIdentifier

        for item in clockMenuItems {
            item.state = item == menuItem ? .on : .off
        }

        currentClockBundle = clockBundles[index]
        dockTile.display()
    }

    @objc func didSelectShowSecondsMenuItem(_ menuItem: NSMenuItem!) {
        let showSeconds = menuItem.state == .off
        UserDefaults.shared.showSeconds = showSeconds
        NSLog("Toggle Show Seconds: \(showSeconds)")
        menuItem.state = showSeconds ? .on : .off
    }

    @objc func refreshDockTile() {
        lastRefreshTime = Date.timeIntervalSinceReferenceDate
        dockTile.display()
    }
}
