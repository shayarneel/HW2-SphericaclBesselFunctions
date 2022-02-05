//
//  ContentView.swift
//  Shared
//
//  Created by Shayarneel Kundu on 2/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var guess = ""
    @State private var totalInput: Int? = 18
    
    private var intFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f
    }()
    
    var body: some View {
    
       VStack {
            HStack {
                
                TextEditor(text: $guess)

                
                Button("Calculate Bessel Functions", action: CalculateSphericalBesselFunc)
                    }
            .frame(minHeight: 300, maxHeight: 800)
            .frame(minWidth: 480, maxWidth: 800)
            .padding()
        
        HStack{
            
            Text(verbatim: "Order:")
            .padding()
            TextField("Total", value: $totalInput, formatter: intFormatter)
        
                .padding()
            
            }
        }
        
    }
    
    func CalculateSphericalBesselFunc()  {

    let xmax = 16.0                     /* maximum of the xvals */
    let xmin = 0.1                      /* minimum of the xvals */
    let step = 0.1                      /* increasing xvals by 0.1 */
    let order = totalInput ?? 0         /* order of Spherical Bessel function */
    let start = order+25                /* used for downward algorithm */
    var x = 0.0
    var maxIndex = 0
    guess = String(format: "j%d(x)\n", order)
    maxIndex = Int(((xmax-xmin)/step))+1

    for index in (0...maxIndex)
    {
        x = Double(index)*step + xmin
        
        let DownRecVals = DownwardRecursion(xval: x, order: order, start: start)
        let UpRecVals = UpwardRecursion(xval: x, order: order)
        /* Redefined this mess to help with computing relative error*/
        
        let RelError = (abs(UpRecVals - DownRecVals))/(abs(UpRecVals) + abs(DownRecVals))
        /* This one was put in to satisfy sub question 4 about relative errors*/
        
        guess += String(format: "x = %f, Downward, %7.5e, Upward, %7.5e, Relative Error, %7.5e\n", x, DownRecVals, UpRecVals, RelError)
        
    }
        

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
