//
//  ChatGPT_TurboTests.swift
//  ChatGPT-TurboTests
//
//  Created by David_ADA on 2023/03/14.
//

import XCTest
@testable import ChatGPT_Turbo

final class ChatGPT_TurboTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func setUp() async throws {
        
    }
    
    override class func tearDown() {
        
    }
    
    func testIncrementCounter() {
        let counter = Counter()
        counter.increment()
        
        XCTAssertEqual(counter.counter, 1, "Counter was not incremented: \(counter)")
    }
    
    
    func testCreateDirectory(fileName:String) throws {
        do {
            let fileManager: FileManager = FileManager.default
            let documentPath: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let directoryPath: URL = documentPath.appendingPathComponent(fileName)
            try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false, attributes: nil)
        }  catch let e {
            print(e.localizedDescription)
        }
    }
    
    
    

}
