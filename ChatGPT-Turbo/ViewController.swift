//
//  ViewController.swift
//  ChatGPT-Turbo
//
//  Created by David_ADA on 2023/03/14.
//
let categorizes = [
"Mystery", "Thriller", "Horror Fiction", "science fiction", "Fantasy Fiction", "Martial Arts Fiction", "Game Novel", "Romance Novels"]
import UIKit
// MARK: 입력버튼으로 제목과 내용을 입력하고 add 버튼으로 tag 를 추가할수있는 UI구성

class ViewController: UIViewController{
    
    //MARK: UI인터페이스 입력
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var plotTextView: UITextView!
    
    @IBOutlet weak var keywordPicker: UIPickerView!
    
    @IBOutlet weak var keywordLabel: UILabel!
    var keywords:[String] = []
    var keyword:String = "Mystery"
    //MARK: FileManger Create, Read, Write
    
    let fileManger: FileManager = FileManager.default
    
    var documentPath: URL {
        fileManger.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func writeNovelToFileManager(title:String, plot:String, keywords:[String]) {
        
        let directoryPath = documentPath.appending(path:"내소설")
        
        do {
            try fileManger.createDirectory(at: directoryPath, withIntermediateDirectories: false, attributes: nil)
        } catch let e {
            print(e.localizedDescription)
        }
        
        let textPath = directoryPath.appending(path: "\(title)")
        
        if let data: Data = "\(keywords) \n \(plot)".data(using: String.Encoding.utf8) { // String to Data
            do {
                try data.write(to: textPath) // 위 data를 "hi.txt"에 쓰기
            } catch let e {
                print(e.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.backgroundColor = .gray
        titleTextField.text = "제목을 입력해주세요"
        plotTextView.text = "스토리를 입력해주세요"
        keywordLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func keywordAdd(_ sender: UIButton) {
        keywords.append(keyword)
        self.keywordLabel.text! += "\(keyword),"
    }
    
    
    @IBAction func writeNovel(_ sender: UIButton) {
        guard let title = titleTextField.text else { return }
        guard let plot = plotTextView.text else { return }
        
        writeNovelToFileManager(title: title, plot: plot, keywords: keywords)
        print(documentPath)
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categorizes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categorizes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.keyword = categorizes[row]
    }
}
