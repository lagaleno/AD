dtmc 
// quesão 1.20
module heads
	// local state
	s: [0..3] init 0; // o estado guara quantas caras eu tenho seguidas
	// n conta quantas vezes a moeda jogada
	n: [0..20] init 0;

	// matriz de transição
	[] s=0 & (n<20) -> 0.5 : (s'=0) & (n'=n+1) + 0.5 : (s'=1) & (n'=n+1);
	[] s=1 & (n<20) -> 0.5 : (s'=0) & (n'=n+1) + 0.5 : (s'=2) & (n'=n+1);
	[] s=2 & (n<20) -> 0.5 : (s'=0) & (n'=n+1) + 0.5 : (s'=3) & (n'=n+1);
	[] s=3 & (n<20) -> (s'=3);
	
	[] n=20 -> (n'=20);

endmodule
	