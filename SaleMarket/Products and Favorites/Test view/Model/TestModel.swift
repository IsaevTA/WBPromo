//
//  TestModel.swift
//  SaleMarket
//
//  Created by Timur Isaev on 24.12.2020.
//

import Foundation

// MARK: - TestModel
struct TestModel: Codable {
    let id: Int
    let name: String
    let test: [TestQuestion]
    let result: [TestResult]
}

// MARK: - Result
struct TestResult: Codable {
    let name: String
    let image: String
    let text: String
}

// MARK: - Test
struct TestQuestion: Codable {
    let question: String
    let answers: [String]
}

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
