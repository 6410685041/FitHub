import Foundation
import FirebaseFirestore
import FirebaseAuth

class ChallengeViewModel: ObservableObject {
    @Published var challenges: [Challenge] = []
    private var db = Firestore.firestore()
    private var userChallengesPath: String
    private var userUID: String
    
    init() {
            guard let userUID = Auth.auth().currentUser?.uid else {
                fatalError("User not authenticated")
            }
            self.userUID = userUID
            self.userChallengesPath = "users/\(userUID)/challenges"
            self.fetchChallenges()
    }
    
    
    func fetchChallenges() {
        // Listen for real-time updates on the challenges collection
        db.collection(userChallengesPath)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No challenge documents found")
                    return
                }
                
                self?.challenges = documents.compactMap { document in
                    do {
                        return try document.data(as: Challenge.self)
                    } catch {
                        print("Error decoding challenge: \(error.localizedDescription)")
                        return nil
                    }
                }
            }
        
        // Listen for real-time updates on the activities collection
        db.collection("users/\(userUID)/activities")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No activity documents found")
                    return
                }
                
                // Decode activities and update challenges
                let activities: [Activity] = documents.compactMap { document in
                    do {
                        return try document.data(as: Activity.self)
                    } catch {
                        print("Error decoding activity: \(error.localizedDescription)")
                        return nil
                    }
                }
                
                // Update challenges based on activities
                self?.updateChallenges(with: activities)
            }
    }

    
    func updateChallenges(with activities: [Activity]) {
        for activity in activities {
            updateChallenge(with: activity)
        }
    }

    func updateChallenge(with activity: Activity) {
        for index in challenges.indices {
            var challenge = challenges[index]
            switch challenge.type {
            case .distance:
                challenges[index].currentProgress += activity.distance
            case .time:
                challenges[index].currentProgress += activity.duration / 60 // Convert duration to minutes
            case .calorie:
                challenges[index].currentProgress += activity.caloriesBurned
            }
        }
    }

    
    func addChallenge(type: ChallengeType, goalValue: Int, dueDate: Date) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        
        let newChallenge = Challenge(userId: userUID, type: type, goalValue: goalValue, currentProgress: 0, createDate: Date(), dueDate: dueDate)
        
        do {
            _ = try db.collection(userChallengesPath).addDocument(from: newChallenge) // Use userChallengesPath
        } catch {
            print("Error adding challenge: \(error.localizedDescription)")
        }
    }
    
    func delete(id: String) {
        db.collection(userChallengesPath).document(id).delete { error in // Use userChallengesPath
            if let error = error {
                print("Error deleting challenge: \(error.localizedDescription)")
            } else {
                print("Challenge deleted successfully")
            }
        }
    }
    
}
