//
//  ChatGPTController.swift
//  ChatGPT-Turbo
//
//  Created by David_ADA on 2023/03/18.
//

import Foundation
import UIKit

class ChatGptContollrer: UIViewController {
    let fileManager: FileManager = FileManager.default
    func generateConversation(completion: @escaping (String?, Error?) -> Void) {
        let urlString = "https://api.openai.com/v1/engines/davinci-codex/completions"
        let headers = ["Content-Type": "application/json",
                       "Authorization": ""]
        let parameters: [String: Any] = ["prompt": "Hello, how are you?",
                                         "max_tokens": 50,
                                         "temperature": 0.7]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let conversation = (result?["choices"] as? [[String: Any]])?[0]["text"] as? String

            completion(conversation, nil)
            print(conversation)
        }
        
        task.resume()
    }
    
    func readFile() {
        // 만든 파일 불러와서 읽기.
        do {
            let dataFromPath: Data = try Data(contentsOf: textPath) // URL을 불러와서 Data타입으로 초기화
            let text: String = String(data: dataFromPath, encoding: .utf8) ?? "문서없음" // Data to String
            print(text) // 출력
        } catch let e {
            print(e.localizedDescription)
        }
    }
    var documentPath: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    // 파일을 저장할 디렉토리 경로(URL) 반환 (경로 추가)
    var directoryPath: URL {
        return documentPath.appending(path:"내소설")
    }
    var textPath: URL {
        directoryPath.appending(path:"hi.txt")
    }
    
    
    @IBAction func chatPressed(_ sender: UIButton) {
        print(directoryPath.pathComponents)
        print(getMyNovelDirectoryFiles())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func getMyNovelDirectoryFiles() -> [String]? {
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let myNovelUrl = documentsUrl.appendingPathComponent("내소설")
        do {
            let fileUrls = try fileManager.contentsOfDirectory(at: myNovelUrl, includingPropertiesForKeys: nil)
            return fileUrls.map { $0.lastPathComponent }
        } catch {
            print("Error while enumerating files \(myNovelUrl.path): \(error.localizedDescription)")
            return nil
        }
    }


}
