import java.text.DecimalFormatSymbols;



public class Sender {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Coordenates c1 = new Coordenates(10,0,0,45);
		System.out.println(c1.toString());
		

		Coordenates c2 = new Coordenates();
		c2.fromString(c1.toString());
		System.out.println(c2.toString());
		
		
		/*String teste = "0.12345678901234567890";
		String t1 = teste.substring(0, 5);
		String t2 = teste.substring(6, 7);
		float t3 = Float.valueOf(t1);
		
		System.out.println(t1);
		System.out.println(t2);
		System.out.println(t3);*/
	}

}
