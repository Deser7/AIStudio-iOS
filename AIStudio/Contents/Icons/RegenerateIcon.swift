//
//  RegenerateIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

struct RegenerateIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        var _hole2 = Path()
        _hole2.move(to: CGPoint(x: 0.02094*width, y: 0.67983*height))
        _hole2.addCurve(to: CGPoint(x: 0.138*width, y: 0.60301*height), control1: CGPoint(x: 0.02924*width, y: 0.62483*height), control2: CGPoint(x: 0.08374*width, y: 0.58906*height))
        _hole2.addLine(to: CGPoint(x: 0.26935*width, y: 0.63678*height))
        _hole2.addCurve(to: CGPoint(x: 0.30141*width, y: 0.6909*height), control1: CGPoint(x: 0.29326*width, y: 0.64294*height), control2: CGPoint(x: 0.30761*width, y: 0.66718*height))
        _hole2.addCurve(to: CGPoint(x: 0.24689*width, y: 0.72272*height), control1: CGPoint(x: 0.29521*width, y: 0.71462*height), control2: CGPoint(x: 0.2708*width, y: 0.72887*height))
        _hole2.addLine(to: CGPoint(x: 0.17031*width, y: 0.70299*height))
        _hole2.addCurve(to: CGPoint(x: 0.54979*width, y: 0.91002*height), control1: CGPoint(x: 0.23206*width, y: 0.79405*height), control2: CGPoint(x: 0.34883*width, y: 0.92513*height))
        _hole2.addCurve(to: CGPoint(x: 0.80357*width, y: 0.80492*height), control1: CGPoint(x: 0.65095*width, y: 0.90241*height), control2: CGPoint(x: 0.73872*width, y: 0.85803*height))
        _hole2.addCurve(to: CGPoint(x: 0.88048*width, y: 0.72455*height), control1: CGPoint(x: 0.83592*width, y: 0.77842*height), control2: CGPoint(x: 0.86191*width, y: 0.75028*height))
        _hole2.addCurve(to: CGPoint(x: 0.9114*width, y: 0.66429*height), control1: CGPoint(x: 0.89956*width, y: 0.6981*height), control2: CGPoint(x: 0.90887*width, y: 0.67687*height))
        _hole2.addCurve(to: CGPoint(x: 0.96397*width, y: 0.62946*height), control1: CGPoint(x: 0.91622*width, y: 0.64026*height), control2: CGPoint(x: 0.93975*width, y: 0.62468*height))
        _hole2.addCurve(to: CGPoint(x: 0.99912*width, y: 0.68163*height), control1: CGPoint(x: 0.98819*width, y: 0.63425*height), control2: CGPoint(x: 1.00395*width, y: 0.65759*height))
        _hole2.addCurve(to: CGPoint(x: 0.95319*width, y: 0.77623*height), control1: CGPoint(x: 0.99313*width, y: 0.71153*height), control2: CGPoint(x: 0.97599*width, y: 0.74462*height))
        _hole2.addCurve(to: CGPoint(x: 0.86054*width, y: 0.87336*height), control1: CGPoint(x: 0.92986*width, y: 0.80856*height), control2: CGPoint(x: 0.89849*width, y: 0.84227*height))
        _hole2.addCurve(to: CGPoint(x: 0.55654*width, y: 0.99852*height), control1: CGPoint(x: 0.78475*width, y: 0.93542*height), control2: CGPoint(x: 0.67998*width, y: 0.98923*height))
        _hole2.addCurve(to: CGPoint(x: 0.09963*width, y: 0.7576*height), control1: CGPoint(x: 0.31084*width, y: 1.017*height), control2: CGPoint(x: 0.1689*width, y: 0.85815*height))
        _hole2.addLine(to: CGPoint(x: 0.08897*width, y: 0.8284*height))
        _hole2.addCurve(to: CGPoint(x: 0.03811*width, y: 0.86571*height), control1: CGPoint(x: 0.08531*width, y: 0.85263*height), control2: CGPoint(x: 0.06253*width, y: 0.86934*height))
        _hole2.addCurve(to: CGPoint(x: 0.00051*width, y: 0.81525*height), control1: CGPoint(x: 0.01368*width, y: 0.86208*height), control2: CGPoint(x: -0.00315*width, y: 0.83949*height))
        _hole2.addLine(to: CGPoint(x: 0.02094*width, y: 0.67983*height))
        _hole2.closeSubpath()
        _hole2.move(to: CGPoint(x: 0.69997*width, y: 0.65001*height))
        _hole2.addCurve(to: CGPoint(x: 0.74998*width, y: 0.69997*height), control1: CGPoint(x: 0.72758*width, y: 0.65001*height), control2: CGPoint(x: 0.74997*width, y: 0.67237*height))
        _hole2.addCurve(to: CGPoint(x: 0.69997*width, y: 0.74998*height), control1: CGPoint(x: 0.74998*width, y: 0.72759*height), control2: CGPoint(x: 0.72759*width, y: 0.74998*height))
        _hole2.addCurve(to: CGPoint(x: 0.65*width, y: 0.69997*height), control1: CGPoint(x: 0.67237*width, y: 0.74998*height), control2: CGPoint(x: 0.65*width, y: 0.72758*height))
        _hole2.addCurve(to: CGPoint(x: 0.69997*width, y: 0.65001*height), control1: CGPoint(x: 0.65002*width, y: 0.67238*height), control2: CGPoint(x: 0.67238*width, y: 0.65002*height))
        _hole2.closeSubpath()
        _hole2.move(to: CGPoint(x: 0.47552*width, y: 0.36925*height))
        _hole2.addCurve(to: CGPoint(x: 0.52448*width, y: 0.36925*height), control1: CGPoint(x: 0.48175*width, y: 0.34359*height), control2: CGPoint(x: 0.51825*width, y: 0.34359*height))
        _hole2.addLine(to: CGPoint(x: 0.54161*width, y: 0.43989*height))
        _hole2.addCurve(to: CGPoint(x: 0.56012*width, y: 0.4584*height), control1: CGPoint(x: 0.54383*width, y: 0.44903*height), control2: CGPoint(x: 0.55097*width, y: 0.45617*height))
        _hole2.addLine(to: CGPoint(x: 0.63076*width, y: 0.47553*height))
        _hole2.addCurve(to: CGPoint(x: 0.63076*width, y: 0.52448*height), control1: CGPoint(x: 0.6564*width, y: 0.48176*height), control2: CGPoint(x: 0.65641*width, y: 0.51825*height))
        _hole2.addLine(to: CGPoint(x: 0.56012*width, y: 0.54161*height))
        _hole2.addCurve(to: CGPoint(x: 0.54161*width, y: 0.56012*height), control1: CGPoint(x: 0.55097*width, y: 0.54383*height), control2: CGPoint(x: 0.54383*width, y: 0.55097*height))
        _hole2.addLine(to: CGPoint(x: 0.52448*width, y: 0.63076*height))
        _hole2.addCurve(to: CGPoint(x: 0.47552*width, y: 0.63076*height), control1: CGPoint(x: 0.51825*width, y: 0.65641*height), control2: CGPoint(x: 0.48176*width, y: 0.65641*height))
        _hole2.addLine(to: CGPoint(x: 0.4584*width, y: 0.56012*height))
        _hole2.addCurve(to: CGPoint(x: 0.43988*width, y: 0.54161*height), control1: CGPoint(x: 0.45617*width, y: 0.55097*height), control2: CGPoint(x: 0.44903*width, y: 0.54384*height))
        _hole2.addLine(to: CGPoint(x: 0.36924*width, y: 0.52448*height))
        _hole2.addCurve(to: CGPoint(x: 0.36473*width, y: 0.52297*height), control1: CGPoint(x: 0.36764*width, y: 0.52409*height), control2: CGPoint(x: 0.36613*width, y: 0.52358*height))
        _hole2.addCurve(to: CGPoint(x: 0.36924*width, y: 0.47553*height), control1: CGPoint(x: 0.34368*width, y: 0.51381*height), control2: CGPoint(x: 0.34519*width, y: 0.48137*height))
        _hole2.addLine(to: CGPoint(x: 0.43988*width, y: 0.4584*height))
        _hole2.addCurve(to: CGPoint(x: 0.4584*width, y: 0.43989*height), control1: CGPoint(x: 0.44903*width, y: 0.45617*height), control2: CGPoint(x: 0.45617*width, y: 0.44903*height))
        _hole2.addLine(to: CGPoint(x: 0.47552*width, y: 0.36925*height))
        _hole2.closeSubpath()
        _hole2.move(to: CGPoint(x: 0.44342*width, y: 0.00149*height))
        _hole2.addCurve(to: CGPoint(x: 0.90033*width, y: 0.24238*height), control1: CGPoint(x: 0.68911*width, y: -0.01699*height), control2: CGPoint(x: 0.83105*width, y: 0.14182*height))
        _hole2.addLine(to: CGPoint(x: 0.91103*width, y: 0.17162*height))
        _hole2.addCurve(to: CGPoint(x: 0.9619*width, y: 0.1343*height), control1: CGPoint(x: 0.91469*width, y: 0.14738*height), control2: CGPoint(x: 0.93747*width, y: 0.13067*height))
        _hole2.addCurve(to: CGPoint(x: 0.99949*width, y: 0.18476*height), control1: CGPoint(x: 0.98631*width, y: 0.13794*height), control2: CGPoint(x: 1.00315*width, y: 0.16053*height))
        _hole2.addLine(to: CGPoint(x: 0.97903*width, y: 0.32018*height))
        _hole2.addCurve(to: CGPoint(x: 0.862*width, y: 0.39696*height), control1: CGPoint(x: 0.97072*width, y: 0.37517*height), control2: CGPoint(x: 0.91625*width, y: 0.4109*height))
        _hole2.addLine(to: CGPoint(x: 0.73065*width, y: 0.36318*height))
        _hole2.addCurve(to: CGPoint(x: 0.69859*width, y: 0.30911*height), control1: CGPoint(x: 0.70675*width, y: 0.35704*height), control2: CGPoint(x: 0.6924*width, y: 0.33283*height))
        _hole2.addCurve(to: CGPoint(x: 0.75307*width, y: 0.27729*height), control1: CGPoint(x: 0.70479*width, y: 0.28539*height), control2: CGPoint(x: 0.72917*width, y: 0.27115*height))
        _hole2.addLine(to: CGPoint(x: 0.82961*width, y: 0.29694*height))
        _hole2.addCurve(to: CGPoint(x: 0.45022*width, y: 0.08999*height), control1: CGPoint(x: 0.76785*width, y: 0.20589*height), control2: CGPoint(x: 0.65111*width, y: 0.07489*height))
        _hole2.addCurve(to: CGPoint(x: 0.19639*width, y: 0.19509*height), control1: CGPoint(x: 0.34904*width, y: 0.0976*height), control2: CGPoint(x: 0.26124*width, y: 0.14198*height))
        _hole2.addCurve(to: CGPoint(x: 0.11953*width, y: 0.27546*height), control1: CGPoint(x: 0.16405*width, y: 0.22159*height), control2: CGPoint(x: 0.13809*width, y: 0.24973*height))
        _hole2.addCurve(to: CGPoint(x: 0.0886*width, y: 0.33568*height), control1: CGPoint(x: 0.10045*width, y: 0.3019*height), control2: CGPoint(x: 0.09113*width, y: 0.3231*height))
        _hole2.addCurve(to: CGPoint(x: 0.03599*width, y: 0.37055*height), control1: CGPoint(x: 0.08378*width, y: 0.35972*height), control2: CGPoint(x: 0.06022*width, y: 0.37533*height))
        _hole2.addCurve(to: CGPoint(x: 0.00088*width, y: 0.31838*height), control1: CGPoint(x: 0.01178*width, y: 0.36576*height), control2: CGPoint(x: -0.00394*width, y: 0.34241*height))
        _hole2.addCurve(to: CGPoint(x: 0.04682*width, y: 0.22378*height), control1: CGPoint(x: 0.00687*width, y: 0.28848*height), control2: CGPoint(x: 0.02401*width, y: 0.25539*height))
        _hole2.addCurve(to: CGPoint(x: 0.13947*width, y: 0.12665*height), control1: CGPoint(x: 0.07014*width, y: 0.19145*height), control2: CGPoint(x: 0.10151*width, y: 0.15774*height))
        _hole2.addCurve(to: CGPoint(x: 0.44342*width, y: 0.00149*height), control1: CGPoint(x: 0.21524*width, y: 0.06459*height), control2: CGPoint(x: 0.31999*width, y: 0.01078*height))
        _hole2.closeSubpath()
        _hole2.move(to: CGPoint(x: 0.29999*width, y: 0.25003*height))
        _hole2.addCurve(to: CGPoint(x: 0.35*width, y: 0.29999*height), control1: CGPoint(x: 0.3276*width, y: 0.25003*height), control2: CGPoint(x: 0.34999*width, y: 0.27239*height))
        _hole2.addCurve(to: CGPoint(x: 0.29999*width, y: 0.35*height), control1: CGPoint(x: 0.35*width, y: 0.32761*height), control2: CGPoint(x: 0.3276*width, y: 0.35*height))
        _hole2.addCurve(to: CGPoint(x: 0.25002*width, y: 0.29999*height), control1: CGPoint(x: 0.27238*width, y: 0.35*height), control2: CGPoint(x: 0.25002*width, y: 0.3276*height))
        _hole2.addCurve(to: CGPoint(x: 0.29999*width, y: 0.25003*height), control1: CGPoint(x: 0.25003*width, y: 0.27239*height), control2: CGPoint(x: 0.27239*width, y: 0.25003*height))
        _hole2.closeSubpath()
        path.addPath(_hole2)
        return path
    }
}

#Preview {
    RegenerateIcon()
        .fill(.black)
        .frame(width: 48, height: 48)
        .padding()
}
