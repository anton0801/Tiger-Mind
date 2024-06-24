import SwiftUI
import Foundation
import Macaw

struct SVGImage: UIViewRepresentable {

    var svgName: String

    func makeUIView(context: Context) -> SVGView {
        let svgView = SVGView()
        svgView.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        svgView.fileName = self.svgName
        svgView.contentMode = .scaleToFill
        return svgView
    }

    func updateUIView(_ uiView: SVGView, context: Context) {

    }

}
