//
//  Feedback.swift
//  Swift MVVM Compose
//
//  Created by Jesus Luongo Lizana on 6/27/20.
//  Copyright © 2020 Jesus Luongo Lizana. All rights reserved.
//

import Foundation
import Combine

struct Feedback<State, Event> {
  let run: (AnyPublisher<State, Never>) -> AnyPublisher<Event, Never>
}

extension Feedback {
  init<Effect: Publisher>(effects: @escaping (State) -> Effect) where Effect.Output == Event, Effect.Failure == Never {
    self.run = { state -> AnyPublisher<Event, Never> in
      state
        .map { effects($0)}
        .switchToLatest()
        .eraseToAnyPublisher()
    }
  }
}
