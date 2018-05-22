//
//  ViewController.swift
//  gazer
//
//  Created by 佐藤玲 on 2018/05/18.
//  Copyright © 2018年 OCTA. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBAction func goStarButton(_ sender: UIButton) {//Star画面へ
        performSegue(withIdentifier: "goStar", sender: nil)
    }
<<<<<<< HEAD
    
    // 位置情報
    var locationManager: CLLocationManager!
    
    // XMLParser のインスタンスを生成
    var parser = XMLParser()
    
    // 星の情報を複数保持
    var rows = NSMutableArray()
    
    // 今回は star タグ内を取得。star で固定なので Stringクラスでインスタンスを生成
    var element = String()
    
    // 取得したいタグの中身は変わるので可変クラスでインスタンスを生成
    var elements = NSMutableDictionary()
    
    /*: 取得したいタグ内の値を格納
     enName: 星名(英字)
     visualGradeFrom: 実視等級(少ないほど明るい)
     direction: 方位(南を0°として西回りに360°まで)
     altitude: 高度(0°~90°)
     */
    
    var enNameString = NSMutableString()
    var visualGradeFromString = NSMutableString()
    var directionString = NSMutableString()
    var altitudeString = NSMutableString()
    
    var latitudeLocation: Double!
    var longitudeLocation: Double!
    var apiURL: URL!
    
=======
>>>>>>> ab65e4a7cb959de7a21b1ee5da0f4296842f32a4
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        
        sceneView.delegate = self
        sceneView.showsStatistics = false
        
        // 初期化
        rows = []
        
        // 現在地を取得
        setupLocationManager()

        // 表示する情報
        self.sceneView.scene = SCNScene()
        let node = SCNNode(geometry: SCNSphere(radius: 0.05))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/hoshi.png")
        node.geometry?.materials = [material]
        node.position = SCNVector3(6.7,8.7,10.1)
      
        let node2 = SCNNode(geometry: SCNSphere(radius: 0.05))
        let material2 = SCNMaterial()
        material2.diffuse.contents = UIImage(named: "art.scnassets/hosi4.jpg")
        node2.geometry?.materials = [material]
        node2.position = SCNVector3(-4.7,1.0,8.5)
      
        // 表示
        self.sceneView.scene.rootNode.addChildNode(node)
        self.sceneView.scene.rootNode.addChildNode(node2)
        
    }
    
    // 開始タグ
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        element = elementName
        
        if element == "star" {
            
            elements = NSMutableDictionary()
            elements = [:]
            
            enNameString = NSMutableString()
            enNameString = ""
            visualGradeFromString = NSMutableString()
            visualGradeFromString = ""
            directionString = NSMutableString()
            directionString = ""
            altitudeString = NSMutableString()
            altitudeString = ""
        }
    }
    
    // 開始タグと終了タグの間にデータが存在した時
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if element == "enName"{
            
            enNameString.append(string)
            
        } else if element == "visualGradeFrom"{
            
            visualGradeFromString.append(string)
            
        } else if element == "direction"{
            
            directionString.append(string)
            
        } else if element == "altitude"{
            
            altitudeString.append(string)
            
        }
    }
    
    // 終了タグ
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // 要素 star だったら
        if elementName == "star"{
            
            // enNameString の中身が空でないなら
            if enNameString != "" {
                // elementsにキー: enName を付与して、enNameString をセット
                elements.setObject(enNameString, forKey: "enName" as NSCopying)
            }
            
            // visualGradeFromString の中身が空でないなら
            if visualGradeFromString != "" {
                // elementsにキー: visualGradeFrom を付与して、 visualGradeFromString をセット
                elements.setObject(visualGradeFromString, forKey: "visualGradeFrom" as NSCopying)
            }
            
            // directionString の中身が空でないなら
            if directionString != "" {
                // elementsにキー: direction を付与して、 directionString をセット
                elements.setObject(directionString, forKey: "direction" as NSCopying)
            }
            
            // altitudeString の中身が空でないなら
            if altitudeString != "" {
                // elementsにキー: altitude を付与して、 altitudeString をセット
                elements.setObject(altitudeString, forKey: "altitude" as NSCopying)
            }
            
            // rowsの中にelementsを加える
            rows.add(elements)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
=======

        // Do any additional setup after loading the view.
    }
>>>>>>> ab65e4a7cb959de7a21b1ee5da0f4296842f32a4

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
<<<<<<< HEAD
    // location
    func setupLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        latitudeLocation = latitude
        longitudeLocation = longitude
        
        seturl(latiudeLocation: latitudeLocation!, longitudeLocation: longitudeLocation!)
    }
    
    func seturl (latiudeLocation: Double, longitudeLocation: Double) {
        
        /*:
         現在日時(年月日時分秒)を取得
         currentDate: 配列
         [年, 月, 日, 時, 分, 秒]
         */
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy,MM,dd,HH,mm,ss"
        format.timeZone   = TimeZone(identifier: "Asia/Tokyo")
        let cDate = format.string(from: date).split(separator: ",")
        
        // 現在日時、位置情報(仮)を用いてURLを生成
        let urlString:String = "http://www.walk-in-starrysky.com/star.do?cmd=display&year=\(cDate[0])&month=\(cDate[1])&day=\(cDate[2])&hour=\(cDate[3])&minute=\(cDate[4])&second=\(cDate[5])&latitude=\(latiudeLocation)&longitude=\(longitudeLocation)"
        let url:URL = URL(string:urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!  // 日本語入りStringをURLに変換
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
        apiURL = url

        // URL表示
        print(url)
        
        // 取得した星の情報を表示
        for value in rows {
            print(value)
        }
    }
    
    // Camera
    private func getScreenShot() -> UIImage? {
        guard let view = self.view else {
            return nil
        }
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
    }
=======

>>>>>>> ab65e4a7cb959de7a21b1ee5da0f4296842f32a4
}
