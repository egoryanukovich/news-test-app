//
//  Coordinator.swift
//  
//
//  Created by Egor Yanukovich on 19.08.24.
//

import Foundation

@MainActor
public protocol Coordinator: AnyObject {
  var finishAction: (() -> Void)? { get set }
  func start()
}
