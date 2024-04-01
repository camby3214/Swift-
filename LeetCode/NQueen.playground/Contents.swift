func solveNQueen(_ n:Int) {
    var board = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    
    for i in 0..<n {
        backtrack(row: 0, col: i)
    }
    
    
    func backtrack(row: Int, col: Int) {
        if !isSafe(board: board, row: row, col: col) {
            return
        } else {
            board[row][col] = 1
        }
        if row < n-1 {
            for i in 0..<n {
                backtrack(row: row+1, col: i)
                
            }
        }else {
            print(board)
        }
        
        board[row][col] = 0
    }
}

func isSafe(board:[[Int]], row: Int,col: Int) -> Bool{
    // 檢查同一行
    for i in 0..<row {
        if board[i][col] == 1 {
            return false
        }
        
    }
    //  檢查左上
    var i = row-1
    var j = col-1
    
    while i>=0 && j>=0 {
        if board[i][j] == 1 {
            return false
        }
        i -= 1
        j -= 1
    }
    
    // 檢查右上
    i = row-1
    j = col+1
    
    while i>=0 && j<board.count {
        if board[i][j] == 1 {
            return false
        }
        i -= 1
        j += 1
    }
    return true
    
}
solveNQueen(4)
