/**
 Represents a listener for the specific event.
 */
internal struct EventListener: AnyDefinition {
  let name: EventName
  let call: (Any?) -> Void

  init(_ name: EventName, listener: @escaping () -> Void) {
    self.name = name
    self.call = { payload in listener() }
  }

  init<PayloadType>(_ name: EventName, listener: @escaping (PayloadType?) -> Void) {
    self.name = name
    self.call = { payload in listener(payload as? PayloadType) }
  }
}

internal enum EventName: Equatable {
  case clientAppBackgrounded
  case clientAppForegrounded
  case custom(_ name: String)
}
