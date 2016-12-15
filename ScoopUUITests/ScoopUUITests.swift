//  ScoopUUITests.swift
//  ScoopUUITests
//
// The test cases for our app.
//
//  Created by Taylor Ferrari, Krista Anken, Miles Singer and Sam Ash on 12/4/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import XCTest
import Foundation

class ScoopUUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication() //test successful - open app
        var logInButton = app.buttons["log in"] //test successful - "log in" button works
        
        //test successful - swipe right in LoginViewController
        var window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.swipeRight()
        
        //test successful - "Sign up" button works
        app.buttons["sign up"].tap()
        
        //test successful - swipe right in RegisterViewController
        window.children(matching: .other).element(boundBy: 2).swipeRight()
        
        //test successful - login with correct username and password
        app.typeText("samuel.ash@hws.edu")
        XCUIApplication().secureTextFields["password"].typeText("password")
        app.buttons["log in"].tap()
        
        //test successful - wrong password = failed log in
        let emailTextField = app.textFields["email"]
        emailTextField.tap()
        emailTextField.typeText("wrongemail")
        app.children(matching: .window).element(boundBy: 1).buttons["wrong email"].tap()
        app.secureTextFields["password"].typeText("wrongpw")
        logInButton = app.buttons["log in"]
        logInButton.tap()
        
        //test successful - incorrect email = cannot sign up for ScoopU
        XCUIApplication().textFields["email"].typeText("student@hws.edu")
        app.secureTextFields["password"].typeText("pw")
        app.buttons["sign up"].tap()
        
        //test successful - correct car info
        XCUIApplication().textFields["name"].typeText("Name")
        app.textFields["make and model"].typeText("make and model")
        let yearTextField = app.textFields["year"]
        yearTextField.typeText("year")
        let licensePlateNumberTextField = app.textFields["license plate number"]
        licensePlateNumberTextField.typeText("plate#")
        app.buttons["ENTER"].tap()
        
        //test successful - "select rider" button after picking a rider on the picker
        let selectRiderButton = app.buttons["Select Rider"]
        selectRiderButton.tap()
        window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element(boundBy: 6).swipeRight()
        app.pickerWheels["sam"].tap()
        selectRiderButton.tap()
        
        //test successful - "HERE" button when driver arrives at destination
        window.children(matching: .other).element(boundBy: 8).tap()
        app.buttons["HERE"].tap()
        
        //test successful - "log out" button after selecting a rider
        app.buttons["Log Out"].tap()
        
        //test successful - rider info
        XCUIApplication().textFields["name"].typeText("name")
        let locationTextField = XCUIApplication().textFields["location"]
        locationTextField.tap()
        locationTextField.typeText("loc")
        app.textFields["destination"].typeText("des")
        app.buttons["Send"].tap()
        
        //test unsuccessful - "i arrived" button does not take the user out of the database
        app.buttons["I Arrived"].tap()
        
        //test successful - "ride again" button takes the user back to the rider info view controller
        app.buttons["Ride Again"].tap()
        
        //test successful - "log out" button brings the user back to the login page
        XCUIApplication().buttons["Log Out"].tap()
        
    }
}
