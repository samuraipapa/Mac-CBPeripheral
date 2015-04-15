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
    var dataToBeAdvertisedGolbal:[String:AnyObject!]?
    
    // A newly generated UUID for our beacon
    let uuid = NSUUID()
    
    // The ID of our beacon is the id of our bundle here
    let identifer = "Hello ID Hello"
    
    let myHeartRateServiceUUID = CBUUID(string: "180D")

    @IBOutlet weak var textAfterSend: NSTextField!
    
    
    @IBAction func buttonPressed(sender: NSButton) {
        println( myTextField.stringValue )
        advertiseNewName(myTextField.stringValue)
        
    }
    
    
    //UI Stuff
    func updateTextAfterSent(passedString: String){
        textAfterSend.stringValue = passedString + "\r" + textAfterSend.stringValue
        
    }
    
    @IBAction func buttonPeripheralOFF(sender: NSButton) {
        println("OFF pressed")
        myPeripheralManager?.stopAdvertising()
        println(" State: " + "\(myPeripheralManager?.state.rawValue)"  )
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

       println("did update state!")
        // Stop Advertising
        peripheral.stopAdvertising()

        
        switch (peripheral.state) {
        case .PoweredOn:
            println(" Powered ON State: " + "\(myPeripheralManager?.state.rawValue)"  )

            
            println("We are ON!")

                // Prep Advertising Packet for Periperhal
                let manufacturerData = identifer.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                
                let theUUid = CBUUID(NSUUID: uuid)
                
                let dataToBeAdvertised:[String:AnyObject!] = [
                    CBAdvertisementDataLocalNameKey: "Ghost Chat DidUpdateState",
                    CBAdvertisementDataManufacturerDataKey: "Hello Hello Hello Hello",
                    CBAdvertisementDataServiceUUIDsKey: [theUUid],]
                
                
                
                
                dataToBeAdvertisedGolbal = dataToBeAdvertised
                // Start Advertising The Packet
                myPeripheralManager?.startAdvertising(dataToBeAdvertised)

            
            
   
            break
        case .PoweredOff:
            println(" Powered OFF State: " + "\(myPeripheralManager?.state.rawValue)"  )

            println("We are off!")
            
    break;

        case .Resetting:
            println(" State: " + "\(myPeripheralManager?.state.rawValue)"  )

            
            break;

        case .Unauthorized:
            //
            println(" State: " + "\(myPeripheralManager?.state.rawValue)"  )

            break;

        case .Unknown:
            //
            println(" State: " + "\(myPeripheralManager?.state.rawValue)"  )

            break;

        case .Unsupported:
            //
            println(" State: " + "\(myPeripheralManager?.state.rawValue)"  )

            break;

  default:
    println(" State: " + "\(myPeripheralManager?.state.rawValue)"  )

    break;
}
        
        // UI Stuff
//        var stateString =  String(peripheral.state.rawValue)
//        println("The peripheral state is: \(peripheral.state.hashValue)")
//        updateTextAfterSent("The peripheral state is: \(peripheral.state.hashValue)")
//        
        
      //        }
//
        
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager!, error: NSError!) {
        //
        println(" State in DidStartAdvertising: " + "\(myPeripheralManager?.state.rawValue)"  )
        
        if error == nil {
//            let myString = peripheral.isAdvertising
            println("Succesfully Advertising Data")
            updateTextAfterSent("Succesfully Advertising Data")
            
        } else{
            println("Failed to Advertise Data.  Error = \(error)")
            updateTextAfterSent("Failed to Advertise Data.  Error = \(error)")
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
