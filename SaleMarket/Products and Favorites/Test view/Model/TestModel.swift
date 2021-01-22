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


