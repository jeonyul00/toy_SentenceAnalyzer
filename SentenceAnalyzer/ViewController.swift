//
//  ViewController.swift
//  SentenceAnalyzer
//
//  Created by 전율 on 11/6/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sentenceCountLabel: UILabel!
    @IBOutlet weak var averageLangthLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func analyze(_ sender: Any) {
        let start = Date.now.timeIntervalSinceReferenceDate
        sentenceCountLabel.text = "-"
        averageLangthLabel.text = "-"
        statusLabel.text = "text file loading..."
        DispatchQueue.global().async {
            guard let source = try? String(contentsOf: URL.tempFileURL) else { return }
            DispatchQueue.main.async {
                let elaspsedTime = Date.now.timeIntervalSinceReferenceDate - start
                self.statusLabel.text = "text file loading... \(elaspsedTime.formatted(.number.precision(.fractionLength(3)))) seconds"
            }
            let lines = source.components(separatedBy: .newlines).filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 }
            var cnt = 0
            var len = 0
            for line in lines {
                let sentences = line.components(separatedBy: ".").filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 }
                len += sentences.reduce(0, { $0 + $1.count } )
                cnt += sentences.count
                DispatchQueue.main.async {
                    self.sentenceCountLabel.text = cnt.formatted()
                    self.averageLangthLabel.text = (len/cnt).formatted()
                }
            }
            DispatchQueue.main.async {
                self.sentenceCountLabel.text = cnt.formatted()
                self.averageLangthLabel.text = (len/cnt).formatted()
                let elaspsedTime = Date.now.timeIntervalSinceReferenceDate - start
                self.statusLabel.text = "analyze in \(elaspsedTime.formatted(.number.precision(.fractionLength(3)))) seconds"
            }
        }
        
    }
    
    @IBAction func analzeAsync(_ sender: Any) {
        let start = Date.now.timeIntervalSinceReferenceDate
        sentenceCountLabel.text = "-"
        averageLangthLabel.text = "-"
        statusLabel.text = "analze file loading..."
        
        var cnt = 0
        var len = 0
        
        Task {
            for try await line in URL.tempFileURL.lines {
                let sentences = line.components(separatedBy: ".").filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 }
                len += sentences.reduce(0, { $0 + $1.count } )
                cnt += sentences.count
                self.sentenceCountLabel.text = cnt.formatted()
                self.averageLangthLabel.text = (len/cnt).formatted()
            }
            self.sentenceCountLabel.text = cnt.formatted()
            self.averageLangthLabel.text = (len/cnt).formatted()
            let elaspsedTime = Date.now.timeIntervalSinceReferenceDate - start
            self.statusLabel.text = "analyze in \(elaspsedTime.formatted(.number.precision(.fractionLength(3)))) seconds"
        }
        
    }
    
    
}

