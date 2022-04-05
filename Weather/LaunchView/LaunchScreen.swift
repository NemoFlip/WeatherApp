//
//  LaunchScreen.swift
//  Weather
//
//  Created by Артем Хлопцев on 02.04.2022.
//
import SwiftUI

struct LaunchScreen: View {
    @State var animateCircle1 = false
    @State var animateSplashShape = false
    @State var animateCircle2 = false
    @State var endSplashAnimation: Bool = false
    @Binding var endAnimation: Bool
    var body: some View {
        ZStack {
            Color.launchTheme.background
            
            Group {
                LaunchShape()
                    .trim(from: 0.1, to: animateSplashShape ? 0.9 : 0)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                Circle()
                    .fill(.white)
                    .frame(width: 35, height: 35)
                    .scaleEffect(animateCircle1 ? 1 : 0)
                    .offset(x: -105, y: -65)
                Circle()
                    .fill(.white)
                    .scaleEffect(animateCircle2 ? 1 : 0)
                    .frame(width: 35, height: 35)
                    .offset(x: 105, y: -65)
            }
            .scaleEffect(endSplashAnimation ? 0.5 : 1)
            .frame(width: 220, height: 130)
            
            Text("Weather")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, getSafeArea().bottom == 0 ? 15 : getSafeArea().bottom)
                .opacity(animateCircle1 ? 1 : 0)
                .scaleEffect(endSplashAnimation ? 0 : 1)
        }
        .offset(y: endAnimation ? (-getRect().height * 1.5) : 0)
        .ignoresSafeArea()
        .onAppear(perform: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                startAnimation()
//            }
        })
        
        
    }
    func startAnimation() {
        withAnimation(.spring().delay(0.1)) {
            self.animateCircle1.toggle()
        }
        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(0.2)) {
            self.animateSplashShape.toggle()
        }
        withAnimation(.spring().delay(0.6)) {
            self.animateCircle2.toggle()
        }
        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(1)) {
            self.endSplashAnimation = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2
) {
            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05)) {
                endAnimation = true
            }
        }
    }
}

struct SplashWView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(endAnimation: .constant(false))
    }
}
