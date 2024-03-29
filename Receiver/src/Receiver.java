import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class Receiver {

	public static void main(String args[]){
		DatagramSocket socket;
		try{
			if (args.length > 0)
				socket = new DatagramSocket(Integer.parseInt(args[0]));
			else
				socket = new DatagramSocket(888);
			System.out.println("Listening on UDP port " + socket.getLocalPort());
			
			FileWriter writer = new FileWriter(new File("saida.txt"),false);
			PrintWriter saida = new PrintWriter(writer);
			
			int n = 0;
			while(n++<1000){
				byte[] buffer = "12345678901234567890123456789012345678901234".getBytes();

				DatagramPacket receive = new DatagramPacket(buffer, buffer.length);
				socket.receive(receive);
				
				Coordenates c = new Coordenates();
				c.fromString(new String(buffer));
				
				System.out.println("x = " + c.getX() +
								   " y = " + c.getY() +
								   " z = " + c.getZ() +
								   " timestamp = " + c.getTimestamp());
				
				saida.println(c.getXvirgula()+"\t" + c.getYvirgula() + "\t" + c.getZvirgula());
			}
			saida.close();  
			writer.close();
		}
		catch(Exception e){
			System.out.println("Excecao - " + e.getMessage());
		}
	}
}
