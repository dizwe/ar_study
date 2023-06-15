//
//  ContentView.swift
//  AR_Test
//
//  Created by dizwe on 2023/06/11.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State private var model = try! Golf.loadGolfShot() // 구조체끼리의 통신을 위함 !는 확실히 있다는 표시임
    var body: some View {
        ZStack{
            ARViewContainer(model: $model)
            VStack {
                Spacer() // 아래로 보내주는거래!(그냥 공간 만들어주는 친구인거같음)
                Button(action: {
                    model.notifications.anim.post() // 직접 post
                }, label: {
                    Text("Animation").foregroundColor(.white).font(.title)
                })
                .frame(width: 200)
                .background(Color.blue)
                .cornerRadius(15)
                .padding()
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var model: Golf.GolfShot
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Golf.loadGolfShot() // 프로젝트와 장면

        // Add the box anchor to the scene
        arView.scene.anchors.append(model) // 모델을 붙여주기
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
