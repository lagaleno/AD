dtmc
// questão 2.27
module gamblersRuin
	
	// estados que indicam quantidade de dinheiro
	s:[0..5] init 2;
	// n representa as jogadas
	n: [0..100] init 0;
	
	//matriz de transição
	[] s=0 & n<100 -> (s'=0);
	[] s=1 & n<100 -> 0.5 : (s'=0) & (n'=n+1) + 0.5 : (s'=2) & (n'=n+1);
	[] s=2 & n<100 -> 0.5 : (s'=1) & (n'=n+1) + 0.5 : (s'=3) & (n'=n+1);
	[] s=3 & n<100 -> 0.5 : (s'=2) & (n'=n+1) + 0.5 : (s'=4) & (n'=n+1); 
	[] s=4 & n<100 -> 0.5 : (s'=3) & (n'=n+1) + 0.5 : (s'=5) & (n'=n+1);
	[] s=5 & n<100 -> (s'=5);

	[] n=100 -> (n'=100);

endmodule