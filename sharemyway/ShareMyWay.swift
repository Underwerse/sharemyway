//
//  sharemywayApp.swift
//  sharemyway
//
//  Created by Pavel Chernov on 13.11.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()

    return true
  }
}

@main
struct ShareMyWay: App {
    
    // CoreData object
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
