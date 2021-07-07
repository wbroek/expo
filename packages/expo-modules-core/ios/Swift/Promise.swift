
public struct Promise: AnyMethodArgument {
  public typealias ResolveClosure = (Any?) -> Void
  public typealias RejectClosure = (String, String, Error?) -> Void

  public var _resolve: ResolveClosure
  public var _reject: RejectClosure

  public func resolve(_ value: Any? = nil) {
    _resolve(value)
  }

  public func reject(_ code: String, _ description: String, _ error: Error? = nil) {
    _reject(code, description, error)
  }

  public func reject(_ description: String, _ error: Error? = nil) {
    _reject("ERR", description, error)
  }

  public func reject(_ error: Error) -> Void {
    _reject("ERR", error.localizedDescription, error)
  }
}
