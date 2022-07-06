class Assignment {
    
    // print fibonacci sequence with length n
    func fibonacci(n: Int) {
  	var fibSeq = [0, 1]
  	var i = fibSeq.count

  	if (n == 0) {
  	  print("Invalid")
  	} else if (n == 1) {
   	  print([0])
  	} else {
    	  while n > i {
      	    fibSeq.append(fibSeq[i - 2] + fibSeq[i - 1])
      	    i+=1
    	  }
    	  print(fibSeq)
  	}
    }		
}
