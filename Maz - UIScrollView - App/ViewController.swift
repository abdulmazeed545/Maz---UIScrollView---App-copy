//
//  ViewController.swift
//  Maz - UIScrollView - App
//
//  Created by Shaik abdul mazeed on 28/12/20.
//  Copyright © 2020 Shaik abdul mazeed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Creating global variables
    var defaultSegment = UISegmentedControl()
    //Creating an array of strings
    var startingPageArray = ["Offline","Online"]
    
    var stepper1 = UIStepper()
    
    //Creating global variables
    var segmentStartingPoint:UISegmentedControl!
    var segmentDirection:UISegmentedControl!
    var segment:UISegmentedControl!
    var segment2 = UISegmentedControl()
    var label:UILabel!
    var slider = UISlider()
    var stepper:UIStepper!
    var displayLabels:UILabel!
    var onlineLabels:UILabel!
    var onlineLabelsArray:[UILabel] = []
    var displayLabelsArray:[UILabel] = []
    var displayButtons:UIButton!
    var onlineButtons:UIButton!
    var addButton:UIButton!
    var addButton1 = UIButton()
    var displayButtonsArray:[UIButton] = []
    var onlineButtonsArray:[UIButton] = []
    var displaySwitches:UISwitch!
    var onlineSwitches:UISwitch!
    var displaySwitchesArray:[UISwitch] = []
    var onlineSwitchesArray:[UISwitch] = []
    var segmentCreatedValues:Int = 0
    //Creating variables for UIView and UIScrollView
    var offlineView = UIView()
    var offlineScrollView = UIScrollView()
    var onlineView = UIView()
    var onlineScrollView = UIScrollView()
    var alphabets = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var requestURL:URLRequest!
    var session:URLSessionDataTask!
    
    var defaultValue:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Calling the function
        view.layer.contents = #imageLiteral(resourceName: "wallpaper").cgImage
        startingPage()
        offlineView.layer.contents = #imageLiteral(resourceName: "images").cgImage
        onlineView.layer.contents = #imageLiteral(resourceName: "apple1").cgImage
        
    }
    //Creating a function for showing the default segment on starting page
    func startingPage()
    {
        //Creating an instance to the default segement
        defaultSegment = UISegmentedControl(items: startingPageArray)
        defaultSegment.frame = CGRect(x: 100, y: 45, width: 200, height:30)
        view.addSubview(defaultSegment)
        defaultSegment.apportionsSegmentWidthsByContent = true
        defaultSegment.backgroundColor = UIColor.systemYellow
        defaultSegment.tintColor = UIColor.green
        defaultSegment.addTarget(self, action: #selector(displayTotalData), for: UIControl.Event.valueChanged)
        
        //Creating a view for offline segment
        offlineView.frame = CGRect(x: 0, y: 75, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(offlineView)
        
               
        //Creating a view for online segment
        onlineView.frame = CGRect(x: 0, y: 75, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(onlineView)
        //Creating a scrollview for online view
        onlineScrollView.frame = CGRect(x: 0, y: 75, width: view.frame.size.width, height: view.frame.size.height)
        onlineScrollView.contentSize = CGSize(width: view.frame.size.width+2000, height: view.frame.size.height+1500)
        onlineView.addSubview(onlineScrollView)
        
        
    }
    //Creating a function for creating a button
    func onlineButton()
    {
        addButton1 = UIButton(type: UIButton.ButtonType.system)
        addButton1.frame = CGRect(x: 50, y: 5, width: 100, height: 30)
        addButton1.setTitle("GetData", for: UIControl.State.normal)
        addButton1.backgroundColor = UIColor.systemTeal
        onlineView.addSubview(addButton1)
        addButton1.layer.cornerRadius = 5
        addButton1.addTarget(self, action: #selector(serverData), for: UIControl.Event.touchUpInside)
        
        
        
    }
    //Creating a function for stepper
    func createrStepper()
    {
        stepper1 = UIStepper()
        stepper1.frame = CGRect(x: 200, y: 5, width: 100, height: 100)
        onlineView.addSubview(stepper1)
        stepper1.backgroundColor = UIColor.systemTeal
        stepper1.minimumValue = -1
        stepper1.maximumValue = 1
        stepper1.addTarget(self, action: #selector(stepperAction), for: UIControl.Event.valueChanged)
        
        
    }
    //Creating a function to display the data
    @objc func displayTotalData()
    {
        if (defaultSegment.selectedSegmentIndex == 0)
        {
            offlineView.isHidden = false
            onlineView.isHidden = true
            removeSlider(slide: slider, segmentLower: segment2)
            displayUI()
        }
        else
        {
            offlineView.isHidden = true
            onlineView.isHidden = false
            removeView(type: displayLabelsArray)
            removeView(type: displayButtonsArray)
            removeView(type: displaySwitchesArray)
            removeView(type: onlineLabelsArray)
            onlineButton()
            stepper1.isHidden = true
            createrStepper()
            
        }
    }
    //Creating a function to remove slider from super view
    func removeSlider(slide:UISlider, segmentLower:UISegmentedControl)
    {
        slide.removeFromSuperview()
        segmentLower.removeFromSuperview()
    }
        
    //Creating a function to display
    func displayUI()
    {
        //1.Creating an instance to the segmentStartingPoint
        var segement1 = ["T2B","B2T"]
        segmentStartingPoint = UISegmentedControl(items: segement1)
        segmentStartingPoint.frame = CGRect(x: 210, y: 10, width: 100, height: 30)
        segmentStartingPoint.backgroundColor = UIColor.systemTeal
        offlineView.addSubview(segmentStartingPoint)
        segmentStartingPoint.addTarget(self, action: #selector(displayAll), for: UIControl.Event.valueChanged)
        //Creating a label
        var labelStart = UILabel(frame: CGRect(x: 20, y: 10, width: 150, height: 30))
        labelStart.text = "Starting Point"
        labelStart.backgroundColor = .systemTeal
        labelStart.layer.cornerRadius = 20
        offlineView.addSubview(labelStart)
        
        
        //2.Creating an instance to the segmentDirection
        var segement2 = ["L2R","R2L"]
        segmentDirection = UISegmentedControl(items: segement2)
        segmentDirection.frame = CGRect(x: 210, y: 55, width: 100, height: 30)
        segmentDirection.backgroundColor = UIColor.systemTeal
        offlineView.addSubview(segmentDirection)
        segmentDirection.addTarget(self, action: #selector(displayAll), for: UIControl.Event.valueChanged)
        
        //Creating a label
        var labelDirection = UILabel(frame: CGRect(x: 20, y: 55, width: 150, height: 30))
        labelDirection.text = "Direction"
        labelDirection.backgroundColor = .systemTeal
        labelDirection.layer.cornerRadius = 20
        offlineView.addSubview(labelDirection)
        
        //3.Creating an instance to the segment
        var segement3 = ["Labels","Buttons", "Switches"]
        segment = UISegmentedControl(items: segement3)
        segment.frame = CGRect(x: 80, y: 120, width: 200, height: 40)
        segment.backgroundColor = UIColor.systemTeal
        offlineView.addSubview(segment)
        segment.addTarget(self, action: #selector(displayAll), for: UIControl.Event.valueChanged)
        
        //4.Creating an instance to the slider
        slider = UISlider(frame: CGRect(x: 10, y: 180, width: 150, height: 20))
        
        slider.minimumValue = 0
        slider.value = 0
        slider.maximumValue = 100
        //Giving action to the slider to change values in label
        slider.addTarget(self, action: #selector(sliderChange), for: UIControl.Event.valueChanged)
        slider.addTarget(self, action: #selector(displayAll), for: UIControl.Event.valueChanged)
        offlineView.addSubview(slider)
        //5.Creating an instance to the stepper
        stepper = UIStepper(frame: CGRect(x: 280, y: 180, width: 30, height: 30))
        offlineView.addSubview(stepper)
        stepper.backgroundColor = UIColor.systemTeal
        stepper.minimumValue = 0
        stepper.value = 0
        stepper.maximumValue = 100
        //Giving action to the stepper to change values in labels
        stepper.addTarget(self, action: #selector(stepperChange), for: UIControl.Event.valueChanged)
        stepper.addTarget(self, action: #selector(sliderChange), for: UIControl.Event.valueChanged)
        stepper.addTarget(self, action: #selector(displayAll), for: UIControl.Event.valueChanged)
        //6.Creating an instance to the label
        label = UILabel(frame: CGRect(x: 200, y: 180, width: 50, height: 30))
        label.text = "\(slider.value)"
        label.textAlignment = .center
        offlineView.addSubview(label)
        label.backgroundColor = UIColor.systemYellow
        //7.Creating an instance to the addButton
        addButton = UIButton(type: UIButton.ButtonType.system)
        addButton.frame = CGRect(x: 320, y: 220, width: 50, height: 30)
        offlineView.addSubview(addButton)
        addButton.setTitle("ADD", for: UIControl.State.normal)
        addButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        addButton.backgroundColor = .systemFill
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addSegmentToButton), for: UIControl.Event.touchUpInside)
        
        segment2 = UISegmentedControl(items: [])
        segment2.frame = CGRect(x: 20, y: 220, width: 200, height: 30)
        offlineView.addSubview(segment2)
        
        segment2.addTarget(self, action: #selector(segmentAction), for: UIControl.Event.valueChanged)
    }
    //Creating a function for getting the action to the new segment
    @objc func addSegmentToButton()
    {
        segment2.insertSegment(withTitle: label.text, at: segment2.numberOfSegments+1, animated: true)
      
    }
    //Creating a fuction
    @objc func segmentAction()
    {
        segmentCreatedValues = Int(segment2.titleForSegment(at: segment2.selectedSegmentIndex)!)!
        label.text = "\(segmentCreatedValues)"
        slider.setValue(Float(segmentCreatedValues), animated: true)
        stepper.value = Double(segmentCreatedValues)
        displayAll()
    }
    
    //Creating a function for slider change value
    @objc func sliderChange()
    {
        stepper.value = Double(slider.value)
        label.text = "\(Int(slider.value))"
        segmentCreatedValues = Int(slider.value)
    }
    //Creating a function for stepper change value
    @objc func stepperChange()
    {
        label.text = "\(Int(slider.value))"
        slider.setValue(Float(stepper.value), animated: true)
        segmentCreatedValues = Int(stepper.value)
    }
    //Creating a function for to display labels,buttons and switches when selected
    @objc func displayAll()
    {
        //Condition to select segments for labels,Buttons and switches using their indexes
        if (segment.selectedSegmentIndex == 0 || segment.selectedSegmentIndex == 1 || segment.selectedSegmentIndex == 2)
        {
            if (segmentDirection.selectedSegmentIndex == 0 && segmentStartingPoint.selectedSegmentIndex == 0)
            {
                segmentLogic(xAx: 5, yAx: 400)
            }
            else if(segmentDirection.selectedSegmentIndex == 1 && segmentStartingPoint.selectedSegmentIndex == 0)
            {
                segmentLogic(xAx: 370, yAx: 400)
            }else if(segmentDirection.selectedSegmentIndex == 0 && segmentStartingPoint.selectedSegmentIndex == 1)
            {
                segmentLogic(xAx: 10, yAx: 810)
            }else if(segmentDirection.selectedSegmentIndex == 1 && segmentStartingPoint.selectedSegmentIndex == 1)
            {
                segmentLogic(xAx: 370, yAx: 810)
            }
        }
    }
    
    //Creating a function to remove the view
    func removeView(type: [Any])
    {
        for i in 0..<type.count
        {
            (type[i] as AnyObject).removeFromSuperview()
        }
    }
    //Creating a function for to create labels
    func segmentLogic(xAx:Int, yAx:Int)
    {
        //Creating variables
        var x = 0
        var y = yAx
        
        
        removeView(type: displayLabelsArray)
        removeView(type: displayButtonsArray)
        removeView(type: displaySwitchesArray)
        slider.value = Float(stepper.value)
        //For loop for creating the number of labels
        for index in stride(from: 1, through: slider.value, by: 1)
        {
            //conditon for segments selection
            if segment.selectedSegmentIndex == 0
            {
                //Creating an instance to the UILabel
                displayLabels = UILabel()
                if (segmentStartingPoint.selectedSegmentIndex == 0 && segmentDirection.selectedSegmentIndex == 0) || (segmentStartingPoint.selectedSegmentIndex == 1 && segmentDirection.selectedSegmentIndex == 0)
                {
                    displayLabels.frame = CGRect(x: xAx+40*x, y: y, width: 35, height: 25)
                    
                    
                }else if (segmentStartingPoint.selectedSegmentIndex == 0 && segmentDirection.selectedSegmentIndex == 1) || (segmentStartingPoint.selectedSegmentIndex == 1 && segmentDirection.selectedSegmentIndex == 1)
                {
                    displayLabels.frame = CGRect(x: xAx-40*x, y: y, width: 35, height: 25)
                }
                
                displayLabels.backgroundColor = UIColor.systemYellow
                displayLabels.text = "\(Int(index))"
                displayLabels.textAlignment = .center
                view.addSubview(displayLabels)
                
                //Appending the created labels into an array
                displayLabelsArray.append(displayLabels)
                
                //Incrementing the the x axis value
                x += 1
                //for loop to break the labels
                for j in stride(from: 10, through: slider.value, by: 10)
                {
                    if (Int(index) == Int(j))
                    {
                        x = 0
                        if segmentStartingPoint.selectedSegmentIndex == 0
                        {
                            //Increasing the y axis value
                            y += 40
                        }else if segmentStartingPoint.selectedSegmentIndex == 1
                        {
                            //Decreasing the y axis value
                            y -= 40
                        }
                        
                    }
                }
                
            }
            else if segment.selectedSegmentIndex == 1
            {
                //Creating an instance to the button
                displayButtons = UIButton(type: UIButton.ButtonType.system)
                if (segment.selectedSegmentIndex == 1 && segmentDirection.selectedSegmentIndex == 0)
                {
                    displayButtons.frame = CGRect(x: xAx+35*x, y: y, width: 30, height: 20)
                    
                }else if (segment.selectedSegmentIndex == 1 && segmentDirection.selectedSegmentIndex == 1)
                {
                    displayButtons.frame = CGRect(x: xAx-35*x, y: y, width: 30, height: 20)
                }
                displayButtons.setTitle("\(Int(index))", for: UIControl.State.normal)
                displayButtons.backgroundColor = UIColor.green
                displayButtons.layer.cornerRadius = 5
                view.addSubview(displayButtons)
                
                //Appending the created buttons into an array
                displayButtonsArray.append(displayButtons)
                
                //Incrementing the the x axis value
                x += 1
                
                //for loop to break the labels
                for j in stride(from: 11, through: slider.value, by: 11)
                {
                    if (Int(index) == Int(j))
                    {
                        x = 0
                        if segmentStartingPoint.selectedSegmentIndex == 0
                        {
                            //Increasing the y axis value
                            y += 50
                        }else if segmentStartingPoint.selectedSegmentIndex == 1
                        {
                            //Decreasing the y axis value
                            y -= 50
                        }
                        
                    }
                }
                
            }
            else if segment.selectedSegmentIndex == 2
            {
                //Creating an instance to the button
                displaySwitches = UISwitch()
                if (segment.selectedSegmentIndex == 2 && segmentDirection.selectedSegmentIndex == 0)
                {
                    displaySwitches.frame = CGRect(x: xAx+55*x, y: y, width: 49, height: 31)
                    
                }else if (segment.selectedSegmentIndex == 2 && segmentDirection.selectedSegmentIndex == 1)
                {
                    displaySwitches.frame = CGRect(x: xAx-55*x, y: y, width: 49, height: 31)
                }
                displaySwitches.backgroundColor = UIColor.systemFill
                displaySwitches.thumbTintColor = UIColor.systemRed
                view.addSubview(displaySwitches)
                
                //Appending the created buttons into an array
                displaySwitchesArray.append(displaySwitches)
                
                //Incrementing the the x axis value
                x += 1
                
                //for loop to break the labels
                for j in stride(from: 8, through: slider.value, by: 8)
                {
                    if (Int(index) == Int(j))
                    {
                        x = 0
                        if segmentStartingPoint.selectedSegmentIndex == 0
                        {
                            //Increasing the y axis value
                            y += 40
                        }else if segmentStartingPoint.selectedSegmentIndex == 1
                        {
                            //Decreasing the y axis value
                            y -= 40
                        }
                        
                    }
                }
                
            }
        }
        
        
    }
    //Creating a function for to display server data
    @objc func serverData()
    {
        //Creating an URL Request to the server
        requestURL = URLRequest(url: URL(string: "https://services.brninfotech.com/tws/ComponentCreation.php")!)
        requestURL.httpMethod = "POST"
        //Creating a session to the datatask
        session = URLSession.shared.dataTask(with: requestURL, completionHandler: { (data, response, error) in
                   
            if (error == nil)
            {
                print("Got Data from server")
                do
                {
                    //Creating an instance to the JSONDecoder class
                    let componentDetail = JSONDecoder()
                    var componentDataConvert = try componentDetail.decode(ComponentDetails.self, from: data!)
                    print("\(componentDataConvert)")
                    DispatchQueue.main.async {
                        
                        self.removeView(type: self.onlineLabelsArray)
                        self.onlineLabels = UILabel()
                        self.onlineLabels.frame = CGRect(x: 0, y: 0, width: 300, height: 150)
                        self.onlineLabels.text = " Axis = \(componentDataConvert.axis!)\n Component = \(componentDataConvert.component!)\n Quantity = \(componentDataConvert.quantity!)\n DisplayNumbers = \(componentDataConvert.displayNumbers)\n ChangeQuantity = \(componentDataConvert.changeQuantity)\n MaxPerRow = \(componentDataConvert.maxPerRow)\n MaxPerColumn = \(componentDataConvert.maxPerColumn)"
                        self.onlineLabels.numberOfLines = 7
                        self.onlineLabels.backgroundColor = .systemTeal
                        self.onlineView.addSubview(self.onlineLabels)
                        self.onlineScrollView.addSubview(self.onlineLabels)
                        self.onlineLabelsArray.append(self.onlineLabels)
                        
                       

                        self.removeView(type: self.displayLabelsArray)
                        self.removeView(type: self.displayButtonsArray)
                        self.removeView(type: self.displaySwitchesArray)
                        if (componentDataConvert.changeQuantity == true)
                        {
                            self.stepper1.isHidden = false
                            
                        }else if (componentDataConvert.changeQuantity == false)
                        {
                            self.stepper1.isHidden = true
                            
                        }
                        self.axis = componentDataConvert.axis
                        self.component = componentDataConvert.component
                        self.quantity = componentDataConvert.quantity
                        self.displayNumbers = componentDataConvert.displayNumbers
                        self.maxRow = componentDataConvert.maxPerRow
                        self.maxColoumn = componentDataConvert.maxPerColumn
                        self.changeQuantity = componentDataConvert.changeQuantity
                        self.parseServerData()
                    }
                    
                }
                catch
                {
                    print(error)
                }
            }
        })
        session.resume()
    }
    var axis:String!
    var component:String!
    var quantity:Int!
    var displayNumbers:Bool!
    var maxRow:Int!
    var maxColoumn:Int!
    var changeQuantity:Bool!
    //creatig a function for sever data handling
    func parseServerData()
    {
               
        var x = 0
        var y = 250
        var y1 = 0
        
        for i in stride(from: 1, through: quantity, by: 1)
        {
            if (component == "Label")
            {
                self.displayLabels = UILabel()
                if (axis == "Horizontal")
                {
                    
                    self.displayLabels.frame = CGRect(x: x*50+10, y: y, width: 35, height: 35)
                    if (displayNumbers == true)
                    {
                        self.displayLabels.text = "\(i)"
                        
                    }else
                    {
                        if (i <= self.alphabets.count)
                        {
                            self.displayLabels.text = "\(self.alphabets[i-1])"
                            
                        }else if (i > self.alphabets.count)
                        {
                            self.displayLabels.text = "\(self.alphabets[(i-1)%26])"
                        }
                        
                    }
                    self.displayLabels.textAlignment = .center
                    self.displayLabels.backgroundColor = .darkGray
                    self.displayLabels.layer.cornerRadius = 5
                    self.displayLabels.clipsToBounds = true
                    self.onlineView.addSubview(self.displayLabels)
                    self.onlineScrollView.addSubview(self.displayLabels)
                    self.displayLabelsArray.append(self.displayLabels)
                    x += 1
                    
                    for j in stride(from: maxRow, through: quantity, by: maxRow)
                    {
                        if (i == j)
                        {
                            x = 0
                            y += 45
                        }
                    }

                }else if (axis == "Vertical")
                {
                    self.displayLabels.frame = CGRect(x: x, y: y1*50+250, width: 35, height: 35)
                    if (displayNumbers == true)
                    {
                        self.displayLabels.text = "\(i)"
                        
                    }else
                    {
                        if (i <= self.alphabets.count)
                        {
                            self.displayLabels.text = "\(self.alphabets[i-1])"
                            
                        }else if (i > self.alphabets.count)
                        {
                            self.displayLabels.text = "\(self.alphabets[(i-1)%26])"
                        }
                        
                    }
                    self.displayLabels.textAlignment = .center
                    self.displayLabels.backgroundColor = .yellow
                    self.displayLabels.layer.cornerRadius = 5
                    self.displayLabels.clipsToBounds = true
                    self.onlineView.addSubview(self.displayLabels)
                    self.onlineScrollView.addSubview(self.displayLabels)
                    self.displayLabelsArray.append(self.displayLabels)
                    y1 += 1
                    for j in stride(from: maxColoumn, through: quantity, by: maxColoumn)
                    {
                        if (i == j)
                        {
                            y1 = 0
                            x += 40
                        }
                    }
                    
                    
                }
                
            }
            else if (component == "Button")
            {
                self.displayButtons = UIButton(type: UIButton.ButtonType.system)
                if (axis == "Horizontal")
                {
                    self.displayButtons.frame = CGRect(x: x*40+10, y: y, width: 30, height: 30)
                    if (displayNumbers == true)
                    {
                        self.displayButtons.setTitle("\(i)", for: UIControl.State.normal)
                        
                    }else
                    {
                        if (i <= self.alphabets.count)
                        {
                            self.displayButtons.setTitle("\(self.alphabets[i-1])", for: UIControl.State.normal)
                            
                            
                        }else if (i > self.alphabets.count)
                        {
                            self.displayButtons.setTitle("\(self.alphabets[(i-1)%26])", for: UIControl.State.normal)
                            
                        }
                        
                    }
                    
                    self.displayButtons.backgroundColor = .cyan
                    self.displayButtons.layer.cornerRadius = 5
                    self.onlineView.addSubview(self.displayButtons)
                    self.onlineScrollView.addSubview(self.displayButtons)
                    self.displayButtonsArray.append(self.displayButtons)
                    x += 1
                    for j in stride(from: maxRow, through: quantity, by: maxRow)
                    {
                        if (i == j)
                        {
                            x = 0
                            y += 40
                        }
                    }
                }
                else if (axis == "Vertical")
                {
                    self.displayButtons.frame = CGRect(x: x, y: y1*40+250, width: 30, height: 30)
                    self.displayButtons.setTitle("\(i)", for: UIControl.State.normal)
                    self.displayButtons.backgroundColor = .cyan
                    self.displayButtons.layer.cornerRadius = 5
                    self.onlineView.addSubview(self.displayButtons)
                    self.onlineScrollView.addSubview(self.displayButtons)
                    self.displayButtonsArray.append(self.displayButtons)
                    y1 += 1
                    for j in stride(from: maxColoumn, through: quantity, by: maxColoumn)
                    {
                        if (i == j)
                        {
                            y1 = 0
                            x += 40
                        }
                    }
                    
                }
                
            }
            else if (component == "Switch")
            {
                self.displaySwitches = UISwitch()
                if (axis == "Horizontal")
                {
                    self.displaySwitches.frame = CGRect(x: x*65+10, y: y, width: 30, height: 25)
                    self.displaySwitches.backgroundColor = .green
                    self.displaySwitches.thumbTintColor = .red
                    self.onlineView.addSubview(self.displaySwitches)
                    self.onlineScrollView.addSubview(self.displaySwitches)
                    self.displaySwitchesArray.append(self.displaySwitches)
                    x += 1
                    for j in stride(from: maxRow, through: quantity, by: maxRow)
                    {
                        if (i == j)
                        {
                            x = 0
                            y += 50
                        }
                    }
                    
                }
                else if (axis == "Vertical")
                {
                    self.displaySwitches.frame = CGRect(x: x, y: y1*65+250, width: 30, height: 25)
                    self.displaySwitches.backgroundColor = .red
                    self.displaySwitches.thumbTintColor = .green
                    self.onlineView.addSubview(self.displaySwitches)
                    self.onlineScrollView.addSubview(self.displaySwitches)
                    self.displaySwitchesArray.append(self.displaySwitches)
                    y1 += 1
                    for j in stride(from: maxColoumn, through: quantity, by: maxColoumn)
                    {
                        if (i == j)
                        {
                            y1 = 0
                            x += 55
                        }
                    }
                    
                }
            
            }
        }
    }
    //Creating a function for stepper action
    @objc func stepperAction()
    {
        
        if (stepper1.value > defaultValue)
        {
            quantity += 1
            parseServerData()
            
        }
        else if (stepper1.value < defaultValue)
        {
            quantity -= 1
            removeView(type: displayLabelsArray)
            removeView(type: displayButtonsArray)
            removeView(type: displaySwitchesArray)
            parseServerData()
        }
        stepper1.value = defaultValue
    }
    
}

