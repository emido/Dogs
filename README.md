## Basic read/write to filesystem using `FileManager`

 ```swift
 private func writeToFileSys() {
    let documentsDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let filePath = documentsDir.appendingPathComponent("test.txt")
    let exampleText = "Hello LHL"
    try! exampleText.write(to: filePath, atomically: true, encoding: .utf8)
  }
  
  private func readFromFileSys() {
    let documentsDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let filePath = documentsDir.appendingPathComponent("test.txt")
    guard let data = FileManager.default.contents(atPath: filePath.path) else {
      fatalError("couldn't get the data!")
    }
    guard let dataStr = String(data: data, encoding: .utf8) else {
      fatalError("no string")
    }
    print(#line, dataStr)
    
  }
  ```
