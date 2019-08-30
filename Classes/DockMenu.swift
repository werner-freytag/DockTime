//
//  DockMenu.swift
//  DockTime
//
//  Created by Werner Freytag on 04.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

import AppKit

class DockMenu: NSMenu {
    let TAG_BASE = 100_000
    let NOTIFICATION_NAME = "com.sympnosis.DockTime.BundleIDChanged"
    let APPLICATION_ID = "com.sympnosis.DockTime"

    private let bundles = Bundle.allClockBundles

    init() {
        super.init(title: NSLocalizedString("Model", comment: ""))

        for (index, bundle) in bundles.enumerated() {
            let item = NSMenuItem(title: bundle.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String, action: #selector(setTheme), keyEquivalent: String(index))
            item.target = self
            item.tag = TAG_BASE + index
            addItem(item)
        }

        let notificationCenter = DistributedNotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(updateSelectedMenuItem), name: Notification.Name(NOTIFICATION_NAME), object: nil)

        updateSelectedMenuItem()
    }

    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func updateSelectedMenuItem() {
        CFPreferencesAppSynchronize(APPLICATION_ID as CFString)
        let value = CFPreferencesCopyAppValue("BundleID" as CFString, APPLICATION_ID as CFString)
        let selectedBundleID = value as! CFString as String

        for (index,bundle) in bundles.enumerated() {
            let isOn = bundle.bundleIdentifier == selectedBundleID
            item(withTag: TAG_BASE + index)?.state = NSControl.StateValue(isOn ? 1 : 0)
        }
    }

    @objc func setTheme(menuItem: NSMenuItem!) {
        let index = menuItem.tag - TAG_BASE
        let bundle = bundles[index]

        CFPreferencesSetAppValue("BundleID" as CFString, bundle.bundleIdentifier! as CFString, APPLICATION_ID as CFString)
        CFPreferencesAppSynchronize(APPLICATION_ID as CFString)

        updateSelectedMenuItem()

        DistributedNotificationCenter.default.post(name: Notification.Name(NOTIFICATION_NAME), object: nil)
    }
}
