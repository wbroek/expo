
import Foundation

@objc
public class SwiftInteropBridge: NSObject {
  let registry: ModuleRegistry

  @objc
  public init(modulesProvider: ModulesProviderObjCProtocol) {
    self.registry = ModuleRegistry(withProvider: modulesProvider as! ModulesProviderProtocol)
    super.init()
  }

  @objc
  public func hasModule(_ moduleName: String) -> Bool {
    return registry.has(moduleWithName: moduleName)
  }

  @objc
  public func callMethod(_ methodName: String,
                         onModule moduleName: String,
                         withArgs args: [Any],
                         resolve: @escaping EXPromiseResolveBlock,
                         reject: @escaping EXPromiseRejectBlock) {
    let promise = Promise(_resolve: resolve, _reject: reject)
    registry
      .get(moduleHolderForName: moduleName)?
      .call(method: methodName, args: args, promise: promise)
  }

  @objc
  public func exportedMethodNames() -> [String: [[String: Any]]] {
    var constants = [String: [[String: Any]]]()

    for holder in registry {
      var index = -1

      constants[holder.name] = holder.definition.methods.map({ (methodName, method) in
        index += 1
        return [
          "name": methodName,
          "argumentsCount": method.argumentsCount,
          "key": methodName,
        ]
      })
    }
    return constants
  }

  @objc
  public func exportedModulesConstants() -> [String: Any] {
    return registry.reduce(into: [String: Any]()) { acc, holder in
      acc[holder.name] = holder.definition.constants
    }
  }
}
