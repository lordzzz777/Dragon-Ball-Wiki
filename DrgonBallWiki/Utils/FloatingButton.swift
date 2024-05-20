//
//  FloatingButton.swift
//  teractiveFloatingButton
//
//  Created by Esteban Perez Castillejo on 18/5/24.
//

import SwiftUI

/// Custom Button
struct FloatingButton<Label: View>: View {
    /// Accion
    var buttonSize: CGFloat = 50
    var actions: [FloatingAction]
    
    var label: (Bool) -> Label
    
    init(buttonSize: CGFloat = 60, @FloationActionBuilder actions: @escaping () -> [FloatingAction], @ViewBuilder label: @escaping (Bool) -> Label) {
        self.buttonSize = buttonSize
        self.actions = actions()
        self.label = label
    }
    
    /// View Proviedad
    @State private var isExpanded: Bool = false
    @State private var dragLocaltion: CGPoint = .zero
    @State private var selectedAction: FloatingAction?
    @GestureState private var isDragging: Bool = false
    
    
    var body: some View {
        Button{
            isExpanded.toggle()
        }label: {
            label(isExpanded)
                .frame(width: buttonSize, height: buttonSize)
                .contentShape(.rect)
        }
        .buttonStyle(NoAnimationButtonStyle())
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.3)
                .onEnded{_ in
                    isExpanded = true
                }.sequenced(before: DragGesture().updating($isDragging, body: { _, out, _ in
                    out = true
                }) .onChanged{ value in
                    guard isExpanded else { return }
                    dragLocaltion = value.location
                }.onEnded{_ in
                    Task{
                        if let selectedAction {
                            isExpanded = false
                            selectedAction.action()
                        }
                        
                        selectedAction = nil
                        dragLocaltion = .zero
                    }
                })
        )
        .background{
            ZStack{
                ForEach(actions){
                    ActionView($0).shadow(color: .yellow, radius: 10)
                }
                
            }
            .frame(width: buttonSize, height: buttonSize)
        }
        .coordinateSpace(.named("FLOATING VIEW"))
        .animation(.snappy(duration: 0.4, extraBounce: 0), value: isExpanded)
    }
    
    /// Action View
    @ViewBuilder
    func ActionView(_ action: FloatingAction) -> some View {
        Button{
            action.action()
            isExpanded = false
        }label: {
            Image(action.symbol).resizable()
                .font(action.font)
                .foregroundStyle(action.tint) // cambia el color icono
                .frame(width: 50, height: 50)
                .background(action.background, in: .circle) // Cambia el color del fondo del boton
                .containerShape(.circle)
        }
        .buttonStyle(PressableButtonStyle())
        .disabled(!isExpanded)
        .animation(.snappy(duration: 0.3, extraBounce: 0)){ content in
            content
                .scaleEffect(selectedAction?.id == action.id ? 1.15 : 1)
        }
        .background{
            GeometryReader {
                let rect = $0.frame(in: .named("FLOATING VIEW"))
                
                Color.clear
                    .onChange(of: dragLocaltion) { oldValue, newValue in
                        if isExpanded && isDragging {
                            /// Checking if the  drag location is  inside any action´s rect
                            if rect.contains(newValue){
                                /// user is Presing on this Action
                                selectedAction = action
                            }else{
                                /// Cheking if it´s gone out of the rect
                                if selectedAction?.id == action.id && !rect.contains(newValue){
                                    selectedAction = nil
                                }
                            }
                        }
                    }
            }
        }
        .rotationEffect(.init(degrees: progress(action) * 90))
        .offset(x:  isExpanded ? -offset / -3 : 0 )
        .rotationEffect(.init(degrees: progress(action) * -90))
    }
    
    private var offset: CGFloat {
        let buttonSize = buttonSize + 10
        return Double(actions.count) * (actions.count == 1 ?  buttonSize * 2 : (actions.count == 2 ? buttonSize * 1.25 :  buttonSize))
    }
    
    private func progress(_ action:  FloatingAction) -> CGFloat {
        let index = CGFloat(actions.firstIndex(where: {$0.id == action.id}) ?? 0)
        return actions.count == 1 ? 1 : (index / CGFloat(actions.count - 1))
    }
    
}

/// Custom Buttons Styles
fileprivate struct NoAnimationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
    
}

fileprivate struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: configuration.isPressed )
    }
}

/// Propiedades del boton, color de fondo,  color
struct FloatingAction: Identifiable {
    private (set) var id: UUID = .init()
    var symbol: String
    var font: Font = .title3
    var tint: Color = .white
    var background: Color = .clear
    var action: () -> ()
}

/// SwoftUI View like Builder to get array of action using ResultBuilder
@resultBuilder
struct FloationActionBuilder {
    static func buildBlock(_ components: FloatingAction...) -> [FloatingAction] {
        components.compactMap({ $0 })
    }
    
}

#Preview {
   Home()
}
