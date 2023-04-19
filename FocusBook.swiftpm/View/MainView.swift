import SwiftUI
import AVFAudio

@available(iOS 16.0, *)
struct MainView: View {

    // MARK: - Property

    private let screenSize = UIScreen.main.bounds.height > UIScreen.main.bounds.width ?
    UIScreen.main.bounds.width : UIScreen.main.bounds.height

    @Binding var audio: AVAudioPlayer!
    @Binding var isPresented: Bool
    @State private var images: [UIImage] = [UIImage(named: ImageLiteral.dog)!,
                                            UIImage(named: ImageLiteral.heart)!,
                                            UIImage(named: ImageLiteral.heartFill)!,
                                            UIImage(named: ImageLiteral.square)!,
                                            UIImage(named: ImageLiteral.smile)!,
                                            UIImage(named: ImageLiteral.plus)!]

    // MARK: - View

    var body: some View {
        VStack {
            Button {
                isPresented = true
            } label: {
                Image(uiImage: UIImage(named: ImageLiteral.appName)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical, 20)
            }

            NavigationLink(destination: FocusBookView(screenSize: screenSize, images: $images)) {
                Spacer()
                Text(TextLiteral.readingABook)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                Spacer()
            }
            .background(Color.black)
            .cornerRadius(8)

            NavigationLink(destination: PageListView(screenSize: screenSize, images: $images)) {
                
                Spacer()
                
                Text(TextLiteral.pageList)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                
                Spacer()
            }
            .background(Color.black)
            .cornerRadius(8)
        }
        .padding(.horizontal, 20)
    }
}
