//
//  DockTilePlugIn.swift
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

import AppKit

class DockTilePlugIn: NSObject, NSDockTilePlugIn {
    let NOTIFICATION_NAME = "com.sympnosis.DockTime.BundleIDChanged"
    let APPLICATION_ID = "com.sympnosis.DockTime"
    let DEFAULT_BUNDLE_ID = "com.sympnosis.DockTime-ClockBundle-White"

    var dockTile: NSDockTile!

    private var _dockMenu = DockMenu()
    private var refreshTimer: Timer!
    private var lastRefreshTime: TimeInterval!

    func setDockTile(_ dockTile: NSDockTile?) {
        guard let dockTile = dockTile else { return }
        self.dockTile = dockTile

        let notificationCenter = DistributedNotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(updateCurrentClockBundle), name: Notification.Name(NOTIFICATION_NAME), object: nil)

        updateCurrentClockBundle()

        refreshTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshDockTile), userInfo: nil, repeats: true)
    }

    @objc func refreshDockTile() {
        guard lastRefreshTime == nil || floor(lastRefreshTime!) != floor(Date.timeIntervalSinceReferenceDate)
        else { return }

        lastRefreshTime = Date.timeIntervalSinceReferenceDate
        dockTile.display()
    }

    // setzt das docktile anhand des Wertes aus dem Preferences file

    @objc func updateCurrentClockBundle() {
        CFPreferencesAppSynchronize(APPLICATION_ID as CFString)

        let value = CFPreferencesCopyAppValue("BundleID" as CFString, APPLICATION_ID as CFString)
        let selectedBundleID = value == nil ? nil : value as! CFString as String

        var foundBundle: Bundle!

        if selectedBundleID != nil {
            for bundle in Bundle.allClockBundles {
                if bundle.bundleIdentifier == selectedBundleID {
                    foundBundle = bundle
                    break
                }
            }
        }

        guard foundBundle != nil else {
            CFPreferencesSetAppValue("BundleID" as CFString, DEFAULT_BUNDLE_ID as CFString, APPLICATION_ID as CFString)
            CFPreferencesAppSynchronize(APPLICATION_ID as CFString)

            DistributedNotificationCenter.default.post(name: Notification.Name(NOTIFICATION_NAME), object: nil)

            return
        }

        if let clockViewClass = foundBundle.principalClass as? NSView.Type {
            let clockView = clockViewClass.init(frame: .zero)
            dockTile.contentView = clockView
        }
    }

    func dockMenu() -> NSMenu? {
        return _dockMenu
    }
}
