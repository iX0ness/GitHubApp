//
//  RepoDetailVievControllerTest.swift
//  GitHubAppTests
//
//  Created by Levchuk Misha on 01.05.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import XCTest
import Alamofire
import ChameleonFramework
import Presentr

@testable import GitHubApp



class RepoDetailVievControllerTest: XCTestCase {

    //optimistic case
    func testFormatDate1() {

        let vc1 = RepoDetailViewController()
        let dateToFormat: String? = "2018-01-14T21:55:30Z"
        let expectedDate = "14.01.18"
        XCTAssertTrue(vc1.formatDate(date: dateToFormat) == expectedDate)
    }

    //wrong format
    func testFormatDate2() {

        let vc2 = RepoDetailViewController()
        let dateToFormat: String? = "fgfdfg"
        let expectedDate = "14.01.18"
        XCTAssertFalse(vc2.formatDate(date: dateToFormat) == expectedDate)

    }

    //nil instead of date
    func testFormatDate3() {
        
        let vc3 = RepoDetailViewController()
        let dateToFormat: String? = nil
        let expectedDate = "14.01.18"
        XCTAssertFalse(vc3.formatDate(date: dateToFormat) == expectedDate)

    }



    
}
