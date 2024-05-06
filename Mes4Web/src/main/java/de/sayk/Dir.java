package de.sayk;

public class Dir {
	private static String OS = System.getProperty("os.name").toLowerCase();

	public static String getHomePath() {
		
		if (OS.contains("win"))
			return "C:\\MES4WEB\\";

		return "/opt/mes4web/";
	}

	public static void main(String[] args) {
		System.out.println(Dir.getHomePath());
	}
}
