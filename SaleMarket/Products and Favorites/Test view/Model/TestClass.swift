//
//  TestClass.swift
//  SaleMarket
//
//  Created by Timur Isaev on 21.01.2021.
//

import Foundation

class TestClass {
    static let shared = TestClass()
    
    func loadJson(testId id: Int?) -> TestModel? {
        guard let id = id else { return nil }
        if let url = Bundle.main.url(forResource: "test-\(String(describing: id))", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(TestModel.self, from: data)
                return dataModel
            } catch {
                print(error)
            }
        }
        return nil
    }
}
