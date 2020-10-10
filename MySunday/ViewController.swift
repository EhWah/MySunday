//
//  ViewController.swift
//  MySunday
//
//  Created by sowah on 10/5/20.
//

import UIKit

struct MyData {
    var quote: String
    var refe: String
    var month: String
    var day: String
    var year: String
}

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let date = Date()
    let calendar = Calendar.current
    var days = [String]()
    var quoteForTheWeek = [MyData]()
    var randomImageNumber = [1,2,3,4,5,6,7,8].shuffled()
    
    let quotes = [
        MyData(quote: "t*hI’ftH:wIvU,G:r:wohbOehIwtdObOeDwrH:bO ", refe: "vl:uO 1;37", month: "Oct", day: "6", year: "2020"),
        MyData(quote: "t*hI’ftH:wIvU,G:r:wohbOehIwtdObOeDwrH:bO ", refe: "vl:uO 1;37", month: "Oct", day: "7", year: "2020"),
        MyData(quote: "rhrhIyS:w*:*:rhItJO,G:’D; t0J’OubOwIohOngtD:vU,G:vD:", refe: "1u&HOol; 8;3", month: "Oct", day: "8", year: "2020"),
        MyData(quote: "S:w*:*:rhIqdurdOvUtohOngwIwrH:rH:’D;’ftBuU;ohOng0Jtod;ehOwohOng’H;bOwIeDwrH:bO", refe: "1u&HOol; 8;2", month: "Oct", day: "9", year: "2020"),
        MyData(quote: "S:w*:*:rhIqdurdOvUtohOngwIwrH:rH:’D;’ftBuU;ohOng0Jtod;ehOwohOng’H;bOwIeDwrH:bO", refe: "1u&HOol; 8;2", month: "Oct", day: "10", year: "2020")
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSevenDay()
        appendingThisWeekQuotes()
        pageControl.numberOfPages = quoteForTheWeek.count + 2
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    func getSevenDay() {
        var dates = calendar.startOfDay(for: Date())
        for _ in 1...7 {
            let month = date.monthMedium
            let day = calendar.component(.day, from: dates)
            days.append("\(month)-\(day)")
            dates = calendar.date(byAdding: .day, value: -1, to: dates)!
        }
    }
    
    func appendingThisWeekQuotes() {
        for i in quotes {
            switch "\(i.month)-\(i.day)" {
            case days[0], days[1], days[2], days[3], days[4], days[5], days[6]:
                quoteForTheWeek.append(i)
            default:
                print("not available")
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? HeaderCollectionReusableView else {
                fatalError("invalid view type")
            }
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerCell", for: indexPath)
            return footerView
        default:
            assert(false, "Invalid element type")
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        quoteForTheWeek.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
      
        let quote = quoteForTheWeek[indexPath.item]
        
        cell.quote.text = quote.quote
        cell.date.text = "\(quote.month)  \(quote.day), \(quote.year)"
        cell.refer.text = quote.refe
        cell.backgroundImage.image = UIImage(named: "wall\(randomImageNumber[indexPath.item])")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

