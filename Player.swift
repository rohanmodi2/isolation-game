import Foundation

class Player: ObservableObject {
    var disp = String()
    var lastPosition = [Int]()
    var numberMoves = 0
    var curPos = [-1, -1]
    
    /**
     * Initializes Player object with disp = name.
     */
    init(name: String) {
        disp = name
    }
}
