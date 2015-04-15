//
//  ViewController.swift
//  Mac-CBPeripheral
//
//  Created by GrownYoda on 4/9/15.
//  Copyright (c) 2015 yuryg. All rights reserved.
//

import Cocoa
import CoreBluetooth



class ViewController: NSViewController, CBPeripheralManagerDelegate {

    @IBOutlet weak var myTextField: NSTextField!
    
    // Core Bluetooth Stuff
    var myPeripheralManager: CBPeripheralManager?
    
    // A newly generated UUID for our beacon
    let uuid = NSUUID()
    
    // The ID of our beacon is the id of our bundle here
    let identifer = "Hello ID Hello"
    
    let myHeartRateServiceUUID = CBUUID(string: "180D")

    
    
    @IBAction func buttonPressed(sender: NSButton) {
        println( myTextField.stringValue )
        advertiseNewName(myTextField.stringValue)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextField.stringValue = " Hey Now ! "
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        myPeripheralManager = CBPeripheralManager(delegate: self, queue: queue)
        
        if let manager = myPeripheralManager{
            manager.delegate = self

        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    //MARK  CBPeripheral
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        // Stop Advertising
    //    peripheral.stopAdvertising()
        
        // UI Stuff
        var stateString =  String(peripheral.state.rawValue)
        println("The peripheral state is: \(peripheral.state.hashValue)")
        
        
        // Prep Advertising Packet for Periperhal
        let manufacturerData = identifer.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        let theUUid = CBUUID(NSUUID: uuid)
        
        let dataToBeAdvertised:[String:AnyObject!] = [
            CBAdvertisementDataLocalNameKey: "Ghost Chat DidUpdateState",
            CBAdvertisementDataManufacturerDataKey: "Hello Hello Hello Hello",
            CBAdvertisementDataServiceUUIDsKey: [theUUid],]
        
        // Start Advertising The Packet
        myPeripheralManager?.startAdvertising(dataToBeAdvertised)
        
//
        
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager!, error: NSError!) {
        //
        if error == nil {
            println("Succesfully Advertising Data")
        } else{
            println("Failed to Advertise Data.  Error = \(error)")
        }
        
    }
    
    
    
    func advertiseNewName(passedString: String ){
        
        // Stop Advertising
        myPeripheralManager?.stopAdvertising()
        
        // UI Stuff
        
        
        // Prep Advertising Packet for Periperhal
        let manufacturerData = identifer.dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: false)
        
        let theUUid = CBUUID(NSUUID: uuid)
        
        let dataToBeAdvertised:[String:AnyObject!] = [
            CBAdvertisementDataLocalNameKey: "\(passedString)",
            CBAdvertisementDataManufacturerDataKey: "Hello Hello Hello Hello",
            CBAdvertisementDataServiceUUIDsKey: [theUUid],]
        
        // Start Advertising The Packet
        myPeripheralManager?.startAdvertising(dataToBeAdvertised)
        

        
    }
    
    
    
    
    
    
}
