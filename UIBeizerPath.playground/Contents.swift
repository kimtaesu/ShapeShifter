import UIKit

let width = 100
let height = 50
let cross = UIBezierPath()
cross.move(to: CGPoint(x: 10, y: 100)) // your point
cross.addLine(to: CGPoint(x: 100, y: 10)) // your point
cross.lineWidth = 12
cross.lineCapStyle = .round
cross.stroke()

let ovalLine = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50))
ovalLine.lineWidth = 2
UIColor.clear.setFill()
UIColor.red.setStroke()
ovalLine.stroke()
