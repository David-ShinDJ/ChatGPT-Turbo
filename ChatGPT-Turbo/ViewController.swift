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
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var plotTextView: UITextView!
    
    @IBOutlet weak var tagPicker: UIPickerView!
    
    @IBOutlet weak var tagAddButton: UIButton!
    
    //MARK: FileManger Create, Read, Write
    
    @IBOutlet weak var categoryHstack: UIStackView!
    
    var novel: Novel = Novel()
    var category: String = ""
    let fileManger: FileManager = FileManager.default
    
    var documentPath: URL {
        fileManger.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    var directoryPath: URL {
        return documentPath.appendingPathComponent("내소설")
    }
    
    var textPath: URL {
        directoryPath.appendingPathComponent("\(String(describing: novel.title!)).txt")
    }
    
    func writeFile() {
        if let data: Data = "스토리구성 \(String(describing: novel.plot!)) \n 관련 키워드 : \(String(describing: novel.tag!))".data(using: String.Encoding.utf8) { // String to Data
            do {
                try data.write(to: textPath) // 위 data를 "hi.txt"에 쓰기
            } catch let e {
                print(e.localizedDescription)
            }
        }
    }
    
    func createDirectory() {
        do {
            try fileManger.createDirectory(at: directoryPath, withIntermediateDirectories: false, attributes: nil)
        } catch let e {
            print(e.localizedDescription)
        }
    }

    @IBAction func tagAddPressed(_ sender: UIButton) {
        let label = UILabel()
        label.text = category
        label.font = UIFont.systemFont(ofSize: 20)
        label.frame = CGRect(x: 0 ,y: 0, width: 100, height: 50)
        categoryHstack.addSubview(label)
        categoryHstack.alignment = .leading
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        var tag:[String] = []
        categoryHstack.subviews.map({ UIView in
            let uiLabel = UIView as! UILabel
            tag.append(uiLabel.text!)
        })
        
        self.novel.title = titleTextField.text
        self.novel.plot = plotTextView.text
        self.novel.tag = tag
        
        createDirectory()
        writeFile()
        print(documentPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        self.category = categorizes[row]
        print(category)
    }
}
