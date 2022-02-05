//
//  Spherical Bessel Functions.swift
//  HW2-SphericalBesselFunction
//
//  Created by Shayarneel Kundu on 2/2/22.
//

import Foundation
import SwiftUI


/* Calculate Spherical Bessel functions using upward recursion */
/// UpwardRecursion
/// - Parameters:
///   - xval: x
///   - order: Order of Bessel Function
///             2l+1
///     J     (x)  =   ------  J  (x)  -  J       (x)
///      l + 1           x        l            l - 1
///
///
func UpwardRecursion (xval: Double, order: Int) -> Double
{
    var ZeroSphericalBessel = 0.0 /* temporary placeholders through the upward recursion */
    var FirstSphericalBessel = 0.0/* temporary placeholders through the upward recursion */
    var FinalSphericalBessel = 0.0 /* holds final Bessel Function result */
    
    // Start by defining the initial values that are required for the recursion relation
    ZeroSphericalBessel = CalculateZeroSphericalBessel(xval: xval)
    FirstSphericalBessel = CalculateFirstSphericalBessel(xval: xval)
    
    
    if (order == 0) {
        
        FinalSphericalBessel = ZeroSphericalBessel
        
    } else if (order == 1) {
        
        FinalSphericalBessel = FirstSphericalBessel
        
    } else {
        
        for index in (1..<order)             /* loop for order of function */
        {
            // This is the recursion relation
            FinalSphericalBessel = ((2.0*(Double(index)) + 1)/xval)*FirstSphericalBessel - ZeroSphericalBessel
            
            // This is redefining the variables for future recusrions
            ZeroSphericalBessel = FirstSphericalBessel
            FirstSphericalBessel = FinalSphericalBessel
        }
    }
    return(FinalSphericalBessel)
}



/* Calculate Spherical Bessel functions using upward recursion */
/// UpwardRecursion
/// - Parameters:
///   - xval: x
///   - order: Order of Bessel Function
///             2l+1
///     J     (x)  =   ------  J  (x)  -  J       (x)
///      l - 1           x        l            l + 1
///
///
func DownwardRecursion (xval: Double, order: Int, start: Int) -> Double
{
    var scale = CalculateZeroSphericalBessel(xval: xval) /* j_{0}, for which we have a nice close form solution that was used to comptue it. Used for scaling the downward recursion. */
    
    var jArray = Array(repeating: 0.0, count: start + 2) /* jArray is an array that holds the various orders of the Bessel Function */
    
    
    jArray[start+1] = 1.0                   // start with "guess"
    jArray[start] = 1.0                      // start with "guess"
    
    for index in (1...start).reversed(){
        
        jArray[index-1] = ((2.0*(Double(index)) + 1)/xval)*jArray[index] - jArray[index+1]
    }
    
    scale = (scale)/jArray[0];      /* scale the result */
    
    return(jArray[order]*(scale))  
}



/// CalculateZeroSphericalBessel
/// - Parameter xval: x
/// - Returns: Zeroth Spherical Bessel Function
// j_{0}(x) = sin(x)/x


func CalculateZeroSphericalBessel (xval: Double) -> Double{
    
    let zsb = sin(xval)/xval
    
    return zsb
    
}


/// CalculateFirstSphericalBessel
/// - Parameter xval: x
/// - Returns: First Spherical Bessel Function
// j_{1} =  (sin(x)/x^{2}) - (cos(x)/x)

func CalculateFirstSphericalBessel (xval: Double) -> Double{
    
    let fsb = (sin(xval)/pow(xval,2)) - (cos(xval)/xval)
    
    return fsb
    
}
