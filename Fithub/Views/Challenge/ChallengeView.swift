import SwiftUI

struct ChallengeView: View {
    @StateObject private var viewModel = ChallengeViewModel()
    @State private var selectedType: ChallengeType = .distance
    @State private var goalValue: String = ""
    @State private var dueDate = Date()
    @State private var isShowingDatePicker = false
    
    static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter
        }()

    var body: some View {
        VStack {
            Picker("Select Challenge Type", selection: $selectedType) {
                Text("Distance(km)").tag(ChallengeType.distance)
                Text("Time(Hr)").tag(ChallengeType.time)
                Text("Calories(cal)").tag(ChallengeType.calorie)
            }.pickerStyle(SegmentedPickerStyle())
            
            TextField("Goal Value", text: $goalValue)
                .keyboardType(.numberPad) // Dismiss number keyboard when tapped outside
                .padding()
            
            Button(action: {
                isShowingDatePicker.toggle()
            }, label: {
                Text("Select Due Date")
            })
            .padding()
            
            if isShowingDatePicker {
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
            }
            
            Button("Add Challenge") {
                guard let goal = Int(goalValue) else {
                    print("Invalid goal value")
                    return
                }
                viewModel.addChallenge(type: selectedType, goalValue: goal, dueDate: dueDate)
                goalValue = "" // Reset goalValue after adding challenge
                isShowingDatePicker = false // Close date picker after adding challenge
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .padding()
            
            List(viewModel.challenges) { challenge in
                if let challengeId = challenge.id {
                    let remaining = Double(challenge.goalValue) - challenge.currentProgress
                    Text("Challenge: \(Int(challenge.goalValue)) \(unit(for: challenge.type)), Remaining: \(String(format: "%.2f", remaining)) \(unit(for: challenge.type)), Due Date: \(Self.dateFormatter.string(from: challenge.dueDate)), \(challenge.currentProgress)")
                        .swipeActions {
                            Button {
                                viewModel.delete(id: challengeId)
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                            .tint(.red)
                        }
                }
            }
        }
    }
    
    func unit(for type: ChallengeType) -> String {
        switch type {
        case .distance:
            return "km"
        case .time:
            return "Hr"
        case .calorie:
            return "cal"
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
