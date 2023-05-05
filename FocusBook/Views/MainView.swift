import SwiftUI
import AVFAudio

@available(iOS 16.0, *)
struct MainView: View {

    // MARK: - Property

    private let screenSize = UIScreen.main.bounds.height > UIScreen.main.bounds.width ?
    UIScreen.main.bounds.width : UIScreen.main.bounds.height
    @Binding var isPresented: Bool
    @State private var images: [UIImage] = CoreDataManager.shared.fetchImage()
//    + [UIImage(named: ImageLiteral.dog)!, UIImage(named: ImageLiteral.heartFill)!, UIImage(named: ImageLiteral.square)!]

    // MARK: - View

    var body: some View {
        VStack {
            appLogo
            
            NavigationLink(destination: FocusBookView(screenSize: screenSize, images: $images)) {
                
                Spacer()
                
                Text(TextLiteral.readingABook)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.vertical, 4)
                
                Spacer()
            }
            .background(Color.black)
            .buttonStyle(.bordered)
            .cornerRadius(8)

            NavigationLink(destination: PageListView(screenSize: screenSize, images: $images)) {
                
                Spacer()
                
                Text(TextLiteral.pageList)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.vertical, 4)
                
                Spacer()
            }
            .background(Color.black)
            .buttonStyle(.bordered)
            .cornerRadius(8)
        }
        .padding(.horizontal, 20)
    }
    
    private var appLogo: some View {
        Button {
            isPresented = true
        } label: {
            Image(uiImage: UIImage(named: ImageLiteral.appName)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical, 20)
        }
    }
}
