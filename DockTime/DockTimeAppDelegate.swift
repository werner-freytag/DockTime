//
//  DockTimeAppDelegate.swift
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

import AppKit

@NSApplicationMain
class DockTimeAppDelegate: NSObject, NSApplicationDelegate {
    private let defaultBundleIdentifier = "io.pecora.DockTime-ClockBundle-White"

    private let clockBundles = Bundle.paths(forResourcesOfType: "clockbundle", inDirectory: Bundle.main.builtInPlugInsPath!).compactMap { Bundle(path: $0) }

    private lazy var clockMenuItems: [NSMenuItem] = {
        clockBundles.enumerated().map { index, bundle in
            let item = NSMenuItem(title: bundle.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String, action: #selector(didSelectClockMenuItem(_:)), keyEquivalent: String(index))
            item.target = self
            item.state = bundle.bundleIdentifier == UserDefaults.standard.selectedClockBundle ? .on : .off
            return item
        }
    }()

    private lazy var menu: NSMenu = {
        let menu = NSMenu(title: NSLocalizedString("Model", comment: ""))
        for item in clockMenuItems {
            menu.addItem(item)
        }
        return menu
    }()

    private var currentClockBundle: Bundle? {
        didSet {
            guard let clockViewClass = currentClockBundle?.principalClass as? NSView.Type else { return assertionFailure() }

            dockTile.contentView = clockViewClass.init(frame: .zero)
        }
    }

    private var refreshTimer: Timer!
    private var lastRefreshTime: TimeInterval!

    private let dockTile = NSApp.dockTile

    override init() {
        super.init()

        if UserDefaults.standard.selectedClockBundle == nil {
            UserDefaults.standard.selectedClockBundle = clockBundles.first!.bundleIdentifier!
        }
    }

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

    @objc func refreshDockTile() {
        guard lastRefreshTime == nil || floor(lastRefreshTime!) < floor(Date.timeIntervalSinceReferenceDate) else { return }

        lastRefreshTime = Date.timeIntervalSinceReferenceDate
        dockTile.display()
    }
}
