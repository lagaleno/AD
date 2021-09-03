dtmc

// Para a quest�o:
// k = 2;
// p 1/3, logo q = 2/3;
// n = 6;

const double p = 1/3;
const double q = 2/3;

module gamblersRuin
	
	// estados que indicam quantidade de dinheiro
	s:[0..6] init 2;
	
	//matriz de transi��o
	[] s=0 -> (s'=0);
	[] s=1 -> q : (s'=0) + p : (s'=2);
	[] s=2 -> q : (s'=1) + p : (s'=3);
	[] s=3 -> q : (s'=2) + p : (s'=4); 
	[] s=4 -> q : (s'=3) + p : (s'=5);
	[] s=5 -> q : (s'=4) + p : (s'=6);
	[] s=6 -> (s'=6);

endmodule
