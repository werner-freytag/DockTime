// The MIT License
//
// Copyright 2012-2021 Werner Freytag
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

@NSApplicationMain
class DockTimeAppDelegate: NSObject, NSApplicationDelegate {
    private let defaultBundleIdentifier = "io.pecora.DockTime-ClockBundle-BigSur"

    private let clockBundles = Bundle.paths(forResourcesOfType: "clockbundle", inDirectory: Bundle.main.builtInPlugInsPath!)
        .compactMap { Bundle(path: $0) }
        .sorted(by: { $0.bundleName! < $1.bundleName! })
        .filter {
            guard let principalClass = $0.principalClass else {
                assertionFailure("Missing principalClass for bundle \(String(describing: $0.bundleIdentifier)).")
                return false
            }

            guard let clockViewClass = principalClass as? NSView.Type else {
                assertionFailure("\(String(describing: principalClass)) is not an NSView.")
                return false
            }
            return true
        }

    private var updateInterval = UpdateInterval.second {
        didSet {
            lastRefreshDate = nil
        }
    }

    private lazy var clockMenuItems: [NSMenuItem] = {
        clockBundles.enumerated()
            .map { index, bundle in
                let keyEquivalent: String = {
                    switch index {
                    case 0 ..< 9: return String(index + 1)
                    case 9: return "0"
                    default: return ""
                    }
                }()

                let item = NSMenuItem(title: bundle.bundleName!, action: #selector(didSelectClockMenuItem(_:)), keyEquivalent: keyEquivalent)
                item.target = self
                item.state = bundle.bundleIdentifier == currentClockBundle?.bundleIdentifier ? .on : .off
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
            guard let clockBundle = currentClockBundle, let clockViewClass = clockBundle.principalClass as? NSView.Type else {
                return assertionFailure()
            }

            NSLog("Loading \(clockViewClass) of bundle \(clockBundle.bundleIdentifier!)")

            let updateIntervalString = clockBundle.object(forInfoDictionaryKey: "DTUpdateInterval") as? String ?? ""
            updateInterval = UpdateInterval(updateIntervalString) ?? .second

            dockTile.contentView = clockViewClass.init(frame: .zero)
        }
    }

    private var refreshTimer: Timer!

    private var lastRefreshDate: Date?

    private let dockTile = NSApp.dockTile

    func applicationWillFinishLaunching(_: Notification) {
        currentClockBundle = clockBundles.first(where: { $0.bundleIdentifier == UserDefaults.standard.selectedClockBundle }) ??
            clockBundles.first(where: { $0.bundleIdentifier == defaultBundleIdentifier }) ??
            clockBundles.first!

        refreshTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshDockTile), userInfo: nil, repeats: true)

        let menuItem = NSMenuItem(title: "", action: nil, keyEquivalent: "")
        menuItem.submenu = menu
        NSApp.mainMenu?.addItem(menuItem)
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
        lastRefreshDate = nil
    }

    var requiresRefresh: Bool {
        let date = Date()
        defer {
            lastRefreshDate = date
        }

        guard let lastRefreshDate = lastRefreshDate else { return true }

        let calendar = Calendar.current

        switch updateInterval {
        case .minute:
            return calendar.dateComponents([.hour, .minute], from: date) != calendar.dateComponents([.hour, .minute], from: lastRefreshDate)
        case .second:
            return calendar.dateComponents([.hour, .minute, .second], from: date) != calendar.dateComponents([.hour, .minute, .second], from: lastRefreshDate)
        case .continual:
            return true
        }
    }

    @objc func refreshDockTile() {
        guard requiresRefresh else { return }
        dockTile.display()
    }
}
