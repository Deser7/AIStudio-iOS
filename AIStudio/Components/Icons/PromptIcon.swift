//
//  PromptIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct PromptIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        var _hole2 = Path()
        _hole2.move(to: CGPoint(x: 0.33334*width, y: 0.29167*height))
        _hole2.addCurve(to: CGPoint(x: 0.37501*width, y: 0.25*height), control1: CGPoint(x: 0.33334*width, y: 0.26865*height), control2: CGPoint(x: 0.35199*width, y: 0.25*height))
        _hole2.addLine(to: CGPoint(x: 0.625*width, y: 0.25*height))
        _hole2.addCurve(to: CGPoint(x: 0.66667*width, y: 0.29167*height), control1: CGPoint(x: 0.64802*width, y: 0.25*height), control2: CGPoint(x: 0.66667*width, y: 0.26865*height))
        _hole2.addCurve(to: CGPoint(x: 0.625*width, y: 0.33333*height), control1: CGPoint(x: 0.66667*width, y: 0.31468*height), control2: CGPoint(x: 0.64802*width, y: 0.33333*height))
        _hole2.addLine(to: CGPoint(x: 0.54167*width, y: 0.33333*height))
        _hole2.addLine(to: CGPoint(x: 0.54167*width, y: 0.66667*height))
        _hole2.addLine(to: CGPoint(x: 0.625*width, y: 0.66667*height))
        _hole2.addCurve(to: CGPoint(x: 0.66667*width, y: 0.70833*height), control1: CGPoint(x: 0.64802*width, y: 0.66667*height), control2: CGPoint(x: 0.66667*width, y: 0.68532*height))
        _hole2.addCurve(to: CGPoint(x: 0.625*width, y: 0.75*height), control1: CGPoint(x: 0.66667*width, y: 0.73135*height), control2: CGPoint(x: 0.64802*width, y: 0.75*height))
        _hole2.addLine(to: CGPoint(x: 0.37501*width, y: 0.75*height))
        _hole2.addCurve(to: CGPoint(x: 0.33334*width, y: 0.70833*height), control1: CGPoint(x: 0.35199*width, y: 0.75*height), control2: CGPoint(x: 0.33334*width, y: 0.73135*height))
        _hole2.addCurve(to: CGPoint(x: 0.37501*width, y: 0.66667*height), control1: CGPoint(x: 0.33334*width, y: 0.68532*height), control2: CGPoint(x: 0.35199*width, y: 0.66667*height))
        _hole2.addLine(to: CGPoint(x: 0.45834*width, y: 0.66667*height))
        _hole2.addLine(to: CGPoint(x: 0.45834*width, y: 0.33333*height))
        _hole2.addLine(to: CGPoint(x: 0.37501*width, y: 0.33333*height))
        _hole2.addCurve(to: CGPoint(x: 0.33334*width, y: 0.29167*height), control1: CGPoint(x: 0.35199*width, y: 0.33333*height), control2: CGPoint(x: 0.33334*width, y: 0.31468*height))
        _hole2.closeSubpath()
        path.addPath(_hole2)
        var _hole4 = Path()
        _hole4.move(to: CGPoint(x: 0.79167*width, y: 0.91667*height))
        _hole4.addCurve(to: CGPoint(x: 0.75*width, y: 0.95833*height), control1: CGPoint(x: 0.79167*width, y: 0.93968*height), control2: CGPoint(x: 0.77302*width, y: 0.95833*height))
        _hole4.addCurve(to: CGPoint(x: 0.70834*width, y: 0.91667*height), control1: CGPoint(x: 0.72699*width, y: 0.95833*height), control2: CGPoint(x: 0.70834*width, y: 0.93968*height))
        _hole4.addCurve(to: CGPoint(x: 0.75*width, y: 0.875*height), control1: CGPoint(x: 0.70834*width, y: 0.89365*height), control2: CGPoint(x: 0.72699*width, y: 0.875*height))
        _hole4.addCurve(to: CGPoint(x: 0.79167*width, y: 0.91667*height), control1: CGPoint(x: 0.77302*width, y: 0.875*height), control2: CGPoint(x: 0.79167*width, y: 0.89365*height))
        _hole4.closeSubpath()
        path.addPath(_hole4)
        var _hole6 = Path()
        _hole6.move(to: CGPoint(x: 0.95834*width, y: 0.75*height))
        _hole6.addCurve(to: CGPoint(x: 0.91667*width, y: 0.79167*height), control1: CGPoint(x: 0.95834*width, y: 0.77301*height), control2: CGPoint(x: 0.93968*width, y: 0.79167*height))
        _hole6.addCurve(to: CGPoint(x: 0.875*width, y: 0.75*height), control1: CGPoint(x: 0.89366*width, y: 0.79167*height), control2: CGPoint(x: 0.875*width, y: 0.77301*height))
        _hole6.addCurve(to: CGPoint(x: 0.91667*width, y: 0.70833*height), control1: CGPoint(x: 0.875*width, y: 0.72699*height), control2: CGPoint(x: 0.89366*width, y: 0.70833*height))
        _hole6.addCurve(to: CGPoint(x: 0.95834*width, y: 0.75*height), control1: CGPoint(x: 0.93968*width, y: 0.70833*height), control2: CGPoint(x: 0.95834*width, y: 0.72699*height))
        _hole6.closeSubpath()
        path.addPath(_hole6)
        var _hole8 = Path()
        _hole8.move(to: CGPoint(x: 0.3752*width, y: 0.92978*height))
        _hole8.addCurve(to: CGPoint(x: 0.32695*width, y: 0.9518*height), control1: CGPoint(x: 0.36796*width, y: 0.94918*height), control2: CGPoint(x: 0.34636*width, y: 0.95904*height))
        _hole8.addCurve(to: CGPoint(x: 0.04874*width, y: 0.68428*height), control1: CGPoint(x: 0.20127*width, y: 0.90489*height), control2: CGPoint(x: 0.10031*width, y: 0.8075*height))
        _hole8.addCurve(to: CGPoint(x: 0.06886*width, y: 0.63521*height), control1: CGPoint(x: 0.04075*width, y: 0.66518*height), control2: CGPoint(x: 0.04976*width, y: 0.64321*height))
        _hole8.addCurve(to: CGPoint(x: 0.11793*width, y: 0.65533*height), control1: CGPoint(x: 0.08797*width, y: 0.62722*height), control2: CGPoint(x: 0.10993*width, y: 0.63622*height))
        _hole8.addCurve(to: CGPoint(x: 0.35318*width, y: 0.88153*height), control1: CGPoint(x: 0.16151*width, y: 0.75948*height), control2: CGPoint(x: 0.24694*width, y: 0.84188*height))
        _hole8.addCurve(to: CGPoint(x: 0.3752*width, y: 0.92978*height), control1: CGPoint(x: 0.37258*width, y: 0.88877*height), control2: CGPoint(x: 0.38244*width, y: 0.91038*height))
        _hole8.closeSubpath()
        path.addPath(_hole8)
        var _hole10 = Path()
        _hole10.move(to: CGPoint(x: 0.92981*width, y: 0.37586*height))
        _hole10.addCurve(to: CGPoint(x: 0.88155*width, y: 0.35388*height), control1: CGPoint(x: 0.91041*width, y: 0.38312*height), control2: CGPoint(x: 0.8888*width, y: 0.37328*height))
        _hole10.addCurve(to: CGPoint(x: 0.65289*width, y: 0.11802*height), control1: CGPoint(x: 0.84158*width, y: 0.24706*height), control2: CGPoint(x: 0.75822*width, y: 0.16128*height))
        _hole10.addCurve(to: CGPoint(x: 0.63245*width, y: 0.06908*height), control1: CGPoint(x: 0.63374*width, y: 0.11015*height), control2: CGPoint(x: 0.62458*width, y: 0.08824*height))
        _hole10.addCurve(to: CGPoint(x: 0.68139*width, y: 0.04864*height), control1: CGPoint(x: 0.64032*width, y: 0.04993*height), control2: CGPoint(x: 0.66223*width, y: 0.04078*height))
        _hole10.addCurve(to: CGPoint(x: 0.95179*width, y: 0.3276*height), control1: CGPoint(x: 0.80595*width, y: 0.0998*height), control2: CGPoint(x: 0.90449*width, y: 0.20116*height))
        _hole10.addCurve(to: CGPoint(x: 0.92981*width, y: 0.37586*height), control1: CGPoint(x: 0.95905*width, y: 0.347*height), control2: CGPoint(x: 0.94921*width, y: 0.36861*height))
        _hole10.closeSubpath()
        path.addPath(_hole10)
        var _hole12 = Path()
        _hole12.move(to: CGPoint(x: 0.15461*width, y: 0.06604*height))
        _hole12.addCurve(to: CGPoint(x: 0.1954*width, y: 0.06604*height), control1: CGPoint(x: 0.1598*width, y: 0.04465*height), control2: CGPoint(x: 0.19021*width, y: 0.04465*height))
        _hole12.addLine(to: CGPoint(x: 0.20967*width, y: 0.12489*height))
        _hole12.addCurve(to: CGPoint(x: 0.22512*width, y: 0.14034*height), control1: CGPoint(x: 0.21152*width, y: 0.13252*height), control2: CGPoint(x: 0.21748*width, y: 0.13848*height))
        _hole12.addLine(to: CGPoint(x: 0.28396*width, y: 0.1546*height))
        _hole12.addCurve(to: CGPoint(x: 0.28396*width, y: 0.19539*height), control1: CGPoint(x: 0.30535*width, y: 0.15979*height), control2: CGPoint(x: 0.30535*width, y: 0.19021*height))
        _hole12.addLine(to: CGPoint(x: 0.22512*width, y: 0.20966*height))
        _hole12.addCurve(to: CGPoint(x: 0.22234*width, y: 0.21055*height), control1: CGPoint(x: 0.22416*width, y: 0.20989*height), control2: CGPoint(x: 0.22324*width, y: 0.21019*height))
        _hole12.addCurve(to: CGPoint(x: 0.20967*width, y: 0.22511*height), control1: CGPoint(x: 0.21606*width, y: 0.21303*height), control2: CGPoint(x: 0.21129*width, y: 0.21843*height))
        _hole12.addLine(to: CGPoint(x: 0.1954*width, y: 0.28396*height))
        _hole12.addCurve(to: CGPoint(x: 0.19414*width, y: 0.28772*height), control1: CGPoint(x: 0.19508*width, y: 0.2853*height), control2: CGPoint(x: 0.19465*width, y: 0.28655*height))
        _hole12.addCurve(to: CGPoint(x: 0.15461*width, y: 0.28396*height), control1: CGPoint(x: 0.18651*width, y: 0.30526*height), control2: CGPoint(x: 0.15947*width, y: 0.30401*height))
        _hole12.addLine(to: CGPoint(x: 0.14034*width, y: 0.22511*height))
        _hole12.addCurve(to: CGPoint(x: 0.13995*width, y: 0.2237*height), control1: CGPoint(x: 0.14023*width, y: 0.22464*height), control2: CGPoint(x: 0.14009*width, y: 0.22416*height))
        _hole12.addCurve(to: CGPoint(x: 0.12489*width, y: 0.20966*height), control1: CGPoint(x: 0.13774*width, y: 0.21675*height), control2: CGPoint(x: 0.13205*width, y: 0.2114*height))
        _hole12.addLine(to: CGPoint(x: 0.06605*width, y: 0.19539*height))
        _hole12.addCurve(to: CGPoint(x: 0.06229*width, y: 0.19414*height), control1: CGPoint(x: 0.06471*width, y: 0.19507*height), control2: CGPoint(x: 0.06346*width, y: 0.19465*height))
        _hole12.addCurve(to: CGPoint(x: 0.06605*width, y: 0.1546*height), control1: CGPoint(x: 0.04474*width, y: 0.1865*height), control2: CGPoint(x: 0.046*width, y: 0.15947*height))
        _hole12.addLine(to: CGPoint(x: 0.12489*width, y: 0.14034*height))
        _hole12.addCurve(to: CGPoint(x: 0.14034*width, y: 0.12489*height), control1: CGPoint(x: 0.13253*width, y: 0.13848*height), control2: CGPoint(x: 0.13849*width, y: 0.13252*height))
        _hole12.addLine(to: CGPoint(x: 0.15461*width, y: 0.06604*height))
        _hole12.closeSubpath()
        path.addPath(_hole12)
        
        return path
    }
}

#Preview {
    PromptIcon()
        .fill(.black)
        .frame(width: 48, height: 48)
}
