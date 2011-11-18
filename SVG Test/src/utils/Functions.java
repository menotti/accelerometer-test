package utils;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Vector;

public class Functions {
	
	private static final int HEIGHT = 200;
	private static final int WIDTH = 800;
	
	@SuppressWarnings("rawtypes")
	public Vector read(FileInputStream fstream, String tipo){
		if(tipo.equals("gps"))
			return readGPS(fstream);
		if(tipo.equals("acc"))
			return readAcc(fstream);
		return null;
	}
	
	public static Vector<Position> readGPS(FileInputStream fstream){
		try{
			DataInputStream in = new DataInputStream(fstream);
		  	BufferedReader br = new BufferedReader(new InputStreamReader(in));
		  	String strLine = br.readLine();
		  	
		  	Vector<Position> positions = new Vector<Position>();
		  	
		  	while ((strLine = br.readLine())!=null){
		  		double latitude = Double.valueOf(strLine.substring(0, 12).replace(',', '.'));
			  	double longitude = Double.valueOf(strLine.substring(12, 24).replace(',', '.'));
			  	double altitude = Double.valueOf(strLine.substring(24, 33).replace(',', '.'));
			  	float speed = Float.valueOf(strLine.substring(33,39).replace(',', '.'));
			  	long time = Long.valueOf(strLine.substring(56, 69));
			  	
			  	positions.add(new Position(latitude,longitude,altitude,speed,time));
		  	}
		  	return positions;
		} catch (Exception e){
			System.out.println(e.getMessage());
			return null;
		}
		
  		
	}
	
	@SuppressWarnings("rawtypes")
	public Vector readAcc(FileInputStream fstream){
		return null;
	}
	
	public static void normalizeGPS(Vector<Position> positions){
		
		double maxAltitude = positions.get(0).getAltitude();
		double minAltitude = positions.get(0).getAltitude();
		
		float maxSpeed = positions.get(0).getSpeed();
		float minSpeed = positions.get(0).getSpeed(); 
		
		for(int i=1;i<positions.size();i++)
		{
			double altitude = positions.get(i).getAltitude();
			float speed = positions.get(i).getSpeed();
			
			if(maxAltitude < altitude)
				maxAltitude = altitude;
			else if(minAltitude > altitude)
				minAltitude = altitude;
			
			if(maxSpeed < speed)
				maxSpeed = speed;
			else if(minSpeed > speed)
				minSpeed = speed;
		}
		
		int passo = WIDTH/positions.size();
		
		for(int i=0;i<positions.size();i++)
		{
			positions.get(i).setX(passo*i);
			
			double alt = positions.get(i).getAltitude();
			alt -= minAltitude;
			alt /= maxAltitude;
			alt *= HEIGHT;
			alt = HEIGHT - alt;
			positions.get(i).setyAltitude((int)alt);
			
			float vel = positions.get(i).getSpeed();
			vel -= minSpeed;
			vel /= maxSpeed;
			vel *= HEIGHT;
			vel = HEIGHT - vel;
			positions.get(i).setySpeed((int)vel);
		}
	}
}
