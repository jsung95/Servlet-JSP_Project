package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import kr.ac.woosuk.computereng.models.AttachFileDTO;

public class AttachFileDao {

	private String driverName;
	private String url;
	private String username;
	private String password;
	
	public AttachFileDao() {
		this.driverName = "com.mysql.cj.jdbc.Driver";
		this.url = "jdbc:mysql://127.0.0.1:3306/woosuk?useSSL=false&characterEncoding=UTF-8&serverTimezone=UTC";
		this.username = "root";
		this.password = "1111";
		try {
			Class.forName(this.driverName);
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private Connection getConnection() throws SQLException, ClassNotFoundException {
		return DriverManager.getConnection(this.url, this.username, this.password);
	}
	
	
	public void insertachfile(AttachFileDTO attachfile) {
		Connection conn = null;
		Statement stmt = null;
		
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
			
			String sql = "INSERT INTO ATTACH_FILE (ID, PATH, ORIGINAL_FILE_NAME, SAVE_FILE_NAME) VALUES"
					+"("+attachfile.getIdx()+",'" 
					+ attachfile.getPath()+"','"
					+ attachfile.getOriginalFileName()+"','"
					+ attachfile.getSaveFileName()+"')";
			stmt.executeUpdate(sql);
		}
		catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public AttachFileDTO selectFile() {
		
		AttachFileDTO attachfile = new AttachFileDTO();
		
		Connection conn = null;
		Statement stmt = null;
		
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
			
			String sql = "SELECT ID, PATH, ORIGINAL_FILE_NAME, SAVE_FILE_NAME FROM ATTACH_FILE";
			ResultSet resultSet = stmt.executeQuery(sql);
			
			while(resultSet.next()) {
				
				attachfile.setIdx(resultSet.getInt("ID"));
				attachfile.setPath(resultSet.getString("PATH"));
				attachfile.setOriginalFileName(resultSet.getString("ORIGINAL_FILE_NAME"));
				attachfile.setSaveFileName(resultSet.getString("SAVE_FILE_NAME"));		
			}
		}
		catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
		return attachfile;
	}
	
}