dtmc // modelo deterministico de Cadeia de Markov

//------------------------------------------------------
// Lista de Prefer�ncia
// homen (m) i prefere mulher (w) j acima de mulher k se mij>mik
// mulher (w) i prefere homem (h) j acima de homem k se wij>wik

// lista de prefer�ncia dos homens

// m1 : w2,w3,w1
const int m11=2;
const int m12=3;
const int m13=1;

// m2 : w1,w2,w3
const int m22=1;
const int m23=2;
const int m21=3;

// m3: w3, w1, w2
const int m33=3;
const int m31=1;
const int m32=2;

// lista de prefer�ncia para as mulheres

// w1 : m2,m3,m1
const int w12=2;
const int w13=3;
const int w11=1;

// w2 : m1,m2,m3
const int w23=1;
const int w21=2;
const int w22=3;

// w3 : m3,m1,m2
const int w31=3;
const int w32=1;
const int w33=2;

//------------------------------------------------------
// Constantes usadas no momento em que as prefer�ncias das mulheres ser�o levadas em considera��o
const int N1=1;
const int N2=2;
const int N3=3;

//------------------------------------------------------
// modelo usando o primeiro homem como exemplo
module man1

	// diz o atual casal do homem 1, se est� com 0 significa que est� solteiro
	m1 : [0..3];

	// mudar o casamento do homem 1
	[e11] m1=0 | (m1=1 & m11>m11)|(m1=2 & m11>m12)|(m1=3 & m11>m13) -> (m1'=1); // [e11] evento do homem 1 casar com a mulher 1
	[e12] m1=0 | (m1=1 & m12>m11)|(m1=2 & m12>m12)|(m1=3 & m12>m13) -> (m1'=2); // [e12] evento do homem 1 casar com a mulher 2
	[e13] m1=0 | (m1=1 & m13>m11)|(m1=2 & m13>m12)|(m1=3 & m13>m13) -> (m1'=3); // [e13] evento do homem 1 casar com a mulher 3
	
	// se ocorrer mudan�a no casamento do homem 1, checar os outros casamentos
	[e21] true -> (m1'=(m1=1)?0:m1); // condicional no PRISM: se (m1=1) for verdade m1' assume valor 0 se n�o segue no valor m1
	[e31] true -> (m1'=(m1=1)?0:m1);
	[e22] true -> (m1'=(m1=2)?0:m1);
	[e32] true -> (m1'=(m1=2)?0:m1);
	[e23] true -> (m1'=(m1=3)?0:m1);
	[e33] true -> (m1'=(m1=3)?0:m1);
	
endmodule

// a partir do m�dulo man1 crio man2 e man3, por�m substituindo as vari�veis para ficarem compat�veis
module man2=man1[m1=m2, m11=m21, e11=e21, e12=e22, e13=e23, m12=m22, e21=e31, e22=e32, e23=e33, m13=m23, e31=e11, e32=e12, e33=e13 ] endmodule
module man3=man1[m1=m3, m11=m31, e11=e31, e12=e32, e13=e33, m12=m32, e21=e11, e22=e12, e23=e13, m13=m33, e31=e21, e32=e22, e33=e23 ] endmodule

//------------------------------------------------------
// usando a primeira mulher como exemplo
module woman1

	// do not need to store the matching (can work it out from the men's variables)

	// o caso dos honmens quiserem trocar e teve empate, avaliar a priordade da mulher
	[e11] ( m1!=N1 & m2!=N1 & m3!=N1 ) | (m1=N1 & w11>w11)|(m2=N1 & w11>w12)|(m3=N1 & w11>w13) -> true;
	[e21] ( m1!=N1 & m2!=N1 & m3!=N1 ) | (m1=N1 & w12>w11)|(m2=N1 & w12>w12)|(m3=N1 & w12>w13) -> true;
	[e31] ( m1!=N1 & m2!=N1 & m3!=N1 ) | (m1=N1 & w13>w11)|(m2=N1 & w13>w12)|(m3=N1 & w13>w13) -> true;
	
endmodule

// a partir do m�dulo woman1 crio woman2 e woman3, por�m substituindo as vari�veis para ficarem compat�veis
module woman2=woman1[ N1=N2, w11=w21, e11=e12, e21=e22, e31=e32, w12=w22, e12=e13, e22=e23, e32=e33, w13=w23, e13=e11, e23=e21, e33=e31 ] endmodule
module woman3=woman1[ N1=N3, w11=w31, e11=e13, e21=e23, e31=e33, w12=w32, e12=e11, e22=e21, e32=e31, w13=w33, e13=e12, e23=e22, e33=e32 ] endmodule

//------------------------------------------------------
// reward structure: expected rounds
rewards "rounds"

	true : 1;
endrewards