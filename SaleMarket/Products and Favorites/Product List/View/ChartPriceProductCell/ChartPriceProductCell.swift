//
//  CahrtPriceProductCell.swift
//  SaleMarket
//
//  Created by UserDev on 15.01.2021.
//

import UIKit
import Charts

class ChartPriceProductCell: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var chartView: BarChartView!
    
    @IBOutlet weak var priceSaleNameLabel: UILabel!
    @IBOutlet weak var priceSaleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var currentCell: ProductListCell
    var currentItem: ProductListModel
  
    var yValues = [BarChartDataEntry]()
//    var yValues: [BarChartDataEntry] = [
//        BarChartDataEntry(x: 0.0, y: 30.0, data: "123"),
//        BarChartDataEntry(x: 1.0, y: 10.0, data: "234"),
//        BarChartDataEntry(x: 2.0, y: 5.0, data: "345"),
//        BarChartDataEntry(x: 3.0, y: 20.0, data: "456")
//    ]
    
    init(frame: CGRect, cell: ProductListCell) {
        self.currentCell = cell
        self.currentItem = cell.currentItem!
        
        super.init(frame: frame)
        
        UINib(nibName: "ChartPriceProductCell", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
        var indexArray = 0.0
        for item in currentItem.history! {
            yValues.append(BarChartDataEntry(x: indexArray, y: Double(item.value), data: item.name))
            indexArray += 1
        }
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        if currentItem.price == 0 {
            priceSaleNameLabel.text = "Цена:"
            priceLabel.text = "0 руб."
            priceLabel.textColor = UIColor(red: 0.146, green: 0.146, blue: 0.146, alpha: 1)
        } else {
            let price = currentItem.price - currentItem.sale
            if currentItem.price < currentItem.sale {
                priceSaleNameLabel.text = "Цена выросла:"
                priceSaleLabel.text = "+\(price) руб."
                priceSaleLabel.textColor = UIColor(red: 1, green: 0, blue: 0.24, alpha: 1)
            } else {
                priceSaleNameLabel.text = "Цена упала:"
                priceSaleLabel.text = "-\(price) руб."
                priceSaleLabel.textColor = UIColor(red: 0, green: 0.742, blue: 0.163, alpha: 1)
            }
        }
        
        setupChartView()
        setData()
    }
    
    private func setupChartView() {
        chartView.delegate = self
        chartView.backgroundColor = UIColor.white
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.xAxis.enabled = false
        chartView.gridBackgroundColor = .clear
        chartView.doubleTapToZoomEnabled = false
        
        chartView.chartDescription!.enabled = false
        chartView.legend.enabled = false
        
//        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
//                                  font: .systemFont(ofSize: 12),
//                                  textColor: .white,
//                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
//                                  xAxisValueFormatter: chartView.xAxis.valueFormatter!)
//        marker.chartView = chartView
//        marker.minimumSize = CGSize(width: 80, height: 40)
//        chartView.marker = marker

    }
    
    @IBAction func actionHideChartButton(_ sender: UIButton) {
        currentCell.showChartPriceBool = false
        NotificationCenter.default.post(name: NSNotification.Name("CloseChartView"), object: nil)
    }
}

extension ChartPriceProductCell: ChartViewDelegate {
    func setData() {
        let set1 = BarChartDataSet(entries: yValues)
        set1.setColor(UIColor(red: 0.938, green: 0.938, blue: 0.95, alpha: 1))
        set1.highlightAlpha = 1
        set1.highlightColor = UIColor(red: 0.725, green: 0, blue: 0.908, alpha: 1)
        set1.drawValuesEnabled = false
        
        let data = BarChartData(dataSet: set1)
        chartView.data = data
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        debugPrint("x: \(entry.x), y: \(entry.y), data: \(String(describing: entry.data!))")
        
        priceLabel.text = "\(entry.y) руб."
        dateLabel.text = "\(entry.data!)"
    }
}
