//
//  ContentView.swift
//  Factor
//
//  Created by Aref Azizian on 6/25/20.
//  Copyright © 2020 Aref Azizian. All rights reserved.
//

import SwiftUI

func GetFont(size: CGFloat) -> Font {
    return Font.custom("Shabnam-Light", size: CGFloat(size))
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

struct ContentView: View {
    @State private var phone : String = ""
    
    let msg = "شماره همراه خود را برای دریافت کد فعالسازی وارد کنید"
    
    let purple = Color.init(hexStringToUIColor(hex: "#4d148c"))
    
    let grey = Color.init(hexStringToUIColor(hex: "#9e000000"))
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        VStack{
            
            VStack(alignment: .trailing){
                Text("سلام !").font(GetFont(size: 32)).multilineTextAlignment(.trailing).frame(width: 100, height: 52, alignment: .trailing)
                
                Text(msg).font(GetFont(size: 14)).multilineTextAlignment(.trailing).frame(width: 175, height: 46, alignment: .trailing).foregroundColor(grey)
                
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80, alignment: .trailing).padding()
            
            Form{
                Section{
                    TextField("شماره تلفن",text:$phone).font(GetFont(size: 16)).multilineTextAlignment(.trailing).foregroundColor(grey)
                }
                
                Section{
                    Button(action: {
                        
                    }){
                        Text("ارسال کد فعال سازی").font(GetFont(size: 14)).multilineTextAlignment(.center)
                    }
                    .frame(width:144, height:36, alignment: .center)
                    .background(purple).foregroundColor(Color.white).multilineTextAlignment(.trailing)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .trailing)
                    
                    .disabled(!self.phone.matches("^(0)?9([0-9]{9})$"))
            }.background(Color.white)
            
            Image("objects").resizable().aspectRatio(contentMode: .fit)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
