//
//  OnboardingView.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI

let onboardingSteps: [OnboardingItem] = [
    OnboardingItem(title: "Manage your tasks", description: "You can easily manage all of your daily tasks in DoMe for free", imageName: "onboarding-step-1"),
    OnboardingItem(title: "Create daily routine", description: "In Uptodo  you can create your personalized routine to stay productive", imageName: "onboarding-step-2"),
    OnboardingItem(title: "Orgonaize your tasks", description: "You can organize your daily tasks by adding your tasks into separate categories", imageName: "onboarding-step-3"),
]

struct OnboardingView: View {
    @State private var currentStepIndex = 0
    @Binding var isOnboardingComplete: Bool
    
    var body: some View {
        let isLastStep = self.currentStepIndex == onboardingSteps.count - 1

        NavigationView {
            TabView(selection: $currentStepIndex) {
                ForEach(onboardingSteps.indices, id: \.self) { index in
                    VStack {
                        Button("SKIP") {
                            isOnboardingComplete = true
                        }
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)

                        Image(onboardingSteps[index].imageName)
                            .frame(height: 300)
                        
                        Text(onboardingSteps[index].title)
                            .padding(.top, 50)
                            .latoBoldFont(size: 30)
                        
                        Text(onboardingSteps[index].description)
                            .multilineTextAlignment(.center)
                            .padding(.top, 30)
                            .latoFont(size: 18)
                        
                        Spacer()
                        
                        HStack {
                            Button("BACK") {
                                withAnimation {
                                    if currentStepIndex > 0 {
                                        currentStepIndex -= 1;
                                    }
                                }
                            }
                            .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Button(isLastStep ? "GET STARTED" : "NEXT") {
                                withAnimation {
                                    if isLastStep {
                                        isOnboardingComplete = true;
                                        return;
                                    }
                                    
                                    if currentStepIndex < onboardingSteps.count - 1 {
                                            currentStepIndex += 1
                                        }
                                    }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .animation(.easeInOut, value: currentStepIndex)
        }
        .padding()
    }
}

#Preview {
    OnboardingView(isOnboardingComplete: .constant(false))
}
