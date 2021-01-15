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
    
    var currentCell: ProductListCell
    
    let yValues: [BarChartDataEntry] = [
        BarChartDataEntry(x: 0.0, y: 30.0, data: "123"),
        BarChartDataEntry(x: 1.0, y: 10.0, data: "234"),
        BarChartDataEntry(x: 2.0, y: 5.0, data: "345"),
        BarChartDataEntry(x: 3.0, y: 20.0, data: "456")
    ]
    
    init(frame: CGRect, cell: ProductListCell) {
        self.currentCell = cell
        super.init(frame: frame)
        
        UINib(nibName: "ChartPriceProductCell", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
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
        
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
    
    @IBAction func actionHideChartButton(_ sender: UIButton) {
        currentCell.showChartPriceBool = false
        NotificationCenter.default.post(name: NSNotification.Name("CloseChartView"), object: nil)
    }
}

extension ChartPriceProductCell: ChartViewDelegate {
    func setData() {
        let set1 = BarChartDataSet(entries: yValues, label: "ЦЕНА")
        set1.setColor(UIColor(red: 0.938, green: 0.938, blue: 0.95, alpha: 1))
        set1.highlightAlpha = 1
        set1.highlightColor = UIColor(red: 0.725, green: 0, blue: 0.908, alpha: 1)
        set1.drawValuesEnabled = false
        
        let data = BarChartData(dataSet: set1)
        chartView.data = data
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
