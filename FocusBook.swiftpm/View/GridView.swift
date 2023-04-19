//
//  GridView.swift
//  
//
//  Created by 지준용 on 2023/04/16.
//

import SwiftUI

@available(iOS 16.0, *)
struct GridView: View {

    // MARK: - Property

    let screenSize: CGFloat
    private var lineWidth: CGFloat { isPreviewed ? 0 : 1 }
    private var borderColor: Color { isPreviewed ? .white : .gray }
    private var preview: String { isPreviewed ? TextLiteral.continue : TextLiteral.preview }

    @Environment(\.dismiss) private var dismiss
    @Environment(\.displayScale) private var displayScale

    @Binding var images: [UIImage] {
        didSet {
            dismiss()
        }
    }

    @State private var matrix: Set<String> = []
    @State private var renderedImage = UIImage(systemName: ImageLiteral.questionmark)
    @State private var numberOfCells = 15
    @State private var isPreviewed = false

    // MARK: - View

    var body: some View {
        GridStack(numberOfCells: numberOfCells) { row, column in
            colorCell(row: row, column: column)
                .border(self.borderColor, width: self.lineWidth)
                .onTapGesture {
                    let selectedCell = "\(row),\(column)"

                    if !self.matrix.contains(selectedCell) {
                        self.matrix.insert(selectedCell)
                    } else {
                        self.matrix.remove(selectedCell)
                    }
                }
        }
        .frame(width: self.screenSize * 0.9, height: self.screenSize * 0.9)
        .toolbar {
            Button(preview) {
                self.isPreviewed.toggle()
            }.foregroundColor(.blue)
            
            Button(TextLiteral.save) {
                self.images.insert(render(), at: self.images.count - 1)
            }
            .foregroundColor(self.isPreviewed ? .blue : .secondary)
            .disabled(self.isPreviewed ? false : true)
        }
    }
    
    private func colorCell(row: Int, column: Int) -> some View {
        let cell = Rectangle()
            .foregroundColor(self.matrix.contains("\(row),\(column)") ? .black : .white)
        return cell
    }

    // MARK: - Method

    @MainActor
    private func render() -> UIImage {
        let renderer = ImageRenderer(content: body)
        renderer.scale = displayScale

        if let uiImage = renderer.uiImage {
            self.renderedImage = uiImage
        }
        return renderedImage ?? UIImage()
    }
}
