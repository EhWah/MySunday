//
//  ViewController.swift
//  MySunday
//
//  Created by sowah on 10/5/20.
//

import UIKit

struct MyData {
    var quote: String
    var month: String
    var day: String
    var year: String
}

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let date = Date()
    let calendar = Calendar.current
    
    let quotes = [
        MyData(quote: "", month: "Oct", day: "1", year: "2020"),
        MyData(quote: "", month: "Oct", day: "2", year: "2020"),
        MyData(quote: "", month: "Oct", day: "3", year: "2020"),
        MyData(quote: "For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life.", month: "Oct", day: "4", year: "2020"),
        MyData(quote: "For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life.", month: "Oct", day: "5", year: "2020"),
        MyData(quote: "", month: "Oct", day: "6", year: "2020"),
        MyData(quote: "ဒ်တၢ်ကွဲးအသးလၢဝံယရှါယၤအပူၤအသိးန့ၣ်, ကွၢ်ကွၢ်,ယမၢလီၤယကလူးတဂၤလၢနမဲာ်ညါ,လၢအကမၤက့ၤနကျဲန့ၣ်လီ", month: "Oct", day: "7", year: "2020"),
        MyData(quote: "", month: "Oct", day: "8", year: "2020"),
        MyData(quote: "ဒ်တၢ်ကွဲးအသးလၢဝံယရှါယၤအပူၤအသိးန့ၣ်, ကွၢ်ကွၢ်,ယမၢလီၤယကလူးတဂၤလၢနမဲာ်ညါ,လၢအကမၤက့ၤနကျဲန့ၣ်လီ", month: "Oct", day: "9", year: "2020"),
        MyData(quote: "", month: "Oct", day: "10", year: "2020"),
        MyData(quote: "", month: "Oct", day: "11", year: "2020")
       ]
    
    var quoteForTheWeek = [MyData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var days = [String]()
        
        var dates = calendar.startOfDay(for: Date())
        for _ in 1...7 {
            let month = date.monthMedium
            let day = calendar.component(.day, from: dates)
            days.append("\(month)-\(day)")
            dates = calendar.date(byAdding: .day, value: -1, to: dates)!
            
        }
        print(days)
        for i in quotes {

            switch "\(i.month)-\(i.day)" {
            case days[0], days[1], days[2], days[3], days[4], days[5], days[6]:
                quoteForTheWeek.append(i)
            default:
                print("not available")
            }
            
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        quoteForTheWeek.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.calendar.image = UIImage(systemName: "\(quoteForTheWeek[indexPath.item].day).square.fill")
        cell.quote.text = quoteForTheWeek[indexPath.item].quote
        cell.date.text = "\(quoteForTheWeek[indexPath.item].month)  \(quoteForTheWeek[indexPath.item].day), \(quoteForTheWeek[indexPath.row].year)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
}
extension Date {
    var monthMedium: String  { return Formatter.monthMedium.string(from: self) }
    var hour12:  String      { return Formatter.hour12.string(from: self) }
    var minute0x: String     { return Formatter.minute0x.string(from: self) }
    var amPM: String         { return Formatter.amPM.string(from: self) }
}
