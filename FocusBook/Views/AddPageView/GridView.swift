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
    private let colors: [Color] = [.black, .red, .blue, .yellow]
    private var lineWidth: CGFloat { isPreviewed ? 0 : 1 }
    private var borderColor: Color { isPreviewed ? .white : .gray }
    private var preview: LocalizedStringKey { isPreviewed ? TextLiteral.continue : TextLiteral.preview }

    @Environment(\.dismiss) private var dismiss
    @Environment(\.displayScale) private var displayScale

    let imageFileManager = ImageFileManager.shared
    
    @Binding var images: [UIImage] {
        didSet {
            print(images.last!)
            dismiss()
        }
    }
    
    @State private var colorCount = 0
    @State private var matrix: Set<String> = []
    @State private var renderedImage = UIImage(systemName: ImageLiteral.questionmark)
    @State private var numberOfCells = 10
    @State private var isPreviewed = false

    // MARK: - View

    var body: some View {
        HStack {
            Spacer()
            
            gridView
            
            Spacer()
            
            if !isPreviewed {
                VStack(alignment: .trailing) {
                    colorTag
                    
                    Spacer()
                    
                    stepper
                        .scenePadding()
                }
            }
        }
        .edgesIgnoringSafeArea(.horizontal)
        .toolbar {
            Button(preview) {
                self.isPreviewed.toggle()
            }.foregroundColor(.blue)
            
            Button(TextLiteral.save) {
                let image = render()
                imageFileManager.saveImageToDirectory(image: image)
                
                self.images = imageFileManager.loadAllImageFromDirectory()
            }
            .foregroundColor(self.isPreviewed ? .blue : .secondary)
            .disabled(self.isPreviewed ? false : true)
        }
    }
    
    @ViewBuilder
    private var stepper: some View {
        VStack {
            Text("\(numberOfCells) x \(numberOfCells)")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            
            HStack(spacing: 0) {
                Button {
                    numberOfCells -= 1
                } label: {
                    Image(systemName: ImageLiteral.chevronDown)
                }
                .frame(width: 50, height: 50)
                .foregroundColor(.black)
                .disabled(numberOfCells <= 1 ? true : false)
                
                Rectangle()
                    .frame(width: 1, height: 50)
                
                Button {
                    numberOfCells += 1
                } label: {
                    Image(systemName: ImageLiteral.chevronUp)
                }
                .frame(width: 50, height: 50)
                .foregroundColor(.black)
                .disabled(numberOfCells >= 25 ? true : false)
            }
            .background(.gray)
            .buttonStyle(.bordered)
            .cornerRadius(8)
        }
    }
    
    @ViewBuilder
    private var gridView: some View {
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
        .frame(width: self.screenSize * 0.8, height: self.screenSize * 0.8)
        .scenePadding()
    }
    
    @ViewBuilder
    private var colorTag: some View {
        ForEach(0..<colors.count, id: \.self) { color in
            Rectangle()
                .onTapGesture {
                    colorCount = color
                }
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .frame(width: 50, height: 50)
                .foregroundColor(colors[color])
                .buttonStyle(.bordered)
        }
    }
    
    @ViewBuilder
    private func colorCell(row: Int, column: Int) -> some View {
        Rectangle()
            .foregroundColor(self.matrix.contains("\(row),\(column)") ? colors[colorCount] : (isPreviewed ? .clear : .white))
    }

    // MARK: - Method

    @MainActor
    private func render() -> UIImage {
        let renderer = ImageRenderer(content: gridView)
        renderer.scale = displayScale

        if let uiImage = renderer.uiImage {
            self.renderedImage = uiImage
        }
        return renderedImage ?? UIImage()
    }
}
