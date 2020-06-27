//
//  View+Ext.swift
//  Swift MVVM Compose
//
//  Created by Jesus Luongo Lizana on 6/27/20.
//  Copyright © 2020 Jesus Luongo Lizana. All rights reserved.
//

import SwiftUI

extension View {
  func eraseToAnyView() -> AnyView { AnyView(self) }
}
