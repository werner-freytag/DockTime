//
//  DockTimeAppDelegate.swift
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

import AppKit

class DockTimeAppDelegate: NSObject, NSApplicationDelegate {
    private var dockMenu = DockMenu()
    private var dockTilePlugin: DockTilePlugIn!

    func applicationWillFinishLaunching(_: Notification) {
        let menuItem = NSMenuItem(title: "", action: nil, keyEquivalent: "")
        menuItem.submenu = dockMenu

        NSApp.mainMenu?.addItem(menuItem)

        if Bundle.main.object(forInfoDictionaryKey: "NSDockTilePlugIn") == nil {
            dockTilePlugin = DockTilePlugIn()
            dockTilePlugin.setDockTile(NSApp.dockTile)
        }
    }

    func applicationDockMenu(_: NSApplication) -> NSMenu? {
        return dockMenu
    }
}
